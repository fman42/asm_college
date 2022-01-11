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
        
    cmp ah, 1Ch
        je enter    
      
    left:
       
        SUB offsetFlag, 1
        call clearWindow
        jmp start
        ret   
    
    right:
        ADD offsetFlag, 1
        call clearWindow
        jmp start
        ret
    
    enter:
        cmp offsetFlag, 0
        JBE exit
        JA restart
        
        exit:
            int 20h
            
        restart:     
            mov offsetFlag, 0
            jmp start
            
        ret

    renderStartWindowProcedure PROC            
        mov ah,09h
        
        cmp offsetFlag, 0
        JBE yes_ins
        JA no_ins
        
        yes_ins:
           call renderActiveYesButton  
        
           lea dx,whitespace
           int 21h
            
           lea dx,no 
           int 21h
           ret 
        
        no_ins:
           lea dx,yes 
           int 21h  
                                  
           lea dx,whitespace
           int 21h
            
           call renderActiveNoButton    
           ret
                
        ret
    renderStartWindowProcedure ENDP
    
    ; |||||||||||||||||||||||||| Primary procedures ||||||||||||||||||||||||||||||||||
    
    clearWindow PROC
        mov ax, 0x0700
        mov bh, 0x07   
        mov cx, 0x0000 
        mov dx, 0x184f 
        int 10h
        ret
    clearWindow ENDP
       
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