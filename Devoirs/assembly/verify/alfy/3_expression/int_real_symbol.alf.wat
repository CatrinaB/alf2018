    
    ;; script
    (module
        (import "io" "writeint" (func $writeint (param $int i32))
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
                ;; typecast real character
            f32.add
            call $writeint
        )
        (start $start))
    )