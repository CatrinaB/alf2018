# Exercise 3

## Code

    function square (x)
    {
        return x*x;
    }
    
    square (5+6);

### Three Address Code

    label square
    push x
    push x
    mul
    return

    push 5
    push 6
    add
    param
    push 1
    call square