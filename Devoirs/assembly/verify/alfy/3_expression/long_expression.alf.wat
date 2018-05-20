    
    ;; script
    (module
        (import "io" "writeint" (func $writeint (param $int i32))
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
                    ;; typecast logic int
                    i32.eqz
                    i32.const 1
                    i32.const 0
                    select
                    ;; value int 10
                    i32.const 10
                    ;; typecast logic int
                    i32.eqz
                    i32.const 1
                    i32.const 0
                    select
                i32.gt
                ;; expression xor
                    ;; expression <
                        ;; expression +
                            ;; value int 7
                            i32.const 7
                            ;; value int 5
                            i32.const 5
                        i32.add
                        ;; typecast logic int
                        i32.eqz
                        i32.const 1
                        i32.const 0
                        select
                        ;; value int 5
                        i32.const 5
                        ;; typecast logic int
                        i32.eqz
                        i32.const 1
                        i32.const 0
                        select
                    i32.lt
                    ;; expression !=
                        ;; value int 7
                        i32.const 7
                        ;; typecast logic int
                        i32.eqz
                        i32.const 1
                        i32.const 0
                        select
                        i32.const 0
                        i32.load
                        ;; typecast logic int
                        i32.eqz
                        i32.const 1
                        i32.const 0
                        select
                    i32.ne
            call $writeint
        )
        (start $start))
    )