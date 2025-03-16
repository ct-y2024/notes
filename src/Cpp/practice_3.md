Структура --- обертка над данными
Класс --- обратная тема.
```cpp
class Matrix
{
    Matrix(size_t rows, size_t cols)
        : _rows(rows)
        , _cols(cols)
        , _data(new int[rows*cols])
    {}
private:
    size_t _rows;
    size_t _cols;
    int* _d
```



Приватные чаще называют как-то необычно:

 - `rows_`

 - `_rows` 

-  `m_rows` 

Надо добавить  деструктор

```cpp
    ~Matrix()
    {
        delete[] _data;
    }
```

Заполним  нулями и тогда наш класс выглядит
```cpp
class Matrix {
    Matrix(size_t rows, size_t cols)
            : _rows(rows), _cols(cols), _data(new int[rows * cols]{}) {}

    ~Matrix() {
        delete[] _data;
    }


private:
    size_t _rows;
    size_t _cols;
    int *_data;
};
```

Хотим дефолтный конструктор. Обычно дефолтный конструктор ничего не аллоцирует. Поэтому:
```cpp
Matrix() : _rows(0), _cols(0), _data(nullptr) {}
```
Можно подумать, что нам надо менять деструктор из-за `nullptr`. Но нам не надо менять его, ведь delete проверяет на nullptr.

Хочу member функции:
- копирование
- присваивание 

```cpp
Matrix(const Matrix &other) : _rows(other._rows), _cols(other._cols), _data(new int[_rows * _cols]) {
        for (size_t i = 0; i < _rows * _cols; i++) {
            _data[i] = other._data[i];
        }
    }
```

```cpp
 Matrix &operator=(const Matrix &other) {
        if (this == &other) { // взятие внутрь
            return *this;
        }

        delete[] _data;
        _rows = other._rows;
        _cols = other._cols;
        _data = new int[_rows * _cols];
        for (size_t i = 0; i < _rows * _cols; i++) {
            _data[i] = other._data[i];
        }

        return *this;
    }
```