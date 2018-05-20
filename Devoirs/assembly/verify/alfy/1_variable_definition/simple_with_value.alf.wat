    
    ;; script
    (module
        ;; import functions
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; value int 0
            i32.const 0
            i32.store
        )
        (start $start)
    )