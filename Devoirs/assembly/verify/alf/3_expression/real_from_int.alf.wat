    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        (import "io" "readint" (func $readint (result i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 4
            ;; call $readint
            call $readint
            i32.store
            ;; set
            i32.const 0
            i32.const 4
            i32.load
            ;; typecast real int
            f32.convert_s/i32
            f32.store
            ;; call $writeint
            i32.const 0
            f32.load
            ;; typecast int real
            i32.trunc_s/f32
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )