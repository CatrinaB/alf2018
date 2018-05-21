    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        (import "io" "writechar" (func $writechar (param $char i32)))
        (import "io" "readint" (func $readint (result i32)))
        
        ;; function base16
        (func $base16
            (param $number i32)
            ;; local variables
            (local $a i32)
            ;; function
                ;; if
                    ;; expression >
                        get_local $number
                        ;; value int 0
                        i32.const 0
                    i32.gt_s
                if
                    ;; call $base16
                    ;; expression /
                        get_local $number
                        ;; value int 16
                        i32.const 16
                    i32.div_s
                    call $base16
                    ;; set
                    ;; expression mod
                        get_local $number
                        ;; value int 16
                        i32.const 16
                    i32.rem_s
                    set_local $a
                    ;; if
                        ;; expression >=
                            get_local $a
                            ;; value int 10
                            i32.const 10
                        i32.ge_s
                    if
                        ;; call $writechar
                        ;; expression -
                            ;; expression +
                                ;; value character a
                                i32.const 97
                                ;; typecast int character
                                get_local $a
                            i32.add
                            ;; value int 10
                            i32.const 10
                        i32.sub
                        ;; typecast character int
                        i32.const 0x000000ff
                        i32.and
                        call $writechar
                    else
                        ;; call $writechar
                        ;; expression +
                            ;; value character 0
                            i32.const 48
                            ;; typecast int character
                            get_local $a
                        i32.add
                        ;; typecast character int
                        i32.const 0x000000ff
                        i32.and
                        call $writechar
                    end
                end
        )
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; call $readint
            call $readint
            i32.store
            ;; call $base16
            i32.const 0
            i32.load
            call $base16
        ;; empty the stack
        return
        )
        (start $start)
    )