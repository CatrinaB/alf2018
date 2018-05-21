    
    ;; script
    (module
        ;; import functions
        (import "io" "readint" (func $readint (result i32)))
        (import "io" "writeint" (func $writeint (param $int i32)))
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
            ;; call $readint
            call $readint
            i32.store
            ;; if
                ;; expression <
                    i32.const 0
                    i32.load
                    i32.const 4
                    i32.load
                i32.lt_s
            if
                ;; for
                ;; from
                    ;; set
                    i32.const 12
                    i32.const 0
                    i32.load
                    i32.store
                block $for_0_end
                    loop $for_0_begin
                        ;; to
                        i32.const 12
                        i32.load
                        i32.const 4
                        i32.load
                        i32.gt_s
                        br_if $for_0_end
                            ;; call $writeint
                            i32.const 12
                            i32.load
                            call $writeint
                        i32.const 12
                        i32.const 12
                        i32.load
                        i32.const 1
                        i32.add
                        i32.store
                        br $for_0_begin
                    end $for_0_begin
                end $for_0_end
            else
                ;; for
                ;; from
                    ;; set
                    i32.const 12
                    i32.const 0
                    i32.load
                    i32.store
                block $for_1_end
                    loop $for_1_begin
                        ;; to
                        i32.const 12
                        i32.load
                        i32.const 4
                        i32.load
                        i32.lt_s
                        br_if $for_1_end
                            ;; call $writeint
                            i32.const 12
                            i32.load
                            call $writeint
                        i32.const 12
                        i32.const 12
                        i32.load
                        i32.const 1
                        i32.sub
                        i32.store
                        br $for_1_begin
                    end $for_1_begin
                end $for_1_end
            end
        ;; empty the stack
        return
        )
        (start $start)
    )