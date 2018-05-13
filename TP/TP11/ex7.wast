(module
  (import "io" "print" (func $print (param $s i32)))
  (func $pow (param $a i32) (param $b i32) (local $i i32) (local $res i32)
      	i32.const 1
        set_local $i
    	get_local $a
    	set_local $res
        block $endfor
          loop $for
            get_local $i
            get_local $b
            i32.ge_u
            br_if $endfor
            get_local $a
    		get_local $res
    		i32.mul
    		set_local $res
            get_local $i
            i32.const 1
            i32.add
            set_local $i
            br $for
          end $for
        end $endfor
    	get_local $res
        call $print
  )
  (func $start
    	i32.const 5
    	i32.const 3
    	call $pow
    )
  (start $start)
)