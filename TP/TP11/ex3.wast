(module
  (import "io" "print" (func $print (param $s i32)))
  (func $start (local $a i32) (local $b i32)
    	i32.const 10
    	set_local $a
    	get_local $a
    	i32.const 5
    	set_local $b
    	get_local $b
    	i32.add
    	call $print
    )
  (start $start)
)