    
    ; script
start:
    ; asm
    readnumber r2 
        ; nr: r3
        set r3 0
    store r3 r2
    ; for
    ; from
        ; value int 2
        set r2 2
    ; to
        ; nr: r3
        set r3 0
        load r3 r3
    ; step
        ; value int 1
        set r4 1
    ; variable
    ; i: r5
    set r5 4
    mov r6 r2
    store r5 r6
for_0:
    test r6 r3
    jg endfor_0
        ; if
            ; expression =
                ; expression mod
                    ; i: r9
                    set r9 4
                    load r9 r9
                    ; value int 2
                    set r10 2
                mod r8 r9 r10
                ; value int 0
                set r9 0
            test r8 r9
            set r7 1
            je next_0
            set r7 0
        next_0:
        set r8 1
        test r8 r7
        jne endif_0
            ; asm
                ; i: r7
                set r7 4
                load r7 r7
            writenumber r7 
    endif_0:
    add r6 r6 r4
    store r5 r6
    jmp for_0
endfor_0:
    stop