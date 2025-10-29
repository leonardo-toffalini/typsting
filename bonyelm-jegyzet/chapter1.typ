#import "@preview/thmbox:0.3.0": *
#import "@preview/pavemat:0.2.0": pavemat
#show: thmbox-init()

= Kommunikációs játékok
#text(red)[
  *Ennek a fejezetnek a nagy resze (majdnem minden) a
  szamitastudomany jegyzetbol lett atemelve.*
]

#text(red)[
  *Ezt a fejezetet ujra kell olvasni es megnezni mekkora az atfedes a
  szamitastudomanyon elhangzottak es a bonyelm-en elhangzottak kozott. A fo
  tetelek megtalahatok bizonyitasokkal: Teglalap fedes, Mehlhorn--Schmidt,
  AUY*
]

Cél: van két játékos, akik bármit ki tudnak számolni gyorsan, de egymás között nehezen kommunikálnak.

// "Ez nem egy olyan valóságtól elrugaszkdott feltevés, hogy lokálisan mindent ki tudnak számolni. Hát az, hogy lokálisan mindent ki tudnak számolni, az elég elrugaszkodott feltevés."
// I'm dying because of those sentences.

#definition[Kommunikációs játék][
  Adott $f: {0,1}^n times {0,1}^n -> {0,1}$ és $x, y in {0,1}^n$. A ismeri
  $x$-et, de $y$-t nem, B ismeri $y$-t, de $x$-et nem. Ki akarják számolni
  $f(x, y)$-t. A költség az A és B között (bármely irányban) kommunikált bitek
  száma.

  Akkor tekintjük $f(x,y)$-t kiszámoltnak, ha az egyik játékos ismeri
  $f(x,y)$-t, és a másik játékos tudja, hogy az egyik tudja.
]

#definition[Protokoll költsége][
  A $P$ protokoll mellett $f$ költsége a legrosszabb $(x, y)$ input páron
  $kappa_P(f)$.
]

#remark[
  Megkövetelhetnénk, hogy mindketten tudják $f(x,y)$-t, ez 1 bit különbséget
  jelentene csak legfeljebb.
]

#definition[Protokoll][
  A közös számolási módszer szabályait, hogy mikor ki, és milyen bitet küld
  protokollnak nevezzük. (Ez az algoritmus megfelelője több játékos esetén.)
]


#example[
  Legyen $f$ tetszőleges, ekkor A elküldheti $x$-et B-nek, aki ,,ingyen''
  kiszámolja $f(x,y)$-t. Ennek a költsége $n$.
]

#example[ID-függvény][
  Legyen
  $
    "ID"(x, y) = cases(
      1\, & "ha" x = y,
      0\, & "ha" x != y
    )
  $
  Ekkor a fenti $P$ protokollal $kappa_P ("ID") = n$ teljesül.
]

#definition[Kommunikációs bonyolultság][
  $kappa(f)$ a $kappa_P (f)$-ek minimuma az összes $f$-et kiszámoló $P$
  protokollon.  
]

#theorem[
  $
    kappa("ID") = n.
  $
]

Ennek a bizonyításához kell a következő definíció és tétel.

#definition[Kommunikációs mátrix][
  Az $f$ kommunikációs mátrixa az az $M_f in \{0,1\}^(2^n times 2^n)$, amelynek
  sorai $x$-szel, oszlopai $y$-nal vannak indexelve, és az $x$-hez tartozó sor
  $y$-hoz tartozó oszlopában $f(x,y)$ szerepel.
]

#remark[
    A továbbiakban a $log$ mindig a 2-es alapú logaritmust jelenti.
]

#theorem[Mehlhorn--Schmidt][
    $kappa(f) >= log r(M_f)$, ahol $r(M_f)$ az $M_f$ mátrix rangját jelöli.
]

#proof[
  Legyen $P$ egy adott protokoll. Tegyük fel, hogy A kezd. Ekkor A kommunikál
  egy bitet. Ez rögzített $P$ protokoll mellett bizonyos $x$-ekre 0, bizonyos
  $x$-ekre 1. Ezzel az $M_f$ mátrixot két részre bontja: az egyik részben azon
  sorok vannak, amelyekre 0-t mond, a másikban azok, amelyekre 1-et. Ezek közül
  az egyik sorrangja $>= 1/2 (M_f)$.

  Ezt ismételjük addig, amíg A lép. Amikor B lép, akkor ugyanez elismételhető
  oszloprangra, de egy mátrix sor- és oszloprangja megegyezik. Ha $x$ és $y$
  olyan, hogy minden lépésnél a nagyobb rangú részmátrixot adják meg, akkor $k$
  lépés után a részmátrix rangja $>= 2^(-k) r (M_f)$.

  Tegyük fel, hogy a $k$. lépésben vége van a játéknak. Ekkor
  szimmetriaokokból feltehető, hogy A tudja $f(x,y)$-t, és B tudja, hogy A
  tudja. Mivel A tudja $f(x,y)$-t, az így kapott részmátrix minden sora
  homogén, azaz vagy csupa 0-t, vagy csupa 1-et tartalmaz. Ha pedig egy sor nem
  homogén, akkor A nem tudhatja biztosan $f(x,y)$-t. Hasonlóan, az, hogy B
  tudja biztosan $f(x,y)$-t, az azzal ekvivalens, hogy a kapott részmátrix
  minden oszlopa homogén.

  Mivel homogén részmátrix rangja 1, az előbbi egyenlőtlenség szerint $1 >=
  2^(-k) r(M_f)$, azaz $2^k >= r(M_f)$ fog teljesülni minden olyan $(x,y)$
  párra, amelyeket $P$ $k$ lépésben számol ki.
]

#corollary[
  Innen könnyen kijön, hogy $kappa("ID") = n$, ugyanis $M_("ID") = I_(2^n)$, és
  $r(I_(2^n)) = 2^n$, tehát $n <= kappa("ID")$ a Mehlhorn--Schmidt-tétel miatt.
  Másrészt láttuk, hogy $kappa(f) <= n$ minden $f$-re, így $kappa("ID") = n$.
]

#remark[
  Felső becslés nem ismeretes $kappa(f)$-re. Lovász és Suchs nevéhez fűződő
  sejtés szerint $exists c > 0 : kappa(f) <= log^c (r(M_f))$. Tudjuk, hogy $c >
  2$ kell hogy teljesüljön. Ismert továbbá, hogy $kappa(f) <= r(M_f)$.
]

#corollary[
  $"DISJ"(x,y) = chi_{x dot y=0}$, a halmazdiszjunktsági feladat. Akkor erre
  is $kappa("DISJ") = n$.
]

#proof[Corollary][
  Elemszám szerint rendezve az $n$ elemű halmaz részhalmazait a sorokban, és
  a komplementereiket az oszlopokban 
    $
    M_("DISJ")=
    mat(
      1, *, *, dots;
      0, 1, *, dots;
      0, 0, 1, dots;
      dots.v, dots.v, dots.v, dots.down;
      delim: "["
    )
    $
    felsőháromszög alakú, vagyis $kappa("DISJ") = n$
]

// E.T. belebeszél a telefonba mi történik itt
// E.T. mindenható

#definition[Nemdeterminisztikus kommunikációs bonyolultság][
  Alíz ismeri $x$-et, Bob ismeri $y$-t, E.T. ismeri mindkettőt, és $f$-et is.
  Utóbbi meg akarja győzni a játékosokat, hogy tudja. Ezt egy bizonyítással
  teszi, amit függetlenül A-nak, és B-nek is el kell fogadnia.
  Egy fix E.T. által az $(x,y)$ párra adott bizonyítás hossza, amikor azt
  akarja bizonyítani, hogy $f(x,y)=1$ legyen $kappa^"E.T."_1 (f(x,y))$.
  Legyen továbbá $
    kappa_1^"E.T." (f) := max_{x,y : f(x,y) = 1} kappa^"E.T."_1
  (f(x,y)),
  $ végül $
    kappa_1 (f) = min_"E.T." kappa_1^"E.T." (f)
  $ a legjobb E.T.
  által a legrosszabb esetben adott bizonyítás hossza.
  Hasonlóan definiáljuk a $kappa_0(f)$-et is.
]
#remark[
  $max kappa_0 (f)\, kappa_1 (f) <= kappa(f)$ teljesül, hiszen
  reprodukálhatja az adott esetben a protokoll által megszabott kommunikációját
]

#example[
  Ha $x != y$, akkor az $(i, x_i=0)$ pár (ahol $y_i=1$) megadása $log(n) + 1$
  bit hosszú, és bizonyítja, hogy az $"ID"$ feladat nem teljesül. Egyenlőségre
  nem látszik kapásból hasonló jó bizonyítás.
]

#theorem[Az ND kommunikációs bonyolultság jellemzése fedő téglalapokkal][
  $kappa_1(f)$ az a legkisebb $t$ szám, hogy $M_f$ egyesei lefedhetők $2^t$
  darab csupa 1-es részmátrixxal
]

#remark[
  $M_f$-et már ismerjük, a kommunikációs mátrix. A tételben részmátrix alatt
  az oszlopok, és sorok egy-egy részhalmazait kiválasztva, a metszetekből álló
  részt értjük. Figyelem, ez nem feltétlenül egy összefüggő téglalap! 
  $
  mat(
    1,0,1;
    0,0,0;
    1,0,1;
  delim: "["
  )
  $
  -ben az első és utolsó sor, és oszlopok által meghatározott rész is egy ilyen
  csupa egyes részmátrix.
]

#corollary[
  Láttuk, hogy $M_"ID" = I_(2^n)$, ezt pedig csak úgy fedhetjük le csupa 1-es
  téglalapokkal, ha külön-külön kiválasztjuk az átlóelemeket.
  Következik, hogy $kappa_1 ("ID") = n$.
]

#proof[Az ND kommunikációs bonyolultság jellemzése fedő téglalapokkal][

  *($kappa_1 (f) <= t$)*

  Tekintsük a fedő téglalapokat.
  Alíznak van egy sora, Bobnak egy oszlopa.
  A protokollban megállapodnak a $2^t$ darab fedőmátrix egy sorrendjében.
  E.T. bizonyítása az lesz, hogy hanyadik részmátrixban van az $(x,y)$ metszet,
  ez $t$ bittel kódolható, leellenőrzik, hogy benne van-e az adatuk, és mivel
  ez csupa egyesből áll, így szükségszerűen $f(x,y)=1$. %feltesszük, hogy E.T.
  nem hazudik?

  *($kappa_1 (f) >= t$)*

  Legyen $
  H_alpha = {(x,y): "A-nál" x", B-nél" y" van, és "alpha" üzenetet hallják, akkor elfogadják a bizonyítást"}.
  $
  Ha $(x_1, y_1),(x_2, y_2) in H_alpha$, akkor $(x_1,y_2), (x_2,y_1) in
  H_alpha$, hiszen az $alpha$ bizonyítást Alíz elfogadta $(x_1,y_1)$-re, az ő
  nézőpontjából semmi nem különbözteti meg a szituációt attól, mintha
  $(x_1,y_2)$ lenne a felállás, ezt pedig Bob is elfogadja, hiszen számára
  $(x_1,y_2)$, és $(x_2,y_2)$ ugyanolyan, és ez utóbbit elfogadta $alpha$-ra.
  Következik, hogy minden $alpha$-ra $H_alpha$ megfelel egy részmátrixnak.
  Ha E.T. legfeljebb $t$ bitből bizonyítani tudja, hogy $f(x,y)=1$, ez
  szolgáltat lazannyát és $2^t$ darab csupa egyes részmátrixot.
]

Randomizálva azonban gyorsan is lehet a következő Simon és Rabin nevéhez fűződő
protokollal.
A generál egy véletlen $p$ prímet $in {1,..,n^2}$ (ahol $log x,log y <= n$), és
elküldi az $(x mod p, p)$ üzenetet, B pedig leellenőrzi, hogy $x equiv y mod p$
teljesül-e, és ezt mondjuk százszor megismétlik.

Ha egyszer is az teljesül, hogy inkongruensek, akkor az eredeti számok sem
lehettek egyenlőek, ha mindig kongruensek, és mégsem egyenlőek, akkor százszor
teljesült az, hogy $p|x-y != 0$.

A $<= 2^n$ számoknak legfeljebb n darab prímosztója lehet, és $n^2$-ig nagyjából $pi(n^2) ~ (n^2)/(2 log(n))$ darab prím van.
Annak a valószínűsége, hogy egyszer teljesül a kongruencia 
$
PP(p|x-y) <= (n)/((n^2)/(2 log(n))) = (2 log n)/(n) -> 0.
$
Egy kommunikáció $4 log n$ bitet küld, ergo összesen $400 log n$ bitnyi kommunikáció történik.

*Nem (teljesen) triviális protokollok:*
#example[
  Tekintsünk egy fagráfot, aminek van két részfája.
  Kérdés, hogy az $n$ csúcsú $T$ fa $T_1,T_2$ részfáinak van-e közös csúcsa.
  Alíz kapja $T_1$-et, Bob $T_2$-t értelemszerűen, és mindketten ismerik $T$-t.
  Ez eldönthető lenne a $"DISJ"$ játék speciális eseteként, de adunk egy
  okosabb protokollt.

  Alíz megmondja $T_1$ egy tetszőleges $v$ csúcsát (ez ugye $log n$ bit
  kommunikáció).
  Majd Bob kiszámolja $T_2$-ben a $v$-hez legközelebbi $w$ csúcsot, mivel fában
  egyértelmű út van két csúcs között, ez értelmes.
  Ezt visszaküldi Alíznak, ellenőrzi, hogy $w in T_1$, ha igen, ez metszetbeli,
  és készen vagyunk, ha nem, akkor azt mondja, hogy a két fa diszjunkt.
  Ugyanis, ha a legközelebbi $w$ pont nem része a fának, de egy további $u$
  pont része lenne $T_1$-nek, az $u w$ szakasz $T_2$-ben van, az $u v$ szakasz
  pedig $T_1$-ben, vagyis $u$ közelebb van $v$-hez, mint $w$.
]

#example[
  Most Alíz és Bob két részgráfot kap egy $G$ gráfból úgy, hogy $G_A$ független
  csúcsokból áll, $G_B$ pedig egy teljes részgráf.
  Kérdés, hogy van-e metszet?

  Világos, hogy ha van, legfeljebb 1 pontból állhat.

  + Alíz megnézi, hogy van-e legalább $n/2$ fokú $v$ csúcs a gráfjában, ha igen, akkor $(1,v)$-t küldi el, ha nem, $0$-t.
  + Bob megnézi, hogy van-e $<n/2$ fokú $w$ csúcs $G_B$-ben, ha igen, $(1,w)$-t küld, ha nincs, $0$-t.
  
  Ezek után Bob tudja, hogy $G_A$ $v$-ből, és a nem-szomszédaiból áll, ez
  legfeljebb $n/2$ csúcsból áll, és iteratíven folytathatjuk ezt az eljárást
  amíg lehet.
  Ha Bob talál egy kis fokszámú $w$ csúcsot, akkor az ő gráfjának a többi
  csúcsa ennek a szomszédai közül kerül ki, és ismét rekurzíven folytatható az
  eljárás.
  Mi történik, ha mindketten $0$-t küldenek?
  Alíz gráfjában minden csúcs kisebb mint $n/2$ fokú, $G_B$-ben pedig minden
  csúcs legalább $n/2$ fokú, ez a két feltétel kizárja egymást, így a két gráf
  diszjunkt.
  Addig ismételgetik a fenti lépést, amíg nem mondanak mindketten nullát.
  Egy lépés $log n+1$ bit, és $log n$ lépésben persze kimerítik a gráfot,
  vagyis $O(log^2 n)$ bitre van összesen szükség.
]

#theorem[Aho--Ullman--Yanakakis][
  Minden $f$-re 
  $
  kappa(f) <= (2 + kappa_0 (f))(2 + kappa_1 (f)).
  $
]
#lemma[
  Ha $M$ egy $0-1$ mátrix, $H$ egy azonosan nulla részmátrixa, $H$ sorai
  alkossák az $A$, oszlopai a $B$ mátrixot, ekkor $rho(A) + rho(B) <= rho(M)$,
  ahol $rho(M)$ a sor/oszloppermutációval képezhető legnagyobb négyzetes
  felsőháromszög részmátrix méretét jelölli, aminek a főátlója csupa 1-ből áll.
]

#proof[Lemma][
  A lemma azon múlik, hogy $A$ és $B$-t külön-külön mozgathatjuk, a csupa
  nulla metszet nem fog változni, és a másik mátrixhoz nem nyúltunk hozzá,
  diszjunkt sorokból/oszlopokból áll.
  Egy permutációval megfelelő helyre visszük $A$-ban a maximális $U_A$
  felsőháromszög mátrixot, ezt $B$-ben is elvégezve ($U_B$) kapunk egy 
  $mat(
    U_B, ;
    0, U_A;
    delim: "["
  )$ 
  felsőháromszöget $M$-ben.

  $
  #pavemat(
    $ mat(
         , B_1,    ;
      A_1,   0, A_2;
         , B_2,    ;
      delim: "["
    ) $,
    pave: (
      (path: "SSDWWWASDDSAAAWD", from: (1, 1)),
    ),
    fills: (
      "1-0": red.transparentize(80%),
      "1-1": gray.transparentize(80%),
      "0-1": blue.transparentize(80%),
      "1-2": green.transparentize(80%),
      "2-1": purple.transparentize(80%),
    ),
  )

  ->

  #pavemat(
  $
  mat(
          , B_1, B_1,    , ;
          , B_1, U_B,    , ;
       A_1,   0,   0, U_A, A_2 ;
       A_1,   0,   0, A_2, A_2 ;
          , B_2, B_2,    , ;
    delim: "["
  )
  $,
    pave: (
      (path: "SSSDDWWWWWAASSDDDDSSAAAAAWWDD", from: (2, 1)),
    ),
    fills: (
      "2-0": red.transparentize(80%),
      "2-2": gray.transparentize(80%),
      "0-1": blue.transparentize(80%),
      "3-4": green.transparentize(80%),
      "4-1": purple.transparentize(80%),
    ),
  )
  $
  // High effort OC mátrixok <3
]

#proof[Aho--Ullman--Yanakakis][
  Világos, hogy $rho(M_f) <= r(M_f)$, és $log rho(M_f) <= kappa_1(f)$
  teljesülnek, mert egy csupa 1 főátlójú felsőháromszög mátrix teljes rangú,
  illetve \ref{NDKB jell} miatt.

  Indukcióval belátjuk, hogy $kappa(f) <= (2 + log rho(M_f))(2 + kappa_0 (f))$.
  Ha $rho(M_f) = 1$, akkor nem is kell kommunikálni, mert egy ilen mátrixban
  vagy csak egyesek állnak, vagy pontosan egy sorában vagy oszlopában vannak
  egyesek.
  Az általános lépésben tekintsük a kommunikációs mátrix nullásainak a fedését
  $2^(kappa_0 (f))$ darab csupa nulla részmátrixszal.
  Alíz megnézi, hogy fedi-e az ő $x$ inputjának egy részét olyan csupa 0
  részmátrix, hogy a hozzá tartozó sorokból alkotott $A$ mátrixra $rho(A) <=
  rho(M_f)/2$, ha igen, akkor elküldi az $(1,$ a csupa nulla részmátrix
  sorszáma$)$ üzenetet, ez legfeljebb $1 + kappa_0 (f)$ bit kommunikáció, ha
  nincs ilyen részmátrix, akkor $0$-t küld.
  Bob hasonlóan megnézi, hogy van-e az $y$-jához olyan fedő csupa 0 mátrix,
  amely oszlopaihoz tartozó $B$ mátrixra $rho(B) <= rho(M_f)/2$, ha igen (1,a
  fedő mátrix sorszáma), ha nincs ilyen, akkor pedig $0$-t küld.

  Mi történik, ha mindketten $0$-t küldenek?

  Akkor $f(x,y)=1$, hiszen ha 0 lenne, akkor a metszetüket lefedné egy csupa 0
  részmátrix, de az eddigi kommunikáció szerint az ezen fedőmátrixhoz tartozó
  sorok, és oszlopok $rho$ értékei összesen többet adnak, mint $rho(M_f)$,
  ellentmondásban a lemmánkkal.
]

#definition[Kommunikációs bonyolulstágok][
    $f in "P"^("CC")$, ha $exists c > 0: kappa(f) <= log^c n$. \
    $f in "NP"^("CC")$, ha $exists c > 0: kappa_1 (f) <= log^c n$. \
    $f in "co-NP"^("CC")$, ha $exists c > 0: kappa_0 (f) <= log^c n$.
]

A fenti tétel következményeként adódik, hogy $"P"^"CC" = "NP"^("CC") inter "co-NP"^"CC"$.

Láttuk továbbá, hogy $"NP"^("CC") != "co-NP"^("CC")$, mert $"ID"$ benne van a
jobb oldalban, de a balban nincs.

$"P"^"CC" != "co-NP"^"CC"$ szintén az $"ID"$ miatt (így $"P"^"CC" != "NP"^"CC"$ is teljesül).
