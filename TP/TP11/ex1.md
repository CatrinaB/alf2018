# Exercise 1

## Expression
(2 + 3 * (7 + 5))

### WebAssembly

    i32.const 7
    i32.const 5
    i32.add
    i32.const 3
    i32.mul
    i32.const 2
    i32.add
    call $print