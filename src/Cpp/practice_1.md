```nasm
f(int, int):
    lea     EAX, [RDI+RSI]
    ret
g(int, int):
    mov     EAX, EDI
    sub     EAX, ESI
    ret
```