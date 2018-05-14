(module
  (import "io" "print" (func $print (param $s i32)))
  (func $start (local $i i32)
    	i32.const 1
        set_local $i
        block $endfor
          loop $for
            get_local $i
            i32.const 1000
            i32.gt_u
            br_if $endfor
            get_local $i
            call $print 
            get_local $i
            i32.const 1
            i32.add
            set_local $i
            br $for
          end $for
        end $endfor
    )
  (start $start)
)