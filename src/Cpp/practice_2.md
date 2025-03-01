На прошлой домашке мы поработали с syscall в линуксе. А сейчас хочется писать кросс - платформенный код.

Мы пользовались: ```sys_read(fd, buffer, size)```

Сегодня мы будем говорить про файловые комманды. Например про:

### Примеры комманд вывода:

#### write
Например если пользоваться пользовательскими вызовами:

```cpp
#include <unistd.h>

int main() {
    const char(&arr)[6] = "hello";
    const char * str = arr;
    write(1, str, 5);
}
```

Данная программа выведет ```hello```. 

#### fwrite

```cpp
#include <cstdio>

int main() { 
    // Используем std::fwrite для вывода строки "hello"
    // 1-й аргумент: указатель на данные для записи
    // 2-й аргумент: размер каждого элемента (1 байт для char)
    // 3-й аргумент: количество элементов для записи (5 символов)
    // 4-й аргумент: поток вывода (stdout для вывода на консоль)
    std::fwrite("hello", 1, 5, stdout);
}
```
Еще один пример использования ```std::fwrite:```"
```cpp
    int arr[] = {'a','b','c'};
    std::fwrite(&arr, sizeof(int), std::size(arr), stdout);
```
Важно отметить, что строки в C и C++ обычно нультерминированы. Это означает, что в конце строки стоит символ '\0' (нулевой байт). Этот нулевой символ служит признаком конца строки.

Например, строковый литерал "hello" на самом деле занимает 6 байт в памяти: 'h', 'e', 'l', 'l', 'o', '\0'. Как мы и писали ранее.

```cpp
#include <cstdio>
#include <iterator>

int main() {
    int arr[] = {'a' * 256 + 'z', 'b', 'c'};
    std::fwrite(&arr, sizeof(int), std::size(arr), stdout);
}
```
Оно выведет ```za  b   c```, из-за политики little-endian у нас z выведится первым, так и должно быть.

#### fputs, puts

```
signed main() {
    std::fputs("hello\n",stdout);
}
```

У него есть аналог ```puts``` - выводит в stdout. При этом puts добавляет еще перенос строки.

### Примеры комманд ввода:

#### fread
 ```size_t fread(void* ptr, size_t size, size_t count, FILE* stream);```

Параметры:
- ptr: указатель на блок памяти, в который будут записаны прочитанные данные.
- size: размер каждого элемента в байтах.
- count: количество элементов, которые нужно прочитать.
- stream: указатель на объект FILE, представляющий файл, из которого читаются данные.

```cpp
"hello"; //not const char*
         //const char(&)[6]
```

## Примеры кода:

### Вывод из ввода консоли:
```cpp
#include <cstdio>

int main(int argc, char **argv) {
    for (int i = 0; i < argc; i++) {
        std::puts(argv[i]);
    }
}
```
Это программа при вводе ```aboba aboba aboba``` выведет:
```
path\practice1.exe
aboba aboba aboba
```
Причина, по которой программа выводит "path\practice1.exe" в первой строке, заключается в том, что имя файла и путь к нему включаются в аргументы командной строки при запуске программы. Конечно, какой-то плохой человек может передать 0 аргументов, но на то это и плохой человек :)

Это гарантируется вызовом ```execve```, можете в мануале про него почитать.

### Прочитать из файлика и построчно вывести:
```cpp
#include <cstdio>

int main(int argc, char **argv) {
    std::FILE *fd = std::fopen(argv[1], "r");
    int current = std::fgetc(fd);
    while (current != EOF) {
        std::putchar(current);
        current = std::fgetc(fd);
    }
    return 0;
}
```

Лучше писать ```return 0``` в конце программы.

Но теперь наша программа может вылетать с ошибками, обработаем их:

```cpp
#include <cstdio>

int main(int argc, char **argv) {
    if (argc != 2) {
        std::fputs("Wrong number of arguments\n", stderr);
        return 1;
    }

    const char *file_path = argv[1];

    std::FILE *fd = std::fopen(file_path, "r");
    if (fd == nullptr) {
        std::fprintf(stderr, "Could not open file: %s\n", file_path);
        /*
        Или аналогично:
        std::fputs("No such file:", stderr);
        std::fputs(file_path, stderr);
        std::fputs("\n", stderr);
        */
        return 1;
    }
    int current = std::fgetc(fd);
    while (current != EOF) {
        std::putchar(current);
        current = std::fgetc(fd);
    }

    if (std::ferror(fd)) {
        std::fputs("Read error\n", stderr);
        std::fclose(fd);
        return 1;
    }
    std::fclose(fd);
    return 0;
}
```
todo: добавить комментарии

Что делать если fclose завершился с ошибкой - вопрос философский.

Но теперь у нас слабенькие выводы ошибок, давайте поменяем:

``` cpp
#include <cstdio>
#include <cstring>
#include <cstdlib>


int main(int argc, char **argv) {
    if (argc != 2) {
        std::perror("Wrong number of arguments\n");
        return EXIT_FAILURE;
    }

    const char *file_path = argv[1];

    std::FILE *fd = std::fopen(file_path, "r");
    if (fd == nullptr) {
        std::fprintf(stderr, "Could not open file: %s: %s\n", file_path, std::strerror(errno));
        return EXIT_FAILURE;
    }
    int current = std::fgetc(fd);
    while (current != EOF) {
        std::putchar(current);
        current = std::fgetc(fd);
    }

    if (std::ferror(fd)) {
        std::perror("Read error\n");
        std::fclose(fd);
        return EXIT_FAILURE;
    }
    std::fclose(fd);
    return EXIT_SUCCESS;
}
```

### Совпадение содержимого файла со строчкой

> Данную практику писал Чепелин Вячеслав. Скопирован файл Артема  с нашей практики и на нем объяснен код