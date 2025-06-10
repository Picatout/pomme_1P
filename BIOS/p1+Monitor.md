# manuel du moniteur pomme I+

Le moniteur est l'application qui est exécutée au démarrage de l'ordinateur pomme I+. Cette application permet les fonctions suivantes:

* Examiner le contenu de la mémoire.
* Modifier le contenu de la mémoire RAM.
* Initialiser une plage mémoire à zéro.
* Copier une plage mémoire vers une autre addresse.
* Comparer du plages mémoire pour les différences.
* Sauvarder une plage mémoire vers le SSD.
* Charger une plage mémoire avec le contenu du SSD.
* Exécuter une routine en langage machine.


## Utilisation du moniteur 

Au démarrage le message suivant apparaît. le caractère **#** est le prompt de commande.

```
pomme I+ BIOS version 1.0R0
pomme 1+ monitor version 1.2R1

#
```
## les commandes 

Toutes les valeurs numériques doivent-être en hexadécimal.

### Examiner le contenu de la mémoire.

Simplement en appuyant sur la touche __&lt;ENTER&gt;__ le contenu de 16 adresses mémoire est affiché. 
```
#

0000: E5 97 11 00 00 00 00 00 00 00 00 00 03 00 7D FF  ;               } 
#

0010: FF 00 00 00 00 00 00 02 02 00 FC 0D 0D 33 66 66  ;              3ff
#

0020: 0D 66 66 6D 33 30 31 0D 33 30 30 2E 33 66 66 0D  ;  ffm301 300.3ff 
#

0030: 33 30 30 2E 33 66 66 7A 0D 33 30 00 00 3D 00 3F  ; 300.3ffz 30  = ?
#
``` 
Pour afficher une plage mémoire spécifique on entre l'adresse de départ et l'adresse de fin séparées par un **.** (point). 
```
#400.4FF

0400: 47 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ; G               
0410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
#
```
 __&lt;ENTER&gt;__ après cette commande va afficher le contenu de 500.50f
 ```
 #

0500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
#

``` 

### Modifier le contenu de la mémoire. 
Une addresse suivie du caractère **:**  et de valeurs numérique ou chaines de caractères permet de modifier le contenu de la mémoire.
```
#400: 30 31 32 33 34 35 " bonjour  vous!"

#400.41f

0400: 30 31 32 33 34 35 20 62 6F 6E 6A 6F 75 72 20 20  ; 012345 bonjour  
0410: 76 6F 75 73 21 00 00 00 00 00 00 00 00 00 00 00  ; vous!           
#
```
### Exécuter une routine en langage machine.
La commande **G**o sub permet d'exécuter une sous-routine en langague machine.
```
#300:d "hello world!"

#310: A9 3 A2 0 20 43 E4 60

#300.31F

0300: 0D 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 00 83 71  ;  hello world!  q
0310: A9 03 A2 00 20 43 E4 60 00 00 00 04 02 00 00 00  ;      C `        
#310G

hello world!
#G

hello world!
#
```
Dans cet exemple on a inscrit à l'adresse **0x300** la chaine de caractères "\rhello world!" et à l'adresse **0x310** on a inscrit la routine à exécuter.
l'adresse de la routine suivit de la lettre **G** permet d'exécuter la routine. On peut réexécuter la routine plusieurs fois simplement en entrant la lettre **G** Suivant de la touche **&lt;ENTER&gt;**. 

### Copîer le contenu d'une plage mémoire 
La commande **M**  permet de copier une plage vers une destination.
```
#400.415M420

#400.44F

0400: 30 31 32 33 34 35 20 62 6F 6E 6A 6F 75 72 20 20  ; 012345 bonjour  
0410: 76 6F 75 73 21 00 00 00 00 00 00 00 00 00 00 00  ; vous!           
0420: 30 31 32 33 34 35 20 62 6F 6E 6A 6F 75 72 20 20  ; 012345 bonjour  
0430: 76 6F 75 73 21 00 00 00 00 00 00 00 00 00 00 00  ; vous!           
0440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
#
```
Dans cette exemple le contenu de la plage débutant à 400 et se terminant à 415 a été copiée à l'adresse 420.

### Mettre une plage à la valeur zéro.
La commande **Z** permet de mettre une plage mémoire à zéro.
```
#400.435Z

#400.435

0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0430: 00 00 00 00 00 00  ;                 
#
```
ComMe on le voie le texte a été remplacé par des zéro. 

### Mettre une autre valeur que zéro.
Il existe une astuce pour remplir une plage avec une valeur autre que zéro. Il s'agit d'utiliser la commandees **:** suivit de la commande **M**.
```
#400: "hello world!" 

#400.40f

0400: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 00 00 00 00  ; hello world!    
#400.4FFM40C

#400.4FF

0400: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
0410: 6F 20 77 6F 72 6C 64 21 68 65 6C 6C 6F 20 77 6F  ; o world!hello wo
0420: 72 6C 64 21 68 65 6C 6C 6F 20 77 6F 72 6C 64 21  ; rld!hello world!
0430: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
0440: 6F 20 77 6F 72 6C 64 21 68 65 6C 6C 6F 20 77 6F  ; o world!hello wo
0450: 72 6C 64 21 68 65 6C 6C 6F 20 77 6F 72 6C 64 21  ; rld!hello world!
0460: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
0470: 6F 20 77 6F 72 6C 64 21 68 65 6C 6C 6F 20 77 6F  ; o world!hello wo
0480: 72 6C 64 21 68 65 6C 6C 6F 20 77 6F 72 6C 64 21  ; rld!hello world!
0490: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
04A0: 6F 20 77 6F 72 6C 64 21 68 65 6C 6C 6F 20 77 6F  ; o world!hello wo
04B0: 72 6C 64 21 68 65 6C 6C 6F 20 77 6F 72 6C 64 21  ; rld!hello world!
04C0: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
04D0: 6F 20 77 6F 72 6C 64 21 68 65 6C 6C 6F 20 77 6F  ; o world!hello wo
04E0: 72 6C 64 21 68 65 6C 6C 6F 20 77 6F 72 6C 64 21  ; rld!hello world!
04F0: 68 65 6C 6C 6F 20 77 6F 72 6C 64 21 68 65 6C 6C  ; hello world!hell
#
```
Dans cette exemple on a initialiser la plage 400.41C avec la chaine "hello world!" ensuite on a utiliser la commande **M**ove pour copier à répétion cette chaîne en décallant l'adresse de destination juste après la chaîne. 

Évidemment on peut remplir avec une valeur unique avec cette astuce.
```
#400: 21
#400.4FFM401

#400.4FF

0400: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0410: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0420: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0430: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0440: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0450: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0460: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0470: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0480: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
0490: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04A0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04B0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04C0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04D0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04E0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
04F0: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21  ; !!!!!!!!!!!!!!!!
#
```
## Sauvagarder et restaurer dans la mémoire FLASH 
Le pomme I+ possède une mémoire FLASH de 16Mo **W25Q128**  qui sert de SSD pour l'ordinateur. Il est possible de sauvegarder une plage mémoire dans celle-ci et de la recharger dans la RAM de l'ordinaeur. Cette plage doit-être un multiple de 256 octets.

### Sauvegarde une plage 
La sauvegarde se fait par plage de 256 octets car pour la programmation le W25Q128 n'accepte que 256 octets par étape. La commande **W** est effectuée 
pour cette opération. 

On va d'abord initialiser une plage mémoire avec un patron facilement reconnaissable.
```
#300: "The quick brown fox jump over the lazy dog."          

#32B.3FFZ

#400: "Le renard rapide saute par dessus le chien paresseux."

#438.4FFZ

#300.4FFW0 

#300.4FFZ  

```

Examinons cette plage mémoire avant de la sauvegardée sur le SSD.
```
0300: 54 68 65 20 71 75 69 63 6B 20 62 72 6F 77 6E 20  ; The quick brown 
0310: 66 6F 78 20 6A 75 6D 70 20 6F 76 65 72 20 74 68  ; fox jump over th
0320: 65 20 6C 61 7A 79 20 64 6F 67 2E 00 00 00 00 00  ; e lazy dog.     
0330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
03F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0400: 4C 65 20 72 65 6E 61 72 64 20 72 61 70 69 64 65  ; Le renard rapide
0410: 20 73 61 75 74 65 20 70 61 72 20 64 65 73 73 75  ;  saute par dessu
0420: 73 20 6C 65 20 63 68 69 65 6E 20 70 61 72 65 73  ; s le chien pares
0430: 73 65 75 78 2E 00 00 00 00 00 00 00 00 00 00 00  ; seux.           
0440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
04F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
#
```

On va sauvegarder cette plage de 512 octets à la page 0  de la W25Q128 
```
#300.4FFW0

#
```
On va recharger cette page à l'adresse 0x500 avec la commande **R**EAD.
```
#500.6FFR0
```
Maintenant on va regarché ses 512 octets dans la plage 500.6FF et vérifier que le chargement est identuique à la plaque sauvegardée sur le SSD. 
```
#500.6FFR0

#300.4FFV500

#
```

Il n'y a pas de différences d'affichées donc c'est correct. Affichons la plage pour voir son contenu.
```
#500.6FF

0500: 54 68 65 20 71 75 69 63 6B 20 62 72 6F 77 6E 20  ; The quick brown 
0510: 66 6F 78 20 6A 75 6D 70 20 6F 76 65 72 20 74 68  ; fox jump over th
0520: 65 20 6C 61 7A 79 20 64 6F 67 2E 00 00 00 00 00  ; e lazy dog.     
0530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
05F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0600: 4C 65 20 72 65 6E 61 72 64 20 72 61 70 69 64 65  ; Le renard rapide
0610: 20 73 61 75 74 65 20 70 61 72 20 64 65 73 73 75  ;  saute par dessu
0620: 73 20 6C 65 20 63 68 69 65 6E 20 70 61 72 65 73  ; s le chien pares
0630: 73 65 75 78 2E 00 00 00 00 00 00 00 00 00 00 00  ; seux.           
0640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
0690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
06F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ;                 
#

```

### Vérifier le contenu.
Dans l'exemple précédent il est facile de vérifier que l'opération s'est effectuée correctement, mais s'il s'agissait de code binaire ce ne serait pas si simple. La commande **V**erify  peut le faire pour nous.
```
#400.4FFV600

#

```
La vérification n'a rien affichée donc les 2 plages sont identiques. Modifions quelques octets à l'adresse 400 et répétons la vérification.
```
#400:"bonjour"

#400.4ffv600
0400 62  0600 48
0401 6F  0601 45
0402 6E  0602 4C
0403 6A  0603 4C
0404 6F  0604 4F
0405 75  0605 20
0406 72  0606 57
0407 00  0607 4F

#
```
Le **bonjour** a remplacé le début de **HELLO WORLD!** donc la commande affiche les 7 adresses mémoires qui divergent.


### Effacer un secteur du SSD 
la Commande **X** permet d'effacer un secteur de la W25Q128. Le plus petit bloc de la mémoire FLASH qui peut-être effacé est de 4096 octets. Puisque le W25Q128 possède 16MO de mémoire il y a 65536 secteurs effacables {0..FFFF}.
Puisqu'on a enregistré quelque chose à la page 0x10 on va effacer le secteur qui contient cette page. Puisqu'il y a 16 pages par secteur la page 0x10 est la première page du secteur 1.
```
#1x
CONFIRM FLASH ERASE(Y/N)

#300r10

#300.3ff

0300: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0310: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0320: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0330: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0340: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0350: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0360: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0370: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0380: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0390: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03A0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03B0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03C0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03D0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03E0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03F0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
#
```
Une demande de confirmation est faite à laquelle on doit répondre **Y** pour effectuer l'opération.

Lorsque un secteur est effacé toutes les valeurs sont mise à **0xFF** 

### Effacer tout le SSD 
La commande __*__ permet d'effacer tout le chip W25Q128. Cette opération dure plus de **40 secondes**.
```
*
THIS WILL ERASE WHOLE SSD, (Y/N)?
Be patient it take 40+ seconds

#300r0

#300.3ff

0300: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0310: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0320: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0330: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0340: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0350: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0360: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0370: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0380: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
0390: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03A0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03B0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03C0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03D0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03E0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
03F0: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ;                 
#
```


