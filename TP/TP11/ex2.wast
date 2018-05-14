(module
  (import "io" "print" (func $print (param $s i32)))
  (func $start
    	i32.const 13
    	call $print
    )
  (start $start)
 )