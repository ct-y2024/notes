Забавный факт: официально язык называется ECMAScript, но все его называют JavaScript.

== Типы данных
У объектов есть тип, который можно узнать и поменять:
```JavaScript
>> a = 3
>> typeof(a)
"number"
>> a = hello
>> typeof(a)
"string"
>> a = [1, 2, 3]
>> typeof(a)
"object"
```
Объекты можно сравнивать, но есть 2 типа сравнения: приводящее (`==`) и неприводящее (`===`). Приводящее приводит данные к одному типу, а затем сравнивает, а неприводящее выдаёт `false`, если типы не равны. Крайне не рекомендуется использовать `==`.

=== Массивы
Не фиксированного размера, работают идентично векторам в c++, но есть некоторые бонусы:
```JavaScript
>> a = [1, 2, 3]
>> a[10] = 10
>> a
[1, 2, 3, , , , , , , , 10]
>> a[5]
undefined
>> a["hello"] = "world"
>> a[-1] = "???"
>> a
[1, 2, 3, , , , , , , , 10, -1:"???", hello:"world"]
```
=== Константы
```JavaScript
>> const c = 10
>> c = 20
Uncaught TypeError: Assignment to constant variable.
```
Константы нельзя обновлять.

=== Функции
```JavaScript
>> dumpArgs = function() {
    for (const v of arguments) {
        println(v);
    }
}
>> dumpArgs(1, 2, "hello", null)
1
2
hello
null
```
`arguments` --- всего лишь массив аргументов функции.

```JavaScript
>> sum = function() {
    let s = 0;
    for (const v of arguments) {
        s += v;
    }
    return s;
}
>> sum(1, 2, 3)
6
```
Ещё функции можно объявлять так:
```JavaScript
>> function min(a, b) {
    return a < b ? a : b;
}
>> min(3, 4)
3
```
Но это не означает, что нужно вызывать функцию с указанным количеством аргументов:
```JavaScript
>> min(4)
undefined
>> min(1, 2, -10)
1
```
Можно положить все остальные аргументы в массив:
```JavaScript
>> function min(first, ...rest) {
    for (const v of rest) {
        if (v < first) {
            first = v;
        }
    }
    return first;
}
>> min(1, 2, 3, -10, 5)
-10
```
Функции ещё можно объявлять вот так:
```JavaScript
>> min = (first, ...rest) => {
    for (const v of rest) {
        if (v < first) {
            first = v;
        }
    }
    return first;
}
```
Такие функции называются *стрелочными*. У них нет массива `arguments`.
Функции можно передавать в аргументы другим функциям:
```JavaScript
>> minBy = (compare, init = Infinity) => {
    return (...args) => {
        let result = init;
        for (const v of args) {
            if (compare(result, v) > 0) {
                result = v;
            }
        }
        return result;
    };
}
>> minBy((a, b) => a - b)(10, 20, -30, 40)
-30
>> comparing = (f) => ((a, b) => f(a) - f(b))
>> minByAbs = minBy(comparing(Math.abs))
>> minByAbs(10, 20, -30, 40)
40
>> regularMin = minBy(compare(identity))
>> regularMin(10, 20, -30, 40)
-30
```
Подобным способом можно создать универсальную функцию для суммы, максимума, минимума и любой ассоциативной операции:
```JavaScript
>> foldLeft = (f, zero) => {
    return (..args) => {
        let result = zero;
        for (const v of args) {
            result = f(result, v);
        }
        return result;
    };
}
>> sum = foldLeft((a, b) => a + b, 0)
>> sum(1, 2, 3)
6
>> max = foldRight((a, b) => a > b ? a : b, -Infinity)
>>
```
```JavaScript
>> map = (f) => {
    return (..args) => {
        const result = [];
        for (const v of args) {
            result.push(f(arg));
        }
        return result;
    };
}
>> add10 = map((a) => a + 10)
>> add10(10, 20, 30)
[20, 30, 40]
```
```JavaScript
>> diff = dx => f => x =>(f(x + dx) - f(x)) / dx
>> dSin = diff(1e-7)(Math.sin)
>> dsin(Math.Pi)
-1
```
```JavaScript
>> curry = f => a => b => f(a, b)
>> add = curry((a, b) => a + b)
>> add10 = add(10)
>> add10(20)
30
```
