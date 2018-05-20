    
    ;; script
    (module
        (import "io" "writefloat" (func $writefloat (param $float f32))
        (func $start
            ;; set
            i32.const 0
            ;; value real 3.7
            f32.const 3.7
            f32.store
            ;; call $writefloat
            i32.const 0
            i32.load
            call $writefloat
        )
        (start $start))
    )