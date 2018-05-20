    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; value int 3
            i32.const 3
            i32.store
            ;; call $writeint
            ;; expression +
                i32.const 0
                i32.load
                ;; value int 4
                i32.const 4
            i32.add
            call $writeint
        )
        (start $start)
    )