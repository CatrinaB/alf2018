    
    ;; script
    (module
        ;; import functions
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; value int 3
            i32.const 3
            i32.store
            ;; set
            i32.const 4
            ;; value real 3.7
            f32.const 3.7
            f32.store
            ;; set
            i32.const 8
            ;; value logic false
            i32.const 0
            i32.store
        )
        (start $start)
    )