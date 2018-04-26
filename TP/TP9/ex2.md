# Exercise 2

## Code

    if (x < 0)
    {
      r = 'unde zero';
    }
    else
    {
      r = 'above zero';
    }

### Three Address Code

    t1 = x < 0
    iffalse t1 goto else
    r = 'below zero'
    goto endif
    label else
    r = 'above zero'
    endif

