    
    ;; script
    (module
        (import "io" "writeint" (func $writeint (param $int i32))
        (func $start
            ;; call $writeint
            ;; expression =
                ;; expression +
                    ;; value int 2
                    i32.const 2
                    ;; value int 3
                    i32.const 3
                i32.add
                ;; typecast logic int
                i32.eqz
                i32.const 1
                i32.const 0
                select
                ;; expression +
                    ;; value int 4
                    i32.const 4
                    ;; value int 5
                    i32.const 5
                i32.add
                ;; typecast logic int
                i32.eqz
                i32.const 1
                i32.const 0
                select
            i32.eq
            call $writeint
        )
        (start $start))
    )