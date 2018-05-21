    
    ;; script
    (module
        ;; import functions
        (import "io" "readint" (func $readint (result i32)))
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 4
            ;; value int 0
            i32.const 0
            i32.store
            ;; set
            i32.const 0
            ;; call $readint
            call $readint
            i32.store
            ;; if
                ;; expression =
                    i32.const 0
                    i32.load
                    ;; value int 0
                    i32.const 0
                i32.eq
            if
                ;; set
                i32.const 4
                ;; value int 1
                i32.const 1
                i32.store
            end
            ;; while
            block $while_0_end
                loop $while_0_begin
                    ;; expression !=
                        i32.const 0
                        i32.load
                        ;; value int 0
                        i32.const 0
                    i32.ne
                    i32.eqz
                    br_if $while_0_end
                        ;; set
                        i32.const 0
                        ;; expression /
                            i32.const 0
                            i32.load
                            ;; value int 10
                            i32.const 10
                        i32.div_s
                        i32.store
                        ;; set
                        i32.const 4
                        ;; expression +
                            i32.const 4
                            i32.load
                            ;; value int 1
                            i32.const 1
                        i32.add
                        i32.store
                    br $while_0_begin
                end $while_0_begin
            end $while_0_end
            ;; call $writeint
            i32.const 4
            i32.load
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )