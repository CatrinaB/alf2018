(module
  (import "io" "print" (func $print (param $s i32)))
  (func $is_odd (param $a i32) (local $i i32)
  	get_local $a
    i32.const 2
    i32.rem_u
    call $print
  )
  (func $start
    	i32.const 5
    	call $is_odd
    	i32.const 4
    	call $is_odd
    )
  (start $start)
)