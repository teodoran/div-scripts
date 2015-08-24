open System
open System.IO
open System.Collections.Generic
open System.Security.Cryptography

let rec print list =
    match list with
    | [] -> ()
    | head :: tail ->
        printfn "duplicates:"
        printLine head
        print tail

and printLine list =
    match list with
    | [] -> ()
    | head :: tail ->
        printfn "    %s" head
        printLine tail

let isLong string =
    let couldParse, value = Int64.TryParse(string)
    couldParse

let appendValueToKey (dict:Dictionary<string, string list>) key value =
    if dict.ContainsKey(key) then
        let l = value :: dict.[key]
        dict.Remove(key) |> ignore
        dict.Add(key, l)
    else dict.Add(key, [value])

let hash filePath =
    let fileData = File.ReadAllBytes(filePath)
    let hashBytes = MD5.Create().ComputeHash(fileData)
    System.BitConverter.ToString(hashBytes)

let isSmallerThan (size:int64) filePath =
    let file = new FileInfo(filePath)
    file.Length < size

// Loaned from http://rosettacode.org/wiki/Walk_a_directory/Recursively
let rec findAllFiles startDir =
    seq {
        yield! Directory.EnumerateFiles(startDir)
        for d in Directory.EnumerateDirectories(startDir) do
            yield! findAllFiles d
    }

let rec allBytesEqual (streamA:FileStream) (streamB:FileStream) =
    match streamA.ReadByte(), streamB.ReadByte() with
    | -1, -1 -> true
    | _, -1 -> true
    | -1, _ -> true
    | a, b when a <> b -> false
    | _ -> allBytesEqual streamA streamB

let isEqual pathA pathB =
    use streamA = File.OpenRead(pathA)
    use streamB = File.OpenRead(pathB)
    allBytesEqual streamA streamB

let rec duplicates equal list =
    match (duplOfFirst equal [] [] list) with
    | ([], []) -> []
    | ([], others) -> duplicates equal others
    | (dupls, others) -> dupls :: duplicates equal others

and duplOfFirst equal others dupls list =
    match list with
    | [] -> (dupls, others)
    | first :: rest -> 
        match rest with
        | [] -> ((first :: dupls), others)
        | second :: tail ->
            match first with            
            | first when (equal first second) -> duplOfFirst equal others (second :: dupls) (first :: tail)
            | _ -> duplOfFirst equal (second :: others) dupls (first :: tail)

let possibleDuplicates fileSize startDir =
    let dict = new Dictionary<string, string list>()

    findAllFiles startDir
    |> Seq.filter (fun filePath -> isSmallerThan fileSize filePath)
    |> Seq.iter (fun filePath -> appendValueToKey dict (hash filePath) filePath)

    dict.Values
    |> Seq.filter (fun filePaths -> List.length filePaths > 1)

let duplicateFileRemover fileSize startDir =
    possibleDuplicates fileSize startDir
    |> Seq.collect (fun dupls -> duplicates isEqual dupls)
    |> Seq.toList
    |> print

[<EntryPoint>]
let main args =
    let nl = Environment.NewLine

    match Array.length args >= 2 with
    | false -> printfn "usage: dfr <size_in_bytes> <path_to_folder>%s\
                        <size_in_bytes>: size of largest file to consider when searching%s\
                        <path_to_folder>: location of the folder to search from%s" nl nl nl
    | _ ->
        match isLong args.[0], Directory.Exists(args.[1]) with
        | _, false -> printfn "The folder %s does not exist" args.[1]
        | false, _ -> printfn "%s is not an integer" args.[0]
        | true, true ->
            duplicateFileRemover (Int64.Parse(args.[0])) args.[1]
            printfn "done"
    0