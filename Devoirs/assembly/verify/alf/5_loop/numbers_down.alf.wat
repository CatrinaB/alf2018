    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; for
            ;; from
                ;; set
                i32.const 0
                ;; value int 6
                i32.const 6
                i32.store
            block $for_0_end
                loop $for_0_begin
                    ;; to
                    i32.const 0
                    i32.load
                    ;; value int 1
                    i32.const 1
                    i32.lt_s
                    br_if $for_0_end
                        ;; call $writeint
                        i32.const 0
                        i32.load
                        call $writeint
                    i32.const 0
                    i32.const 0
                    i32.load
                    i32.const 1
                    i32.sub
                    i32.store
                    br $for_0_begin
                end $for_0_begin
            end $for_0_end
        ;; empty the stack
        return
        )
        (start $start)
    )