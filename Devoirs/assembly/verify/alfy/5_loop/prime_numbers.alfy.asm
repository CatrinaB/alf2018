    
    ; script
start:
    ; attribution
        ; value logic false
        set r2 0
        ; s: r3
        set r3 8
    store r3 r2
    ; while
while_0:
        ; expression not
            ; s: r3
            set r3 8
            load r3 r3
        set r4 0x0000000000000001
        xor r2  r3 r4
    set r3 1
    test r3 r2
    jne endwhile_0
        ; asm
        readnumber r2 
            ; p: r3
            set r3 0
        store r3 r2
        ; attribution
            ; value logic true
            set r2 1
            ; isPrime: r3
            set r3 4
        store r3 r2
        ; for
        ; from
            ; value int 2
            set r2 2
        ; to
            ; expression /
                ; p: r4
                set r4 0
                load r4 r4
                ; value int 2
                set r5 2
            div r3 r4 r5
        ; step
            ; value int 1
            set r4 1
        ; variable
        ; i: r5
        set r5 12
        mov r6 r2
        store r5 r6
    for_0:
        test r6 r3
        jg endfor_0
            ; if
                ; expression =
                    ; expression mod
                        ; p: r9
                        set r9 0
                        load r9 r9
                        ; i: r10
                        set r10 12
                        load r10 r10
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
                ; attribution
                    ; value logic false
                    set r7 0
                    ; isPrime: r8
                    set r8 4
                store r8 r7
        endif_0:
        add r6 r6 r4
        store r5 r6
        jmp for_0
    endfor_0:
        ; if
            ; expression not
                ; isPrime: r3
                set r3 4
                load r3 r3
            set r4 0x0000000000000001
            xor r2  r3 r4
        set r3 1
        test r3 r2
        jne endif_1
            ; asm
                ; p: r2
                set r2 0
                load r2 r2
            writenumber r2 
    endif_1:
        ; attribution
            ; isPrime: r2
            set r2 4
            load r2 r2
            ; s: r3
            set r3 8
        store r3 r2
    jmp while_0
endwhile_0:
    stop