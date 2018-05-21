    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; value logic false
            i32.const 0
            i32.store
            ;; call $writeint
            i32.const 0
            i32.load
            ;; typecast int logic
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )