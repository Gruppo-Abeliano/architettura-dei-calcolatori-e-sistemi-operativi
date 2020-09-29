#########################################�#########  TAGS  ######################################################
# Descrizione: traduzione in linguaggio assembler MIPS di programma C che esegue la somma tra due               #
#              numeri interi.                                                                                   #
#                                                                                                               #
# Programma: 01.ESERCITAZIONI_ASSEMBLY_1  | Esercizio 1                                                         #
#                                                                                                               #
# Powered by GRUPPO ABELIANO                                                                                    #
#################################################################################################################

#################################################################################################################
# Memorizzo i dati successivi a .data nel segmento dati della memoria. Ricordiamo che esso parte dall'indirizzo #
# 0x10000000.                                                                                                   #
#################################################################################################################

.data

#################################################################################################################
# Siccome per memorizzare un intero ho bisogno di 32 bit, alloco ogni variabile associandola ad un'etichetta,   #
# utilizzando la direttiva .word, la quale mi permette di inserire correttamente l'intero in 1 parola, ovvero   #
# nei 32 bit prima indicati.                                                                                    #
#################################################################################################################

A:  .word 1
B:  .word 2
C:  .word 3

#################################################################################################################
# Memorizzo i dati successivi a .text nel segmento testo (della memoria) dedicato all'utente. Esso parte        #
# dall'indirizzo 0x00400000.                                                                                    #
#################################################################################################################

.text

#################################################################################################################
# Definisco l'inizio del programma MAIN attraverso l'etichetta apposita. Siccome devo elaborare 2 variabili     #
# presenti in memoria, le prelevo e le inserisco nei registri temporanei $t0 e $t1.                             #
#                                                                                                               #
# RICORDA: l'archittetura MIPS si basa su meccanismo load/store, pertando pu� effettuare operazioni soltanto su #
#          registri del processore e non direttamente su elementi presenti in memoria!                          #
#################################################################################################################

MAIN: lw   $t0, A
      lw   $t1, B

#################################################################################################################
# Per ottimizzare il codice non carico subito anche la terz variabile. E' infatti preferibile fare il primo     #
# controllo dell'istruzione if-else, in quanto se essa � falsa, essendo presente l'operatore logico 'and',      #
# tutta l'espressione � automaticamente falsa e pertanto non avrebbe senso controllare anche a==C               #
# In caso invece fosse verificata la prima condizione, procedo al controllo anche della seconda.                #
#################################################################################################################

      bne  $t0, $t1, ELSE
      lw   $t1, C                    # B al momento non mi serve pi�, pertanto lo sovrascrivo.
      bne  $t0, $t1, ELSE

#################################################################################################################
# In caso le condizioni scritte prima fornissero entrambe esito negativo (quindi non si salta all'ELSE), viene  #
# effettivamente fatta l'addizione a = a + 1 (a++). Successivamente sovrascrivo in memoria il vecchio valore di #
# A con quello incrementato.                                                                                    #
#################################################################################################################

THEN: addi $t0, $t0, 1
      sw   $t0, A
      j ENDIF

#################################################################################################################
# La parte ELSE prevede l'incremento di 1 della variabile B (b = b + 1 --- b++).                                #
#################################################################################################################

ELSE: lw   $t0, B
      addi $t0, $t0, 1
      sw   $t0, B

#################################################################################################################
# In generale, scorrelato dal controllo effettuato nell'if, alla variabile C alla fine del programma �          #
# assegnato il valore 12, pertanto lo aggiorno e sovrascrivo il vecchio salvato in memoria.                     #
#################################################################################################################

ENDIF: li  $t0, 12
       sw  $t0, C

#################################################################################################################
# Effettuata la chiamata syscall con codice 10, ovvero il codice di exit (termine del main)                     #
#################################################################################################################

       li  $v0, 10
       syscall
