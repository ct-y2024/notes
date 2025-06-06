# Процесс компиляции программ

Запись лекции y2019:

- [Запись лекции №1](https://www.youtube.com/watch?v=Fm-EmbQVrLE)
- [Запись лекции №2](https://www.youtube.com/watch?v=w0G66pR3JuY)
- [Запись лекции №3](https://www.youtube.com/watch?v=gsFYkmckcZs)
- [Практика](https://www.youtube.com/watch?v=jZAWVxcHLKA)

Запись лекции y2024:

- TODO


---
Зачем нам нужно это изучать? 
- У студентов часто возникают с этим проблемы — когда компилятор пишет ошибку, а студент не понимает, что она значит
- <!-- TODO мотивация -->

Самое интересное, что ни в одной литературе про компиляцию не рассказывается (в совсем базовой считается, что это сложно, а в продвинутой — что вы всё знаете), а все, кто это знает,
говорят, что пришло с опытом.
# Процесс компиляции C++ программы

Программы на C++ компилируются с помощью компилятора. Один из популярных компиляторов - g++:

```g++ hello.cpp```

Сам g++ по себе ничего не делает, а вызывает другие команды, которые выполняют компиляцию по частям. На linux, если использовать ```strace -f -e trace = execve```

То он запускает:
<!-- TODO вставить, что он запускае -->


Пройдем код:

```cpp
hello world insert
```
## Разберем процесс компиляции поэтапно

### Препроцессинг

Препроцессор - это первый этап компиляции. Он обрабатывает директивы препроцессора, такие как ```#include```, ```#define```, ```#ifdef``` и т.д.
Чтобы увидеть результат работы препроцессора, можно использовать следующую команду:

```g++ -E -P hello.cpp > hello.i```

Эта команда создаст файл hello.i, который будет содержать код после обработки препроцессором. В этом файле вы увидите:
- Раскрытые макросы
- Вставленный код из заголовочных файлов
- Удаленные комментарии
- Обработанные условные директивы (```#ifdef```, ```#ifndef``` и т.д.)

`#include` — директива препроцессора, которая тупо вставляет указанный файл в то место, где написан инклуд.

Пример:

<!-- TODO пример -->
---
### Трансляция

Она делает комманду:

```g++ -s -masm=intel -02 hello.i```

Она переводит C++ программу в язык ассемблера.

Выполняется при помощи `g++ -S`, выходной файл обычно имеет расширение `.s`. Если передать параметр `-masm=intel`, можно уточнить, в какой именно ассемблер переводить (как было сказано в [asm](./01_asm.md),  ассемблеры отличаются в зависимости от инструмента).

---
### Ассемблирование

Берем ассемблерный код переводим в машинный код:

```as -o hello.o hello.s```

Выполняется специальной утилитой `as`, выходной файл обычно имеет расширение `.o` (и называется *объектным файлом*). На данном этапе не происходит ничего интересного — просто инструкции, которые были в ассемблере, перегоняются в машинный код. Поэтому файлы *.o* бесполезно смотреть глазами, они бинарные.

Для того, чтобы смотреть бинарники есть утилита ```objump```:

```objdemp -drC -Mintel hello.o```
<!-- TODO пример -->

---
### Линковка

```g++ -o hello.o ```

Нужна, если файлов несколько: мы запускаем препроцессор, трансляцию и ассемблирование независимо для каждого файла, а объединяются они только на этапе линковки. Независимые *.cpp* файлы называют *единицами трансляции*. Разумеется, **только в одной единице должен быть `main`**. В этом `main`'е, кстати, можно не делать `return 0`, его туда вставит компилятор.\
Сто́ит сказать, что информация о линковке верна до появления модулей в C++20, где можно доставать данные одного файла для другого. Там появляется зависимость файлов друг от друга, а значит компилировать их надо в определённом порядке. 

<!-- TODO более подробно о линковщике -->

--- 

Классическая схема этапов компиляции выглядит так:

<!-- TODO обновить схему -->

![Compilation graph](./images/03.28_compilation_graph.png)

Есть похожая [статья на хабре](https://habr.com/ru/post/478124/) по теме.


 
## Объявление и определение.
Код редко пишется в одном фале и хочется делать что-то типо такого:
```c++
// a.cpp:
int main() {
	f();
}
```
```c++
// b.cpp:
#include <cstdio>

void f() {
	printf("Hello, world!\n");
}
```
Это не компилируется, а точнее ошибка происходит на этапе трансляции *a.cpp*. В тексте ошибки написано, что `f` не определена в области видимости. Всё потому, что для того, **чтобы вызвать функцию, надо что-то про неё знать**. Поэтому на этапе трансляции нужно знать сигнатуру функции. Чтобы указать эту сигнатуру, в C++ есть *объявления*:

```c++
// a.cpp:			
void f();

int main() {
	f();
}
```

Когда мы пишем функцию и точку с запятой — это *объявление*/*декларация* (*declaration*). Это значит, что где-то в программе такая функция есть. А когда мы пишем тело функции в фигурных скобках — это *определение* (*definition*).

Кстати, **написать объявление бывает полезно даже если у нас один файл**. Например, в таком файле:

```c++
#include <cstdio>

int main() {
	f();
}

void f() {
	printf("Hello, world\n");
}
``` 
Это не компилируется, и дело в том, что компилятор читает файл сверху вниз, и когда доходит до вызова функции `f` внутри `main`, он ещё не дошёл до её определения(которое находится снизу). Тут можно переставить функции местами, да, но если у нас есть взаиморекурсивные функции, то там переставить их не получится — только написать декларацию.


<!--
- Можно писать функцию на ассемблере и вызывать из `*.cpp` файла, потому что на этапе линковки нет разницы.
Про это есть ниже.
-->
<!--
- Во всех единицах трансляции только одно определение.
Об этом чуть ниже.
-->
<!--
- Функцию нужно объявлять до её использования. Если она описана ниже, то транслятор не увидит её и кинет ошибку.
На это пример выше.
-->

## Ошибки линковки. Инструменты *nm* и *objdump*. Ключевое слово `static`.
Рассмотрим такой пример:
```c++
// a.cpp
#include <cstdio>

void f()
{
	printf("Hello, a.cpp!\n");
}
```
```c++
// b.cpp
#include <cstdio>

void f()
{
	printf("Hello, b.cpp!\n");
}
```
```c++
// main.cpp
void f();

int main()
{
	f();
}
```
Тут вам на этапе линковки напишут, что функция `f()` определяется дважды. Чтобы красиво посмотреть, как это работает, можно использовать утилиту *nm*. Она показывает символы внутри объектника. Когда вы сгенерируете *a.o* и вызовете `nm -C a.o`, то увидите что-то такое:
```
                 U puts
0000000000000000 T f()
```
Что делает ключ *-C*, [оставим на потом](./05_compilation.md#декорирование-имён-extern-c). На то что тут находится `puts` вместо `printf`, тоже обращать внимание не надо, это просто такая оптимизация компилятора — когда можно заменить `printf` на `puts`, заменяем.\
А обратить внимание надо на то, что `puts` не определена (об этом нам говорит буква *U*), а функция `f()` — определена в секции *.text* (буква *T*). У *main.cpp*, понятно, будет неопределённая функция `f()` и определённая `main`. Поэтому, имея эти объектные файлы, можно слинковать *main.cpp* и *a.cpp*. Или *main.cpp* и *b.cpp*. Без перекомпиляции. Но нельзя все три вместе, ведь `f()` будет определена дважды.

### objdump

Если мы хотим посмотреть на объектные файлы поподробнее, нам понадобится утилита *objdump* Вот некоторые из ее основных возможностей:
1. Дизассемблирование (-d):
Позволяет увидеть машинный код в виде ассемблерных инструкций. Это полезно для анализа того, как компилятор преобразовал ваш исходный код в машинные инструкции.
2. Отображение релокаций (-r):
Показывает информацию о релокациях - это места в коде, которые нужно будет изменить при загрузке программы или при связывании с другими объектными файлами. В общем случае ***релокация* — информация о том, какие изменения нужно сделать с программой, чтобы файл можно было запустить**.
3. Отображение символьной информации (-t):
Выводит таблицу символов, включая имена функций и переменных.
4. Отображение заголовков секций (-h):
Показывает информацию о различных секциях в объектном файле (например, .text для кода, .data для инициализированных данных).
5. Полный вывод (-x):
Комбинирует несколько опций для вывода максимально подробной информации об объектном файле.

Если рассматривать на примере выше, то когда мы вызовем `objdump -dr -Mintel -C main.o`, мы увидим, что на месте вызова функции `f` находится `call` и нули. Потому что неизвестно, где эта функция находится, надо на этапе линковки подставить её адрес. А чтобы узнать, что именно подставить, есть *релокации*, которые информацию об этом и содержат. 

### static 

Ключевое слово `static` в C++ имеет несколько важных применений:

1. Для глобальных переменных и функций:

   Когда `static` применяется к глобальной переменной или функции, это ограничивает их видимость текущей единицей трансляции. Это означает, что они не будут доступны из других файлов.
   
   Пример: Пусть в нашем файле определена функция `f()`. И где-то по случайному совпадению в другом файле также определена функция `f()`. Понятно, что оно так не слинкуется. Но мы можем иметь в виду, что наша функция `f` нужна только нам и никому снаружи. Поэтому мы сделаем ее `static` и все будет хорошо.

	Если сделать на такие функции *nm*, то можно увидеть символ *t* вместо *T*, который как раз обозначает локальность для единицы трансляции. 

	Если говорить по-научному, то `static` функции имеют внутреннюю линковку, а не `static` - внешнюю.

	Важно отметить, что функции, локальные для одного файла, стоит помечать как `static` в любом случае, так как это помогает компилятору выполнять дополнительные оптимизации. Компилятор может быть уверен, что такая функция не будет вызвана из других единиц трансляции, что открывает возможности для более агрессивной оптимизации, включая возможность полного встраивания (inlining) функции.
2.  Для членов класса:

	Когда static применяется к члену класса (переменной или функции), этот член становится общим для всех экземпляров класса, а не принадлежит конкретному объекту.
3.  Для локальных переменных:

	Когда static применяется к локальной переменной внутри функции, эта переменная сохраняет свое значение между вызовами функции.

## Глобальные переменные.
Для глобальных переменных всё то же самое, что и для функций: например, мы также можем сослаться на глобальную переменную из другого файла. Только тут другой синтаксис:
```c++
extern int x; // Объявление.

int x;        // Определение.
```
И точно также в глобальных переменных можно писать `static`, как и было сказано ранее. А теперь пример:
```c++
// a.cpp
extern int a;

void f();

int main()
{
	f();
	a = 5;
	f();
}
```
```c++
// b.cpp
#include <cstdio>

int a;

void f()
{
	printf("%d\n", a);
}
```
В первый раз вам выведут *0*, потому что **глобальные переменные инициализируются нулями (по стандарту гарантируется)**, во второй раз 5. Локальные переменные хранятся на стеке, и там какие данные были до захода в функцию, те там и будут. А глобальные выделяются один раз, и ОС даёт вам их проинициализированные нулём (иначе там могут быть чужие данные, их нельзя отдавать).

## Декорирование имён. `extern "C"`.

Обсуждённая нами модель компиляции позволяет использовать несколько разных языков программирования. **Пока ЯП умеет транслироваться в объектные файлы, проблемы могут возникнуть только на этапе линковки.** Например, никто не мешает вам взять уже готовый ассемблерник и скомпилировать его с *.cpp* файлом. Но в вызове ассемблера есть одна проблема. Тут надо поговорить о такой вещи как `extern "C"`. В языке C всё было так: имя функции и имя символа для линковщика — это одно и то же. Если мы скомпилируем файл
```c
// a.c <-- C, не C++.
void foo(int)
{
	// ...
}
```
То имя символа, которое мы увидим в *nm* будет *foo*. А в C++ появилась перегрузка функций, то есть `void foo(int)` и `void foo(double)` — это две разные функции, обе из которых можно вызывать. Поэтому одно имя символа присвоить им нельзя. Так что **компилятор mangle'ит/декорирует имена, то есть изменяет их так, чтобы символы получились уникальными**. `nm` даже позволяет их увидеть. Пример:

| function | name mangling      |
|:---:|:---:|
|`void test(){}`| `_Z4testv`|
|`void test(int){}`| `_Z4testi`|
|`void test(char const *)` | `_Z4testPKc`|


 Но у вас есть и возможность увидеть их по-человечески: для этого существует уже упомянутый ключ *-C*, который если передать программе *nm*, то она раздекорирует всё обратно и выдаст вам имена человекочитаемо. *objdump*'у этот ключ дать тоже можно. А ещё есть утилита
*c++filt*, которая по имени даёт сигнатуру. Например вызов `c++filt _Z4testiii` вернет `test(int, int, int)`

Так вот, **`extern "C"` говорит, что при линковке нам не нужно проводить декорацию**. И если у нас в ассемблерном файле написано `fibonacci:`, то вам и нужно оставить имя символа как есть:
```c++
extern "C" uint32_t fibonacci(uint32_t n);
```
У функций, имеющих разные сигнатуры, но помеченных как `extern "C"`, после компиляции не будет информации о типах их аргументов, поэтому это слинкуется, но работать не будет (ну либо будет, но тут UB, так как, например, типы аргументов ожидаются разные).

<---сделал до сюда--->

## Линковка со стандартной библиотекой.
 Возьмём теперь объявление `printf` из `cstdio` и вставим его объявление вручную:
```c++
extern "C" int printf(const char*, ...);

int main() {
	printf("Hello, world!");
}
```
Такая программа тоже работает. А где определение `printf`, возникает вопрос? А вот смотрите. На этапе связывания
связываются не только ваши файлы. Помимо этого **в параметры связывания добавляются несколько ещё объектных файлов и несколько библиотек**. В нашей модели мира хватит информации о том, что библиотека — просто набор объектных файлов. И вот при линковке вам дают стандартную библиотеку C++ (*-lstdc++*), математическую библиотеку (*-lm*), библиотеку *-libgcc*, чтобы если вы делаете арифметику в 128-битных числах, то компилятор мог вызвать функцию `__udivti3` (деление), и кучу всего ещё. В нашем случае нужна одна — *-lc*, в которой и лежит `printf`. А ещё один из объектных файлов, с которыми вы линкуетесь, содержит функцию `_start` (это может быть файл `crt1.o`), которая вызывает `main`.

## Headers (заголовочные файлы). Директива `#include`.
<!--
`2.h` - файлы не участвующие в компиляции, в них пишут объявления функций. Не нужно делать  `#include file.cpp`, а в `.h` не нужно определять функции.

Какая-то сомнительная подводка, честно говоря.
Мне подводка из 2021–22 нравится больше.
-->
Если мы используем одну функцию во многих файлах, то нам надо писать её сигнатуру везде. А если мы её меняем, то вообще повеситься можно. Поэтому так не делают. А как делают? А так: **декларация выделяется в отдельный файл**. Этот файл имеет расширение *.h* и называется *заголовочным*. По сути это же происходит в стандартной библиотеке. Подключаются заголовочные файлы директивой `#include <filename>`, если они из какой-то библиотеки, или `#include "filename"`, если они ваши. В чём разница? Стандартное объяснение — тем, что треугольные скобки сначала ищут в библиотеках, а потом в вашей программе, а кавычки — наоборот. На самом деле у обоих вариантов просто есть список путей, где искать файл, и эти списки разные.

Но с заголовками нужно правильно работать. Например, **нельзя делать `#include "a.cpp"`**. Почему? Потому что все определённые в `a.cpp` функции и переменные просочатся туда, куда вы его подключили. И если файл у вас один, то ещё ничего, а если больше, то в каждом, где написано `#include "a.cpp"`, будет определение, а значит определение одного и того же объекта будет написано несколько раз.
Аналогичный эффект будет, если **писать определение сразу в заголовочном файле, не надо так**.

К сожалению, у директивы `#include` есть несколько нюансов.

### Предотвращение повторного включения.
Давайте поговорим про структуры. Что будет, если мы в заголовочном файле создадим `struct`, и подключим этот файл? Да ничего. Абсолютно ничего. Сгенерированный ассемблерный код будет одинаковым. **У структур нет определения по сути, потому что они не генерируют код**. Поэтому их пишут в заголовках. При этом их методы можно (но не нужно) определять там же, потому что они воспринимаются компилятором как `inline`. А кто такой этот `inline` и как он работает — смотри дальше. Но со структурами есть один нюанс. Рассмотрим вот что:
```c++
// x.h:
struct x {};
```
```c++
// y.h:
#include "x.h"
```
```c++
// z.h:
#include "x.h"
```
```c++
// a.cpp:
#include "y.h" //    -->    `struct x{};`.
#include "z.h" //    -->    `struct x{};` ошибка компиляции, повторное определение.
```

Стандартный способ это поправить выглядит так:
```c++
// x.h:
#ifndef X_H // Если мы уже определили макрос, то заголовок целиком игнорируется.
#define X_H	// Если не игнорируется, то помечаем, что файл мы подключили.

struct x {};

#endif // В блок #ifndef...#endif заключается весь файл целиком.
```
Это называется *include guard*. Ещё все возможные компиляторы поддерживают `#pragma once` (эффект как у *include guard*, но проще). И на самом деле `#pragma once` работает лучше, потому что не опирается на имя файла, например. Но его нет в стандарте, что грустно.

Есть один нюанс с `#pragma once`'ом. Если у вас есть две жёстких ссылки на один файл, то у него проблемы. Если у вас include guard, то интуитивно понятно, что такое разные файлы — когда макросы у них разные. А вот считать ли разными файлами две жёстких ссылки на одно и то же — вопрос сложный. Другое дело, что делать так, чтобы источники содержали жёсткие
или символические ссылки, уже довольно странно.

### Forward-декларации.
```c++
// a.h
#ifndef A_H
#define A_H

#include "b.h" // Nothing, then `struct b { ... };`

struct a {
	b* bb;
};
#endif
```
```c++
// b.h
#ifndef B_H
#define B_H

#include "a.h" // Nothing, then `struct a { ... };`

struct b {
	a* aa;
};
#endif
```
```c++
// main.cpp
#include "a.h" // `struct b { ... }; struct a { ... };`
#include "b.h" // Nothing.
```
Понятно, в чём проблема заключается. Мы подключаем *a.h*, в нём — *b.h*, а в нём, поскольку мы уже зашли в *a.h*, include guard нам его блокирует. И мы сначала определяем структуру `b`, а потом — `a`. И при просмотре структуры `b`, мы не будем знать, что такое `a`.

Для этого есть конструкция, называемая *forward-декларацией*. Она выглядит так:
```c++
// a.h
#ifndef A_H
#define A_H

struct b;

struct a {
	b* bb;
};
#endif
```
```c++
// b.h
#ifndef B_H
#define B_H

struct a;

struct b {
	a* aa;
};
#endif
```
**Чтобы завести указатель, нам не надо знать содержимое структуры.** Поэтому мы просто говорим, что `b` — это некоторая структура, которую мы дальше определим.

Вообще **forward-декларацию в любом случае лучше использовать вместо подключения заголовочных файлов** (если возможно, конечно). Почему?
- Во-первых, из-за времени компиляции. Большое количество подключений в заголовочных файлах негативно влияет на него, потому что если меняется *header*, то необходимо перекомпилировать все файлы, которые подключают его (даже не непосредственно), что может быть долго.
- Второй момент — когда у нас **цикл из заголовочных файлов, это всегда ошибка**, даже если там нет проблем как в примере, потому что результат компиляции зависит от того, что вы подключаете первым.
<!--
```c++
#define PI 3.14 
// препроцессор подставляет вместо PI 3.14
```
Макросы обычно пишут капсом

Это тут при чём вообще? Мы, вроде, заголовки обсуждали. Про макросы я лучше напишу сам и пониже.
-->

Пока структуру не определили, структура — это *incomplete type*. Например, на момент объявления `struct b;` в коде выше, `b` — incomplete. Кстати, в тот момент, когда вы находитесь в середине определения класса, он всё ещё incomplete.
Все, что можно с incomplete типами делать — это объявлять функции с их использованием и создавать указатель. Incomplete тип становится полным типом после определения.
Пока что информация об incomplete-типах нам ни к чему, но [она выстрелит позже](./14_templates.md#incomplete-type).

## Правило единственного определения.
А теперь такой пример:
```c++
// a.cpp
#include <iostream>

struct x {
	int a;
	// padding
	double b;
	int c;
	int d;
};

x f();

int main() {
	x xx = f();
	std::cout << xx.a << " "
	          << xx.b << " "
	          << xx.c << " "
	          << xx.d << std::endl;
}
```
```c++
// b.cpp
struct x {
	int a;
	int b;
	int c;
	int d;
	int e;
};

x f() {
	x result;
	result.a = 1;
	result.b = 2;
	result.c = 3;
	result.d = 4;
	result.e = 5;
	return result;
};
```
Тут стоит вспомнить, что **структуры при линковке не играют никакой роли**, то есть линковщику всё равно, что у нас структура `x` определена в двух местах. Поэтому такая программа отлично скомпилируется и запустится, но тем не менее она является некорректной. По стандарту такая программа будет работать неизвестно как, а по жизни данные поедут. А именно `2` пропадёт из-за выравнивания `double`, `3` и `4` превратятся в одно число (`double`), а `5` будет на своём месте, а `x::e` из файла *a.cpp* будет просто не проинициализирован. Правило, согласно которому так нельзя, называется *one-definition rule*/*правило единственного определения*. Кстати, нарушением ODR является даже тасовка полей.

## Inlining.
```c++
int foo(int a, int b) {
	return a + b;
}

int bar(int a, int b) {
	return foo(a, b) - a;
}
```
Если посмотреть на ассемблерный код для `bar`, то там не будет вызова функции `foo`, а будет `return b;`. Это называется *inlining* — когда мы берём тело одной функции и вставляем внутрь другой как оно есть. Это связано, например, со стилем программирования в текущем мире (много маленьких функций, которые делают маленькие вещи) — мы убираем все эти абстракции, сливаем функции в одну и потом оптимизируем что там есть.

Но есть один нюанс...
### Модификатор `inline`.
```c++
// a.c
void say_hello();

int main() {
	say_hello();
}
```
```c++
// b.c
#include <cstdio>

void say_hello() {
	printf("Hello, world!\n");
}
```
Тут не произойдёт inlining, а почему? А потому что **компилятор умеет подставлять тело функций только внутри одной единицы трансляции** (так как inlining происходит на момент трансляции, а тогда у компилятора нет функций из других единиц).

Тут умеренно умалчивается, что модель компиляции, которую мы обсуждаем — древняя и бородатая. Мы можем передать ключ *-flto* в компилятор, тогда всё будет за'inline'ено. Дело в том, что **при включенном режиме linking time optimization, мы откладываем на потом генерацию кода и генерируем его на этапе линковки**. В таком случае линковка может занимать много времени, поэтому применяется при сборке с оптимизациями. Подробнее о режиме LTO — сильно позже.

Но тем не менее давайте рассмотрим, как без LTO исправить проблему с отсутствием inlining'а. Мы можем написать в заголовочном файле тело, это поможет, но это, как мы знаем, ошибка компиляции. Хм-м, ну, можно не только написать функцию в заголовочном файле, но и пометить её как `static`, но это даёт вам свою функцию на каждую единицу трансляции, что, во-первых, бывает просто не тем, что вы хотите, а во-вторых, кратно увеличивает размер выходного файла. 

Поэтому есть модификатор `inline`. Он нужен для того, чтобы линковщик не дал ошибку нарушения ODR. **Модификатор `inline` напрямую никак не влияет на то, что функции встраиваются.** Если посмотреть на `inline` через *nm*, то там увидим *W* (weak) — из нескольких функций можно выбрать любую (предполагается, что все они одинаковые).

По сути `inline` — указание компилятору, что теперь за соблюдением ODR следите вы, а не он. И если ODR вы нарушаете, то это неопределённое поведение (*ill-formed, no diagnostic required*). *ill-formed, no diagnostic required* — это ситуация, когда программа некорректна, но никто не заставляет компилятор вам об этом говорить. Он может (у GCC есть такая возможность: если дать *g++* ключи *-flto -Wodr*, он вам об этом скажет), но не обязан. А по жизни линковщик выберет произвольную из имеющихся функций (например, из первой единицы трансляции или вообще разные в разных местах):
```c++
// a.cpp
#include <cstdio>

inline void f() {
	printf("Hello, a.cpp!\n");
}

void g();

int main() {
	f();
	g();
}
```
```c++
// b.cpp
inline void f() {
	printf("Hello, b.cpp!\n");
}

void g() {
	f();
}
```
Если скомпилировать этот код с оптимизацией, обе функции `f` будут за'inline'ены, и всё будет хорошо. Если без, то зависит от порядка файлов: *g++ a.cpp b.cpp* может вполне выдавать *Hello, a.cpp!* два раза, а *g++ b.cpp a.cpp* — *Hello, b.cpp!* два раза.

Если нужно именно за'inline'ить функцию, то есть нестандартизированные модификаторы типа `__forceinline`, однако даже они могут игнорироваться компилятором. Inlining функции может снизить производительность: на эту тему можно послушать [доклад Антона Полухина на C++ Russia 2017](https://youtu.be/rJWSSWYL83U?t=1970).

## Остальные команды препроцессора.
`#include` обсудили уже вдоль и поперёк. Ещё есть директивы `#if`, `#ifdef`, `#ifndef`, `#else`, `#elif`, `#endif`, которые дают условную компиляцию. То есть если выполнено какое-то условие, можно выполнить один код, а иначе — другой.

### Определение макроса.
И ещё есть *макросы*: определить макрос (`#define`) и разопределить макрос (`#undef`):
```c++
#define PI 3.14159265
double circumference(double r) {
    return 2 * PI * r;
}
```
Текст, который идет после имени макроса, называется *replacement*. Replacement отделяется от имени макроса пробелом и распространяется до конца строки. Все вхождения идентификатора `PI` ниже этой директивы будут заменены на *replacement*. Самый простой макрос — *object-like*, его вы видите выше, чуть более сложный — *function-like*:
```c++
#define MIN(x, y) x < y ? x : y

printf("%d", MIN(4, 5));
```

Что нам нужно про это знать — **макросы работают с токенами**. Они не знают вообще ничего о том, что вы делаете. Вы можете написать
```c++
#include <cerrno>

int main() {
	int errno = 42;
}
```
И получить отрешённое от реальности сообщение об ошибке. А дело всё в том, что это на этапе препроцессинга раскрывается, например, так:
```c++
int main() {
	int (*__errno_location()) = 42;
}
```
И тут компилятор видит более отъявленный бред, нежели называние переменной так, как нельзя.

Что ещё не видит препроцессор, так это синтаксическую структуру и приоритет операций. Более страшные вещи получаются, когда пишется что-то такое:
```c++
#define MUL(x, y) x * y

int main() {
	int z = MUL(2, 1 + 1);
}
```
Потому что раскрывается это в
```c++
int main() {
	int z = 2 * 1 + 1;
}
```
Это не то, что вы хотите. Поэтому когда вы такое пишите, **нужно, во-первых, все аргументы запихивать в скобки, во-вторых — само выражение тоже**, а в-третьих, это вас никак не спасёт от чего-то такого:
```c++
#define max(a, b) ((a) < (b) ? (a) : (b))

int main() {
	int x = 1;
	int y = 2;
	int z = max(x++, ++y);
}
```
Поэтому **перед написанием макросов три раза подумайте, нужно ли оно, а если нужно, будьте очень аккуратны**. А ещё, если вы используете отладчик, то он ничего не знает про макросы, зачем ему знать. Поэтому в отладчике написать «вызов макроса» Вы обычно не можете. См. также [FAQ Бьярна Страуструпа](http://www.stroustrup.com/bs_faq2.html\#macro) о том, почему макросы — это плохо.

Ещё `#define` позволяет переопределять макросы.
```c++
#define STR "abc"
const char* first = STR; // "abc".
#define STR "def"
const char* second = STR; // "def".
```

*Replacement* макроса не препроцессируется при определении макроса, но результат раскрытия макроса препроцессируется повторно:
```c++
#define Y foo
#define X Y   // Это не `#define X foo`.
#define Y bar // Это не `#define foo bar`.
X             // Раскрывается `X` -> `Y` -> `bar`.
```

Также по спецификации препроцессор никогда не должен раскрывать макрос изнутри самого себя, а оставлять вложенный идентификатор как есть:
```c++
#define M { M }
M   // Раскрывается в { M }.
```

<u>Ещё пример</u>:

```c++
#define A a{ B }
#define B b{ C }
#define C c{ A }
A // a{ b{ c{ A } } }
B // b{ c{ a{ B } } }
C // c{ a{ b{ C } } }
```

### Условная компиляция. Проверка макроса.
Директивы `#ifdef`, `#ifndef`, `#if`, `#else`, `#elif`, `#endif` позволяют отпрепроцессировать часть файла, лишь при определенном условии. Директивы `#ifdef`, `#ifndef` проверяют определен ли указанный макрос. Например, они полезны для разной компиляции:
```c++
#ifdef __x86_64__
typedef unsigned long uint64_t;
#else
typedef unsigned long long uint64_t;
#endif
```

Директива `#if` позволяет проверить произвольное арифметическое выражение.
```c++
#define TWO 2
#if TWO + TWO == 4
// ...
#endif
```
Директива `#if` препроцессирует свой аргумент, а затем парсит то, что получилось как арифметическое выражение. Если после препроцессирования в аргументе `#if` остаются идентификаторы, то они заменяются на 0, кроме идентификатора `true`, который заменяется на 1.

Одно из применений `#ifndef` — это include guard, которые уже обсуждались [ранее](./05_compilation.md#headers-заголовочные-файлы-директива-include).

### Константы.
Понадобилась нам, например, $\pi$. Традиционно в C это делалось через `#define`. Но у препроцессора, как мы знаем, есть куча проблем. В случае с константой `PI` ничего не случится, вряд ли кто-то будет называть переменную так, особенно большими буквами, но всё же.

А в C++ (а позже и в C) появился `const`. Но всё же, зачем он нужен, почему нельзя просто написать глобальную переменную `double PI = 3.141592;`?
1. Во-первых, константы могут быть оптимизированы компилятором. Если вы делаете обычную переменную, компилятор обязан её взять из памяти (или регистров), ведь в другом файле кто-то мог её поменять. А если вы напишете `const`, то у вас не будет проблем ни с оптимизацией (ассемблер будет как при `#define`), ни с адекватностью сообщений об ошибках.
2. Во-вторых, она несёт документирующую функцию, когда вы пишете `const` с указателями. Если в заголовке функции написано `const char*`, то вы точно знаете, что вы передаёте в неё строку, которая не меняется, а если `char*`, то, скорее всего, меняется (то есть функция создана для того, чтобы менять).
3. В-третьих, имея `const`, компилятор может вообще не создавать переменную: если мы напишем `return PI * 2`, то там будет возвращаться константа, и никакого умножения на этапе исполнения.

Кстати, как вообще взаимодействует `const` с указателями? Посмотрим на такой пример:
```c++
int main() {
	const int MAGIC = 42;
	int* p = &MAGIC;
}
```
Так нельзя, это имеет фундаментальную проблему: вы можете потом записать `*p = 3`, и это всё порушит. Поэтому вторая строка не компилируется, и её надо заменить на
```c++
	const int* p = &MAGIC;
```
Но тут нужно вот на что посмотреть. У указателя в некотором смысле два понятия неизменяемости. Мы же можем сделать так:
```c++
int main() {
	const int MAGIC = 42;
	const int* p = &MAGIC;
	// ...
	p = nullptr;
}
```
Кто нам мешает так сделать? Да никто, нам нельзя менять содержимое `p`, а не его самого. А если вы хотите написать, что нельзя менять именно сам указатель, то это не `const int*`/`int const*`, а `int* const`. Если вам нужно запретить оба варианта использования, то, что логично, `const int* const` или `int const* const`. То есть
```c++
int main() {
	int* a;
	*a = 1;      // ok.
	a = nullptr; // ok.

	const int* b;       // Синоним `int const* b;`
	*b = 1;      // Error.
	b = nullptr; // ok.

	int* const c;
	*c = 1;      // ok.
	c = nullptr; // Error.

	const int* const d; // Синоним `int const* const d;`
	*d = 1;      // Error.
	d = nullptr; // Error.
}
```
Теперь вот на что посмотрим:
```c++
int main() {
	int a = 3;
	const int b = 42;

	int* pa = &a;        // 1.
	const int* pca = &a; // 2.
	int* pb = &b;        // 3.
	const int* pcb = &b; // 4.
}
```
Что из этого содержит ошибку? Ну, в третьем точно ошибка, это мы уже обсудили. Также первое и четвёртое точно корректно. А что со вторым? Ну, нарушает ли второе чьи-то права? Ну, нет. Или как бы сказали на парадигмах программирования, никто не нарушает контракт, мы только его расширяем (дополнительно обещая неизменяемость), а значит всё должно быть хорошо. Ну, так и работают неявные преобразования в C++, **вы можете навешивать `const` везде, куда хотите, но не можете его убирать**.

Константными могут быть и составные типы (в частности, структуры). Тогда у этой структуры просто будут константными все поля.