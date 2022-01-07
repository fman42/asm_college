org 100h

start:
    ; Default selected button - "No"
    mov cx,3d
    mov bx,8Fh 
    mov ah,09h
    lea dx,yes
    int 10h
    int 21h
    
    lea dx,whitespace
    int 21h
    
    lea dx,no 
    int 21h    
    
    ; Let start to wait any key from the user
    mov ah,00h
    int 16h
        
    cmp ah, 4Bh
        je left
    
    cmp ah, 4Dh
        je right
    
    left:
    
    right:
        jmp renderActiveNo   
    
    renderActiveNo:
        mov ax, 0x0700  ; function 07, AL=0 means scroll whole window
        mov bh, 0x07    ; character attribute = white on black
        mov cx, 0x0000  ; row = 0, col = 0
        mov dx, 0x184f  ; row = 24 (0x18), col = 79 (0x4f)
        int 10h

    
        mov ah,09h
        lea dx,no
        mov cx,2d
        mov bx,8Fh
        int 10h
        int 21h
        
        ret
        
yes DB 'Yes$'
no DB 'No$'
whitespace DB ' $'