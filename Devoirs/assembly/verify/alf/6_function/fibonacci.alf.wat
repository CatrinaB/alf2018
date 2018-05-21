    
    ;; script
    (module
        ;; import functions
        (import "io" "readint" (func $readint (result i32)))
        (import "io" "writeint" (func $writeint (param $int i32)))
        
        ;; function fibonacci
        (func $fibonacci
            (param $item i32)
            (result i32)
            ;; local variables
            (local $value i32)
            ;; function
                ;; if
                    ;; expression or
                        ;; expression =
                            get_local $item
                            ;; value int 0
                            i32.const 0
                        i32.eq
                        ;; expression =
                            get_local $item
                            ;; value int 1
                            i32.const 1
                        i32.eq
                    i32.or
                if
                    ;; set
                    ;; value int 1
                    i32.const 1
                    set_local $value
                else
                    ;; set
                    ;; expression +
                        ;; call $fibonacci
                        ;; expression -
                            get_local $item
                            ;; value int 2
                            i32.const 2
                        i32.sub
                        call $fibonacci
                        ;; call $fibonacci
                        ;; expression -
                            get_local $item
                            ;; value int 1
                            i32.const 1
                        i32.sub
                        call $fibonacci
                    i32.add
                    set_local $value
                end
                ;; return
                    get_local $value
                return
        )
        ;; define a memory
        (memory 1)
        (func $start
            ;; set
            i32.const 0
            ;; call $readint
            call $readint
            i32.store
            ;; call $writeint
            ;; call $fibonacci
            i32.const 0
            i32.load
            call $fibonacci
            call $writeint
        ;; empty the stack
        return
        )
        (start $start)
    )