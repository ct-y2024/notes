# Clojure Basics

## Основы

Везде, где можно поставить пробел, можно поставить и запятую

```clj
(println "Hello, Clojure!")

(println (+ 1 2 3 4))
(println (type 1))
(println (type 1/2))
(println (type 1.45))

(println (not "hello"))
(println (not nil))
(println (not false))
```
Данный код выведет:

```
Hello, aboba228!
10
java.lang.Long
clojure.lang.Ratio
java.lang.Double
false
true
true
```

Тут есть аналог больших чисел:

```clj
(println (+ 10N 20N))                                       ; Big Int тип
```


## Функции и переменные

```clj
(def add +)                                               ; умеем задавать
(println (add 10 20 30))


; def - специальная форма
(def x (* 30 40))                                           ; переменная
(println x)

(defn square [x] (* x x))                                   ; функция
(println (square x))

(println ((fn [x] (+ x x)) 10))                             ; функции могут быть анонимными

(defn twice [f] (fn [x] (f (f x))))                         ; функции могут быть от функций
(println ((twice square) 10))
(println (#(+ %1 %2) 10 30))

```

## Рекурсия
```clj
(defn rec-fib [n]
  (cond (== 0 n) 1
        (== 1 n) 1
        :else (+ (rec-fib (- n 1)) (rec-fib (- n 2)))       ; сюда вместо else можно написать арбуз
        )
  )
(println (mapv rec-fib (range 1 10)))
```
Как и ожидается данная функция будет работать, как числа фиббоначи.

```clj
(def rec-fib2
  (fn [n] (cond (== 0 n) 1
                (== 1 n) 1
                :else (+ (rec-fib2 (- n 1)) (rec-fib2 (- n 2)))
                ))
  )
(println (mapv rec-fib2 (range 1 10)))
```

Улучшим и теперь наша функция будет сохранять результат вычислений
```clj
(def rec-fib3
  (memoize (fn [n] (cond (== 0 n) 1N
                         (== 1 n) 1N
                         :else (+ (rec-fib3 (- n 1)) (rec-fib3 (- n 2)))
                         ))
           ))
(println (mapv rec-fib3 (range 1 10)))
(println (rec-fib3 100))
```
memoize внутри себя честно кеширует. Но у нас стек заканчивается и тильт

## Всякие приколы

```clj 
(defn iter-fib' [n a b]
  (if (== 0 n)
    a
    (iter-fib' (- n 1) b (+' a b)))
  )

(defn iter-fib [n]
  (iter-fib' n 1 1))

(println (mapv iter-fib (range 1, 10)))
```
Мы можем это заменить

```clj
(defn iter-fib [n]
  (letfn [(rec [n a b]
     (if (== 0 n)
       a
       (recur (- n 1) b (+' a b))))]
  (rec n 1 1)))

(println (mapv iter-fib (range 1, 10)))
```

Синтаксический сахар
```clj
(defn iter-fib [n']
  (loop [n n' a 1 b 1]
     (if (== 0 n)
       a
       (recur (- n 1) b (+' a b)))))

(println (mapv iter-fib (range 1, 10)))

```


## Pred Post

```clj
(defn power
  "Raises a to b-th power"
  [a,b]
  {:pre[(<= 0 b)]
   :post[(or (== b 0) (zero? a) (zero? (mod % a)))]}
  (cond
    (zero? b) 1
    (even? b) (power (* a a) (quot b 2))
    (odd? b) (* a (power a (dec b)))
    )
  )
(println (power 2 10))
```

## Стандартная библиотека 

```clj
(list 10 20 30)
(list? (list 10 20 30)) ; предикат для списка
(count (list 10 20 30)) ; 3
 ```
 Это список. Бывает пустой. Круглые скобки - пустой 

 Листы реализованы связными списками.

```clj
[10 20 30] ; вектор
(count [10 20 30]) ; 3
```

Есть пару веселых функций:

```clj
(conj [10 20 30] 100 200) ; => [10 20 30 100 200]
```
Вектор ведет себя как стек, лист как стек сначала.

```clj
(mapv) честно вернет вектор от того, что вы просили
```

```clj
(identity 30) ; => 30
```

```clj
((constatly 30) 34892312 213512 3120913) => 30
```

```clj
((comp square inc) 10) ; обычная композиция
```