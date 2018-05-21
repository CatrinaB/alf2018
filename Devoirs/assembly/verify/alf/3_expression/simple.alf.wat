    
    ;; script
    (module
        ;; import functions
        ;; define a memory
        (memory 1)
        (func $start
            ;; expression +
                ;; value int 2
                i32.const 2
                ;; value int 3
                i32.const 3
            i32.add
        ;; empty the stack
        return
        )
        (start $start)
    )