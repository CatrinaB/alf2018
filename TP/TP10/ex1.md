# Exercise 1

## Expression
2+3*(5+6)

### Three Address Code Pile

    push 5
    push 6
    add
    push 3
    mul
    push 2
    add

## Expression
s=2+3*(5+6)

### Three Address Code Pile

    push 5
    push 6
    add
    push 3
    mul
    push 2
    add
    pop s

## Expression
e = (s+3)-(s+4)

### Three Address Code

    push s
    push 3
    add
    push s
    push 4
    add
    sub
    pop e