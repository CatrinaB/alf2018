    
    ;; script
    (module
        ;; import functions
        (import "io" "writefloat" (func $writefloat (param $float f32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; value real 3.7
            f32.const 3.7
            f32.store
            ;; call $writefloat
            i32.const 0
            f32.load
            call $writefloat
        ;; empty the stack
        return
        )
        (start $start)
    )