    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        (import "io" "readint" (func $readint (result i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; call $readint
            call $readint
            i32.store
            ;; set
            i32.const 4
            ;; call $readint
            call $readint
            i32.store
            ;; set
            i32.const 8
            ;; expression +
                i32.const 0
                i32.load
                i32.const 4
                i32.load
            i32.add
            i32.store
            ;; call $writeint
            i32.const 8
            i32.load
            call $writeint
        )
        (start $start)
    )