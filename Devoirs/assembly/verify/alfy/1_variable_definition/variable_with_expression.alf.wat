    
    ;; script
    (module
        ;; import functions
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; expression +
                ;; value int 20
                i32.const 20
                ;; expression *
                    ;; value int 3
                    i32.const 3
                    ;; value int 5
                    i32.const 5
                i32.mul
            i32.add
            i32.store
        )
        (start $start)
    )