%include "lib.h"


extern _beep,ExitProcess , read,_getch,fopen,fclose,fprintf,fgets       ; asmw.sh useful functions
; I use asmw.sh to connect th links between files and other functions mentioned above to handle the files 
extern GetStdHandle                   ; for handling the specified standard device( IO and error ) 
MAX_SAVE_CHARS_SIZE EQU  1000          ; max characters size held here


section .data


    start_msg1      db  "********  Welcome to my simple piano simulation  *******  ",0
    start_msg2      db  "Select one of the options below : ",0AH
                    db        "1.Free Play",0AH
                    db            "2.Play Tracks",0AH   
                    db                     "4.Exit ",0

    BeepFreq_1      dd   262          ; beep frequencies( " 1 to = " in keyboard )
    BeepFreq_2      dd   277
    BeepFreq_3      dd   294
    BeepFreq_4      dd   311
    BeepFreq_5      dd   330
    BeepFreq_6      dd   350
    BeepFreq_7      dd   370
    BeepFreq_8      dd   392
    BeepFreq_9      dd   415
    BeepFreq_0      dd   440
    BeepFreq_minus  dd   466
    BeepFreq_plus   dd   493
    BeepDuration    dd   220            ; Beep duration(it is in milliseconds)

    w_flag          db    "w" , 0       ; writing in file flag
    r_flag          db    "r" , 0       ; reading from file flag 

    trackPlay_msg   db  "Please enter file name( with .txt suffix ) : " ,0
    trackSave_msg   db  "Wanna save this track file ? (Y/N) ",0
    saveFile_name   db  "Enter file name with .txt as suffix of the file to be saved " , 0
    loadFile_name   db  "Enter file name with .txt as suffix of the file to be loaded " ,0

    numChosenError        db  "WRONG number chosen!Try again." ,0
    createOrLoadFileError db  "Failed to create or load this file!" ,0

    NewLine               db  0AH , 0


section .bss


    modeChosen              resb  1                ; for choosing mode
    temp                    resb  3                ; temprory memory for getting input modes
    buffer                  resb  1000             ; saving notes from keyboard here
    fileName_to_be_saved    resb  20               ; file names keeps here
    fileName_to_be_loaded   resb  20




section .code

global _start
_start:

    xor  AL , AL
    mov  [modeChosen] , AL           ; initialize mode to zero( getting input from user )

    xor  ESI , ESI                   ; initialize it to zero( used for indexing )

    puts NewLine
    puts start_msg1
    puts NewLine

ask_again:    
    puts NewLine
    puts start_msg2
    puts NewLine

    fgets temp , 3                   ; getting showing option 
    mov AL , [temp]

    cmp AL , '1'                     ; validating the showing option
    je  read_inputChar

    cmp AL , '2'
    je  play_A_track

    cmp AL , '4'
    je  end

    puts numChosenError
    jmp ask_again


    

read_inputChar:

    mov BL ,[modeChosen] 
    cmp BL , 1                     ; comparing current mode by 1
    je  playing_track              ; if mode == 1 , then go to play a track
        
    call _getch                    ; else, getting notes from user and save it in AL
        
        
    mov [buffer+ESI] , AL          ; keeps input notes in buffer defined before      
    inc ESI

    cmp AL , 27               ; compare with "esc" key and check if finished inputing or not
    je  ask_to_saveFile


        

check_notes:

    cmp AL , '1'                 ; check our 12 inputting tone validation
    je  first_note
    cmp AL , '2'
    je  second_note
    cmp AL , '3'
    je  third_note
    cmp AL , '4'
    je  fourth_note
    cmp AL , '5'
    je  fifth_note 
    cmp AL , '6'
    je  sixth_note
    cmp AL , '7'
    je  seventh_note 
    cmp AL , '8'
    je  eighth_note
    cmp AL , '9'
    je  ninth_note
    cmp AL , '0'
    je  tenth_note
    cmp AL , '-'
    je  eleventh_note
    cmp AL , '='
    je  twelfth_note

        jmp read_inputChar
            
            
            

first_note:
    push dword [BeepDuration]            ; push the duration of note 
    push dword [BeepFreq_1]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

second_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_2]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

third_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_3]              ; push the frequency of note
    call _beep                           ; call it to play the note        
            
    jmp read_inputChar

fourth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_4]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar
        
fifth_note:
    push dword [BeepDuration]            ; push the duration of note 
    push dword [BeepFreq_5]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

sixth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_6]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

seventh_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_7]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

eighth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_8]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
            jmp read_inputChar

ninth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_9]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

tenth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_0]              ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

eleventh_note:
    push dword [BeepDuration]            ; push the duration of note 
    push dword [BeepFreq_minus]          ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar

twelfth_note:
    push dword [BeepDuration]            ; push the duration of note
    push dword [BeepFreq_plus]           ; push the frequency of note
    call _beep                           ; call it to play the note
            
    jmp read_inputChar 

            

ask_to_saveFile :

    puts trackSave_msg
    fgets temp , 3

    mov AL , [temp]          ; if answer to saving file is negetive, go to main menu 
    cmp AL , 'n'
    je  ask_again
    cmp AL , 'N'
    je ask_again

    cmp AL , 'y'             ; else, go down and saving notesFile
    je save_notesFile
    cmp AL , 'Y'
    je save_notesFile


save_notesFile :

    puts NewLine
    puts saveFile_name
    puts NewLine
    fgets fileName_to_be_saved , 20        ; getting file name to be saved or created it once

    push  w_flag                           ; push writing_flag
    push  fileName_to_be_saved             ; push file name that keeping the notes
    call fopen                             ; call it to open the file

    add ESP,8		                       ; Clean up the stack
    mov EBX,EAX		                       ; save the file handler that has been kept in EAX, in EBX
            
    cmp EAX , 0                            ; if EAX == 0(error through file operations), print errorInFiles
    je errorInFiles

    push ESI		         ; ESI is the pointer to the line of text
    push 1			         ; push the address of the first line number
    push buffer	             ; Push the address of the base string
    push EBX		         ; Push the handler of the opened file

    call fprintf             ; call it to writing in the file

    add ESP , 16             ; clean up the stack
             
    push EBX		         ; Push the handler of the file to be closed
    call fclose		         ; call it to close the file which handler is on the stack

    add ESP,4                ; clean up the stack
            
    jmp ask_again            ; ask again for next order


play_A_track :

    puts NewLine
    puts loadFile_name
    puts NewLine

    fgets fileName_to_be_loaded , 20       ; getting file name to loading the notes
    puts NewLine

    mov EBX , fileName_to_be_loaded        ; save the address of the file to EBX
    push r_flag		                       ; Push read_flag pointer to open file for read
    push EBX		                       ; push the pointer of the file name

    call  fopen		                       ; call it to open the file for reading
    cmp EAX , 0                            ; check if there is a problem or not
    je  errorInFiles                       ; if it was, print errorInCreateOrLoadFile

    add ESP,8		                       ; Clean up the stack

    mov EBX , EAX		                       ; Save the file handler in EBX
    push EBX		                           ; Push file handler on the stack
    push dword MAX_SAVE_CHARS_SIZE	       ; push the address of the number of charactes of one line to be held
    push buffer	                           ; Push the address of text line buffer

    call fgets

    push EBX		                       ; Push the handle of the file to be closed
    call fclose		                       ; call it to close the file which its handler is on the stack

    add ESP,4                              ; clean up the stack
            
    sub  ESI,ESI                           ; initialize them to zero
    sub  BL ,BL
    inc BL
    mov [modeChosen] , BL                  ; set modeChosen to(1) for getting input from a file

    jmp playing_track



playing_track :
 
    mov BL , [buffer+ESI]
    cmp BL , 27                          ; check if esc button hitten or not
    je ask_again                         ; if it was hitten, go up for next order 

    mov AL,BL                            ; else save BL in AL                       
    inc ESI
    jmp check_notes                      ; go up for checking notes

            


; errorInNumChosen :                       ; lable for handling incorrect option number input     

;     puts    numChosenError
;     jmp ask_again


errorInFiles :                           ; lable for handling file errors may be occurs
         
    puts  createOrLoadFileError          
    jmp   ask_again

        

end:                                     ; finish the program!

    push 0
    call ExitProcess
