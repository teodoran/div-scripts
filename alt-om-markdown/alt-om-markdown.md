Alt om Markdown _(Nesten)_
==========================

Markeringsspråk for formattering av tekst. Opprinnelig påtenkt generering av HTML.

Funnet opp av [John Gruber](https://daringfireball.net/projects/markdown/) i 2004.

Først litt om overskrifter:

# Størst
## Nest størst
### og
#### så
##### videre
###### minst

Alternativt kan de to største overskriftene indikeres sånn:

Dette er også størst
====================

Dette er også nest størst
-------------------------

Men det er ikke bare størrelse man kan styre...

Fet og kursiv tekst
-------------------

Denne teksten er *kursiv* (Det er også _denne teksten_)

Denne teksten er **fet**

Denne teksten er både **fet og _kursiv_**

(~~Jeg tror vi dropper dette~~)

Lister
------

Lister kan være nummererte:

1. Is
2. Kake
3. Kaffe

... og unummererte:

* Bygg
* Deploy

Eller i flere nivåer!

1. Først bygg
    * Is
    * Kake
2. Så deploy
    * Kaffe

Hyperlenker
-----------
Jeg er en [lenke](https://www.google.com)

Jeg er en [lenke som er en referanse][1]

[1]: https://news.ycombinator.com/

Bilder
------

![tekst til skjermlesere](markdown.png)

Kodeeksempler
-------------

Her er en liten kodesnutt:

```fsharp
let drop = function
    | Stack (_, r) -> r
    | Empty -> push (Exception StackUnderflow) Empty
```

```
[| [swap dup rot swap ||] rot || ||] succ #
```

Noen ganger vil jeg ha litt `var kode = true` inni teksten.

Tabeller
--------

| ID | Navn |
|:--:|------|
| 1  | Petter |
| 2  | Pia  |

> Noen spørsmål så langt?

<marquee>Visste du at man kan skrive HTML i markdown-filer?</marquee>

