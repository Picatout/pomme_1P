# p1+_drive 

Comme tous les ordinateurs le **pomme 1+** a besoin d'une mémoire de masse persistante pour stocké les fichiers. Ce projet créé un périphérique de stockage de 1 Mo en utilisant un MCU STM8S103F3 ainsi qu'une mémoire FLASH  Winbound W25Q80DV. Il s'agit d'une mémoire flash à interface **SPI**. Le STM8S103F3 possède un **UART** qui servira à communiquer avec le **pomme 1+**. Le **W65C51** sera partagé entre ce drive et le terminal. Un protocole de communication devra être définie pour déterminer avec quel périphique le **ACIA** veut communiqué. 

1 Mo de stockage ce n'est pas beaucoup mais il faut se rappeller que dans les années 70 les floppy disk avaient une capacité de 170 Ko, tandis que les derniers floppy de 3.5 pouces avaient une capacité de 1.44 Mo. 

De plus l'interface **SPI** du microcontrolleur peut-être utilisé avec une carte SD ou µSD si une plus grande capacité est désirée. Avec les ajustements du firmware bien entendu. 
