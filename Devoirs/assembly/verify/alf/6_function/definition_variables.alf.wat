    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        
        ;; function sum
        (func $sum
            (param $n1 i32)
            (param $n2 i32)
            (result i32)
            ;; local variables
            (local $s i32)
            ;; function
                ;; set
                ;; expression +
                    get_local $n1
                    get_local $n2
                i32.add
                set_local $s
                ;; return
                    get_local $s
                return
        )
        ;; define a memory
        (memory 1)
        (func $start
            ;; call $writeint
            ;; call $sum
            ;; value int 3
            i32.const 3
            ;; value int 7
            i32.const 7
            call $sum
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )