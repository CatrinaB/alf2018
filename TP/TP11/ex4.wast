(module
  (import "io" "print" (func $print (param $s i32)))
  (func $sub (param $a i32) (param $b i32)
  	get_local $a
    get_local $b
    i32.sub
    call $print
  )
  (func $start
    	i32.const 5
    	i32.const 2
    	call $sub
    )
  (start $start)
)