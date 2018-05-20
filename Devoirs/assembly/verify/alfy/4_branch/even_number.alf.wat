    
    ;; script
    (module
        ;; import functions
        (import "io" "writechar" (func $writechar (param $char i32)))
        (import "io" "readint" (func $readint (result i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; call $readint
            call $readint
            i32.store
            ;; if
                ;; expression =
                    ;; expression mod
                        i32.const 0
                        i32.load
                        ;; value int 2
                        i32.const 2
                    i32.rem_s
                    ;; value int 0
                    i32.const 0
                i32.eq
            if
                ;; set
                i32.const 4
                ;; value character e
                i32.store
            else
                ;; set
                i32.const 4
                ;; value character o
                i32.store
            end
            ;; call $writechar
            i32.const 4
            i32.load
            call $writechar
        )
        (start $start)
    )