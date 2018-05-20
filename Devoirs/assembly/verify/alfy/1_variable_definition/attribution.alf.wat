    
    ;; script
    (module
        (import "io" "writeint" (func $writeint (param $int i32))
        (func $start
            ;; set
            i32.const 0
            ;; value int 6
            i32.const 6
            i32.store
            ;; call $writeint
            i32.const 0
            i32.load
            call $writeint
        )
        (start $start))
    )