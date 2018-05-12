# Exercise 2

## Code

    if (x < 0)
    {
      r = 'under zero';
    }
    else
    {
      r = 'above zero';
    }

### Three Address Code

    push x
    push 0
    lt
    if goto less
    push 'above zero'
    pop r
    goto endif
    less
    push 'under zero'
    pop r
    endif
