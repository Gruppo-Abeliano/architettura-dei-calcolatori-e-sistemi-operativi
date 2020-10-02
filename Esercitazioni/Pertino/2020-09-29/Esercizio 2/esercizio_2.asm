###################################################  TAGS  ######################################################
# Descrizione: traduzione in linguaggio assembler MIPS di programma C che cerca in un array di 10               #
#              numeri interi il massimo tra essi.                                                               #
#                                                                                                               #
# Programma: 01.ESERCITAZIONI_ASSEMBLY_1  | Esercizio 2                                                         #
#                                                                                                               #
# Powered by GRUPPO ABELIANO                                                                                    #
#################################################################################################################

#################################################################################################################
# Alloco le variabili globali nel segmento dati:                                                                #
# siccome il vettore e' gia' istanziato con i 10 valori interi, allora scrivo i 10 numeri in 10 parole          #
# consecutive (ricordiamo che un intero occupa 32 bit in memoria, ovvero un'intera parola). Invece ai 2 interi  #
# max ed i non viene assegnato subito il valore, pertando riservo loro uno spazio di 4 byte (ovvero 1 parola)   #
#################################################################################################################

.data
VETT:   .word 1,2,3,4,5,6,7,8,9,10
MAX:    .space 4
I:      .space 4

#################################################################################################################
# Inizio del segmento testo e relativo inizio del programma main. Mi viene inizialmente richiesto di caricare   #
# il primo valore dell'array nella variabile max. Siccome MIPS funziona con meccanismo load/store e non         #
# permette di effettuare operazioni direttamente sulla memoria, pertanto carico cio' che mi serve in registri   #
# temporanei, per poi scriverli con una seconda istruzione in memoria.                                          #
#################################################################################################################

.globl MAIN
.text
MAIN:   lw $t0, 0000(VETT)
        sw $t0, MAX

#################################################################################################################
# Inizializzo a 0 la variabile I che utilizzero' come indice ed inizio il ciclo. Ad ogni iterazione controllo   #
# se l'indice supera il numero di elementi, ed in tal caso mi sposto sull'istruzione affiancata dall'etichetta  #
# ENDFOR che sancisce la fine del ciclo. Altrimenti entro ed eseguo quanto richiesto.                           #
#################################################################################################################

        sw $zero, I
CICLE:  lw $t0, I
        li $t1, 10
        bge $t0, $t1, ENDFOR

#################################################################################################################
# Con le seguenti 3 istruzioni calcolo l'indirizzo dell'elemento corrispondende alla i-esima posizione:         #
#   - la $t1, VETT --> carico in $t1 l'indirizzo della base del vettore.                                        #
#   - sll $t0, $t0, 2 --> moltiplico per 4 il valore dell'indice (scorro di 1 parola (8*4=32 bit) per volta).   #
#   - addu $t0,$t0,$t1 --> a seguito di questa operazione in $t0 ho l'indirizzo del dell'elemento da esaminare. #
#   - lw $t0, ($t0) --> Carico in $t0 l'effettivo valore di VETT[I].                                            #
#################################################################################################################

        la $t1, VETT
        sll $t0, $t0, 2
        addu $t0,$t0,$t1
        lw $t0, ($t0)

#################################################################################################################
# Eseguo infine il controllo sulla condizione richiesta ed, eventualmente, aggiorno il massimo.                 #
#################################################################################################################

        lw $t1, MAX
        ble $t0, $t1, ENDIF
        sw $t0, MAX

#################################################################################################################
# Incremento di 1 il valore di i, in quanto ho raggiunto la fine del ciclo for ed eseguo l'operazione jump che  #
# consente di tornare all'inizio dell'iterazione. Verra' nuovamente fatto il controllo sull'indice i ed in caso #
# abbia raggiunto la fine dell'array si procedera' al salto alla fine del programma.                            #
#################################################################################################################

ENDIF:  lw $t0, I
        addi $t0, $t0, 1
        sw $t0, I
        j CICLE

#################################################################################################################
# Termine del programma.                                                                                        #
#################################################################################################################

ENDFOR: li $v0, 10
        syscall
