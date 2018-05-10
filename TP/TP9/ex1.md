# Exercise 1

## Expression
2+3*(5+6)

### Three Address Code

    t1 = 5+6
    t2 = 3*t1
    t3 = 2+t2

## Expression
s=2+3*(5+6)

### Three Address Code

    t1 = 5+6
    t2 = 3*t1
    t3 = 2+t2
    s = t3

## Expression
e = (s+3)-(s+4)

### Three Address Code

    t1 = s+3
    t2 = s*4
    t3 = t1+t2
    e = t3

