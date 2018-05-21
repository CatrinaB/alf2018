    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; call $writeint
            ;; expression +
                ;; expression +
                    ;; value int 2
                    i32.const 2
                    ;; typecast real int
                    f32.convert_s/i32
                    ;; value real 3.5
                    f32.const 3.5
                f32.add
                ;; value character e
                i32.const 101
                ;; typecast real character
                f32.convert_s/i32
            f32.add
            ;; typecast int real
            i32.trunc_s/f32
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )