    
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
                    ;; expression +
                        ;; value int 2
                        i32.const 2
                        ;; value int 4
                        i32.const 4
                    i32.add
                    ;; expression *
                        ;; value int 5
                        i32.const 5
                        ;; value int 6
                        i32.const 6
                    i32.mul
                i32.gt_s
                ;; expression <
                    ;; expression +
                        ;; value int 4
                        i32.const 4
                        ;; value int 5
                        i32.const 5
                    i32.add
                    ;; expression /
                        ;; value int 6
                        i32.const 6
                        ;; value int 7
                        i32.const 7
                    i32.div_s
                i32.lt_s
            call $writeint
        )
        (start $start)
    )