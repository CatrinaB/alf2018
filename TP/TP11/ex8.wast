(module
  (import "io" "print" (func $print (param $s i32)))
  (func $prime (param $num i32) (local $i i32) (local $end i32)
    	get_local $num
    	i32.const 2
    	i32.div_s
    	set_local $end
      	i32.const 2
        set_local $i
        block $endfor
          loop $for
            get_local $i
            get_local $end
            i32.gt_u
            br_if $endfor
            get_local $num
    		get_local $i
    		i32.rem_u
    		i32.eqz
    		if
    		;;print 0 if number is not prime
    		i32.const 0
    		call $print
    		return
    		end
            get_local $i
            i32.const 1
            i32.add
            set_local $i
            br $for
          end $for
        end $endfor
    	;;print 1 if number is prime
    	i32.const 1
    	call $print
  )
  (func $start
    	i32.const 17
    	call $prime
    	i32.const 20
    	call $prime
    )
  (start $start)
)