    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        (import "io" "writechar" (func $writechar (param $char i32)))
        (import "io" "readfloat" (func $readfloat (result f32)))
        
        ;; function floatwrite
        (func $floatwrite
            (param $number f32)
            ;; local variables
            (local $vinteger i32)
            (local $vfractional i32)
            ;; function
                ;; set
                get_local $number
                ;; typecast int real
                i32.trunc_s/f32
                set_local $vinteger
                ;; set
                ;; expression -
                    get_local $number
                    ;; expression *
                        get_local $vinteger
                        ;; value int 1000
                        i32.const 1000
                    i32.mul
                    ;; typecast real int
                    f32.convert_s/i32
                f32.sub
                ;; typecast int real
                i32.trunc_s/f32
                set_local $vfractional
                ;; call $writeint
                get_local $vinteger
                call $writeint
                ;; call $writechar
                ;; value character .
                i32.const 46
                call $writechar
                ;; call $writeint
                get_local $vfractional
                call $writeint
        )
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; call $readfloat
            call $readfloat
            f32.store
            ;; call $floatwrite
            i32.const 0
            f32.load
            call $floatwrite
        ;; empty the stack
        return
        )
        (start $start)
    )