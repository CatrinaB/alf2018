    
    ;; script
    (module
        ;; import functions
        (import "io" "writeint" (func $writeint (param $int i32)))
        ;; define a memory
        (memory 1)
        (func $start
            ;; call $writeint
            ;; expression and
                ;; expression >
                    ;; expression /
                        ;; expression *
                            ;; expression +
                                ;; value int 2
                                i32.const 2
                                ;; value int 3
                                i32.const 3
                            i32.add
                            ;; value int 7
                            i32.const 7
                        i32.mul
                        ;; value int 8
                        i32.const 8
                    i32.div_s
                    ;; value int 10
                    i32.const 10
                i32.gt_s
                ;; expression xor
                    ;; expression <
                        ;; expression +
                            ;; value int 7
                            i32.const 7
                            ;; value int 5
                            i32.const 5
                        i32.add
                        ;; value int 5
                        i32.const 5
                    i32.lt_s
                    ;; expression !=
                        ;; value int 7
                        i32.const 7
                        i32.const 0
                        i32.load
                    i32.ne
            call $writeint
        )
        (start $start)
    )