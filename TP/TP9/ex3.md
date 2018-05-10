# Exercise 3

## Code

    function square (x)
    {
        return x*x;
    }
    
    square (5+6);

### Three Address Code

    label square
    t1 = x*x
    ret t1
    
    t1 = 5+6
    param t1
    call square, 1

