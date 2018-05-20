    
    ;; script
    (module
        ;; import functions
        (import "io" "readint" (func $readint (result i32)))
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 12
            ;; value logic false
            i32.const 0
            i32.store
            ;; while
            block $while_0_end
                loop $while_0_begin
                    ;; expression not
                    i32.const 0
                    i32.eq
                    i32.eqz
                    br_if $while_0_end
                        ;; set
                        i32.const 0
                        ;; call $readint
                        call $readint
                        i32.store
                        ;; set
                        i32.const 4
                        ;; value logic true
                        i32.const 1
                        i32.store
                        ;; for
                        ;; from
                            ;; set
                            i32.const 8
                            ;; value int 2
                            i32.const 2
                            i32.store
                        block $for_0_end
                            loop $for_0_begin
                                ;; to
                                i32.const 8
                                i32.load
                                ;; expression /
                                    i32.const 0
                                    i32.load
                                    ;; value int 2
                                    i32.const 2
                                i32.div_s
                                i32.gt_s
                                br_if $for_0_end
                                    ;; if
                                        ;; expression =
                                            ;; expression mod
                                                i32.const 0
                                                i32.load
                                                i32.const 8
                                                i32.load
                                            i32.rem_s
                                            ;; value int 0
                                            i32.const 0
                                        i32.eq
                                    if
                                        ;; set
                                        i32.const 4
                                        ;; value logic false
                                        i32.const 0
                                        i32.store
                                    end
                                i32.const 8
                                i32.const 8
                                i32.load
                                i32.const 1
                                i32.add
                                i32.store
                                br $for_0_begin
                            end $for_0_begin
                        end $for_0_end
                        ;; if
                            ;; expression not
                            i32.const 0
                            i32.eq
                        if
                            ;; call $writeint
                            i32.const 0
                            i32.load
                            call $writeint
                        end
                        ;; set
                        i32.const 12
                        i32.const 4
                        i32.load
                        i32.store
                    br $while_0_begin
                end $while_0_begin
            end $while_0_end
        )
        (start $start)
    )