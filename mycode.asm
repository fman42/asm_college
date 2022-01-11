org 100h

start:
    call renderStartWindowProcedure 
    
    ; Let start to wait any key from the user
    mov ah,00h
    int 16h
        
    cmp ah, 4Bh
        je left
    
    cmp ah, 4Dh
        je right
      
    left:
       
        SUB offsetFlag, 1
        call renderStartWindowProcedure
        ret   
    
    right:
        ADD offsetFlag, 1
        call renderStartWindowProcedure
        ret

    renderStartWindowProcedure PROC    
        mov ah,09h
        cmp offsetFlag, 0
        JB call renderActiveYesButton
       
        ; JNB
         
        lea dx,whitespace
        int 21h
        
        lea dx,no 
        int 21h
                
        ret
    renderStartWindowProcedure ENDP
    
    ; |||||||||||||||||||||||||| Primary procedures ||||||||||||||||||||||||||||||||||
       
    renderActiveYesButton PROC
        mov cx,3d
        mov bx,8Fh 
        mov ah,09h 
        lea dx,yes
        int 10h
        int 21h
    
        ret     
    renderActiveYesButton ENDP
    
    renderActiveNoButton PROC
        mov cx,2d
        mov bx,8Fh 
        mov ah,09h 
        lea dx,no
        int 10h
        int 21h
    
        ret
    renderActiveNoButton ENDP
       
yes           DB      'Yes$'
no            DB      'No$'
whitespace    DB      ' $'
offsetFlag    DW       0