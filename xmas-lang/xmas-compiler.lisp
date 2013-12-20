; XMASLANG spesifikasjon
; xmaslang er et programmeringsspråk for manipulering av tall og sekvenser av tall. Det er funksjonsbasert, og et xmaslang-program består av ett eller flere uttrykk som igjen kan være bygget opp av uttrykk.

; Datatyper
; xmaslang har fire grunnleggende datatyper:

; integer
; 0, negative heltall og positive heltall. En integer er et uttrykk, og 42 er et eksempel på et gyldig xmaslang-program.
; Negativ integer kan ikke uttrykkes direkte i språket, men kan skapes gjennom et uttrykk. For eksempel kan man uttrykke -1 som - 0 1 (se numeriske operasjoner).

; boolean
; Representerer sannhet og falskhet. En boolsk verdi kan ikke uttrykkes direkte i kode, men skapes gjennom et uttrykk som for eksempel > 2 1 (se sammenligning).

; function
; Funksjoner i xmaslang har alltid en og bare en formell parameter, og kroppen består av ett uttrykk. Når funksjonen evalueres med et argument settes parameterets verdi lik argumentets verdi, og kroppen evalueres. Resultatet blir verdien til funksjonen.

; Et eksempel på en deklarert funksjon:
; < arg arg >
; Definisjonen startes av et mindre enn-tegn. Dette etterfølges av en identifikator som blir navnet på parameteret. Deretter følger kroppen, som kan være hvilket som helst uttrykk. I dette tilfelet evalueres kroppen bare til parameteren; dette er altså funksjonen man kaller "identity". Definisjonen avsluttes med et større enn-tegn.

; Bruk av whitespace (mellomrom, tabulator, linjeskift) for å skille elementene i en funksjonsdefinisjon er valgfritt, såfremt bortfall av whitespace ikke gjør koden tvetydig. Dette gjelder også i xmaslang-kode generelt, og gjør at man står veldig fritt til hvordan man vil formatere koden.
; En identifikator kan bestå av alle bokstaver fra a til z samt bindestrek (-). Det er denne bindestreken som ofte kan gjøre koden tvetydig, siden tegnet også brukes i andre operasjoner.

; < arg body > -> (lambda (arg) body)

; list
; En liste er en sekvens av integer, boolean, function eller andre lister. En liste kan ikke uttrykkes direkte, men skapes gjennom den spesielle range-funksjonen.

; #10
; I eksempelet over skapes en liste som starter på 0 og slutter på 10. Den inneholder altså 11 elementer. For å lage lister som ikke starter på 0 eller som gjør noe annet enn å inkrementere verdien med 1 for hvert element må man bruke listeoperasjonene map, filter og reduce (se operasjoner på lister).

; #10 -> (H 10)

(defun H (len)
	(loop for i from 0 to len
       collect i))

; Numeriske operasjoner
; xmaslang støtter de numerikse operasjonene +, -, *, / og % (modulo) som man kan forvente. Operatorene er prefix, og du har sett eksempler på dette allerede.

; + -> (+ ...)
; - -> (- ...)
; * -> (* ...)
; / -> (/ ...)
; % -> (% ...)

; PS: Hva som skjer om man gjør en divisjon som ikke resulterer i en integer er ikke definert.

; Sammenligning
; xmaslang støtter to operasjoner for sammenligning, og de kan brukes om argumentene er uttrykk som evaluerer til enten integer eller boolean. Operasjonene er = (likhet) og > (større enn).

; = -> (= ...)
; > -> (> ...)

; If/else
; xmaslang har kun én operator for å endre programflyten, og det er ?.

; ? > 1 0 2 3
; ? etterfølges alltid av tre uttrykk. Det første (> 1 2) må være et boolsk uttrykk. Hvis dette uttrykket evaluerer til sannhet, brukes uttrykk nummer 2 som resultat. Hvis ikke brukes uttrykk nummer 3. Resultatet av uttrykket over blir derfor tallet 2.

(defun ? (bool opt1 opt2)
	(if bool opt1 opt2))

; ? - > (? ...)

; Applikasjon av funksjoner
; En funksjon kan applikeres - i andre språk kaller man det gjerne å "kalle" funksjonen. Her er et par eksempler:

; < x + x x >[1]
; Her har vi et funksjonsuttrykk etterfulgt av en firkantklamme, et nytt uttrykk (1) og en avsluttende firkantklamme. Hele uttrykket vil evalueres som funksjonen hvor 1 er argumentet. Funksjonens kropp er + x x, og funksjonsapplikasjonen blir dermed tallet 2.

; < ... >[1] -> (funcall < ... > 1)


; Pipe operator
; | 10 <x + x 1>
; Pipe gir deg muligheten for å strukturere koden slik at argumentet kommer før funksjonsuttrykket. Uttrykket starter med |, etterfulgt av et uttrykk, etterfulgt av en funksjonsdeklerasjon. Resultatet av uttrykket over blir 11.

; | 10 < ... > -> (funcall < ... > 10)

; Merk at uttrykket også kan skrives slik: |10<x+x1>. Whitespace er kun nødvendig når man ellers får tvetydighet i xmaslang, og kode som dette er vanlig å se.

; Operasjoner på lister
; Map
; Map-operatoren er ->, og brukes til å transformere en liste. Den etterfølges først av et uttrykk et som må evaluere til en liste, og så en funksjonsdefinisjon.

; -> #5 <x * x x>
; Uttrykket over mapper elementene i listen 0,1,2,3,4,5 med en funksjon som ganger et tall med seg selv. Hele uttrykket evaluerer derfor til listen 0,1,4,9,16,25.

; Filter
; Filter-operatoren er =?, og brukes til å filtrere en liste basert på resultatet av en predikatfunksjon.

; =? #5 <x =5x>
; I eksempelet over filtreres en liste fra 0 til 5 med en funksjon som sjekker om argumentet er lik 5. Resultatet blir dermed en liste som kun inneholder ett element - tallet 5.

; Reduce
; Den siste operatoren er godt kjent fra funksjonelle språk, og brukes til å redusere en liste til én verdi (som forsåvidt også kan være en liste).

; $ #5 acc 0 <x + acc x>
; $ etterfølges først av et uttrykk som må evaluere til en liste. Deretter følger en identifikator som vil være navnet på akkumulator-variabelen. Nest sist følger et uttrykk som vil være den initielle verdien av akkumulatoren, og til slutt følger en funksjonsdefinisjon som vil bli evaluert for hvert element i listen. Denne funksjonen vil ha tilgang på akkumulatoren, og akkumulatoren vil hele tiden oppdateres med det funksjonen evalueres til.

; Eksempelet over summerer rett og slett elementene i listen #5, og gir resultatet 15 (0+0+1+2+3+4+5).