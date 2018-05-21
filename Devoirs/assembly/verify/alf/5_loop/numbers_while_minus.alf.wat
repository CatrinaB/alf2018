    
    ;; script
    (module
        ;; import functions
        (import "io" "readint" (func $readint (result i32)))
        (import "io" "writefloat" (func $writefloat (param $float f32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; repeat
            loop $repeat_0
                ;; set
                i32.const 0
                ;; call $readint
                call $readint
                i32.store
                ;; set
                i32.const 4
                i32.const 0
                i32.load
                ;; typecast real int
                f32.convert_s/i32
                f32.store
                ;; call $writefloat
                i32.const 4
                f32.load
                call $writefloat
                ;; expression >=
                    i32.const 0
                    i32.load
                    ;; value int 0
                    i32.const 0
                i32.ge_s
                br_if $repeat_0
            end $repeat_0
        ;; empty the stack
        return
        )
        (start $start)
    )