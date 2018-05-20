    
    ;; script
    (module
        (import "io" "writechar" (func $writechar (param $char i32))
        (func $start
            ;; set
            i32.const 0
            ;; value character s
            i32.store
            ;; set
            i32.const 0
            ;; expression +
                i32.const 0
                i32.load
                ;; typecast int character
                ;; value int 6
                i32.const 6
            i32.add
            ;; typecast character int
            i32.store
            ;; call $writechar
            i32.const 0
            i32.load
            call $writechar
        )
        (start $start))
    )