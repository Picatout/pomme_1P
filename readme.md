<!-- 
Copyright Jacques Deschênes, 2025
Ce document fait parti du projet pomme-I+
https://github.com/picatout/pomme-I+
-->
<a id="top"></a>
# POMME I+

En 2023/24 j'ai développé l'ordinateur [pomme-I](https://github.com/Picatout/pomme-I) sur une carte [NUCLEO-8S207K8](https://www.st.com/en/evaluation-tools/nucleo-8s207k8.html)
, cette année j'ai décidé de fabriqué une version du [pomme-I](https://github.com/Picatout/pomme-I) avec un micropresseur [W65C02S](https://www.mouser.ca/ProductDetail/Western-Design-Center-WDC/W65C02S6TPG-14?qs=opBjA1TV903lvWo9AEKH5w%3D%3D) qui est une version CMOS améliorée du vénérable 6502 qui était utilisé dans le Apple-I. Cette version du **MPU** comprend des instructions supplémentaires par rapport à l'original mais possède une compatibilité ascendante.

J'ai effectué le montage sur 3 cartes de prototypage pleine longueur [Ptsolns](https://ptsolns.com/fr/products/proto-full-basic) collée l'une à l'autre par la tranche pour former un ensemble mesurant 17,5 x 20 cm. 

![assemblage](docs/montage-pomme-I+.jpg)

* La carte centrale comprend l'oscillateur *system clock* le *MPU* ainsi que le *décodeur d'adresses*.
* La carte de droite contient la mémoire **RAM** et **EEPROM**
* La carte de gauche contient un [W65C51S](https://www.mouser.ca/ProductDetail/Western-Design-Center-WDC/W65C51N6TPG-14?qs=AgbsAOSw7WDdUCKSkUixbw%3D%3D) qui est une interface de communication sérielle, i.e. UART. Un [MAX232CPE](https://www.mouser.ca/ProductDetail/Analog-Devices-Maxim-Integrated/MAX232CPE%2b?qs=1THa7WoU59H6WLBcdj%252BTOQ%3D%3D) est utilisé pour l'adaptation de niveau au standard **RS-232** pour permettre la communication avec un port sériel de PC. Il y a un espace libre suffisante sur la carte pour ajouter un module de développement du genre **NUCLEO-8S207K8**, **PI-PICO**, **BLUE PILL** ou encore **BLACK PILL**. À ce moment je n'ai pas arrêté mon choix sur le type d'exention que je vais ajouté sur cet espace. 

À cette étape je vais utilisé mon PC comme terminal pour le développement du software.  

### Schématique

Pour l'essentiel la schématique du circuit est complète et peut-être consultée dans le document [docs/pomme_1+_schematic.pdf](docs/pome_1+_schematic.pdf).

### État actuel du projet
Dans l'état actuel du projet je branche l'ordinateur au PC et utilise l'émulateur de terminal **GTKTerm** configuré à 115200 8N1. Il n'y a qu'un petit programme de [test1.s](p1pMonitor/test1.s) dans l'EEPROM. 

Le projet [eeProg](https://github.com/Picatout/eeprom-programmer) que j'ai développer dernièrement me sert à programmer cet EEPROM. 

### spécifications:

* Processeur **W65C02STPG** de Western Design Center
* 3 fréquences d'horlogue (*system clock*) sont disponibles en positionnant un cavalier.
    * 3,6864Mhz 
    * 1,8432Mhz 
    * 0,9216Mhz 

* Mémoire RAM de 32Ko, 0x0000-0x7FFF 
* Mémoire EEPROM de 8Ko, 0xE000-0xFFFF 
* Mémoire EEPROM optionnelle de 8Ko, 0xB000-0xCFFF
* Périphérique ACIA à 0xD000-0xD003, décodage partiel sur un espace de 4Ko.

### Dévelopement logiciel
J'utilise l'assembleur [ca65](https://cc65.github.io/doc/ca65.html) pour le dévelopement logiciel.

1. je vais écrire les fonctions de base de l'interface de communication et ensuite adapter le WOZMON du Apple I. 

2. je vais étendre le BIOS et écrire un système d'exploitation inspiré de CP/M. 

3. Adapter le Microsoft BASIC à partir du Travail de [Ben Eater](https://github.com/beneater/msbasic) qui est lui-même une adaptation à partir de [mist64/msBasic](https://github.com/mist64/msbasic).


### Continuation du dévelopement matériel
Au final cet ordinateur aura son propre terminal intégré et sera monté dans un boitier en bois semblable à celui que j'ai fait pour le [pomme-I](https://github.com/Picatout/pomme-I).

[début](#top)
