# Лекция 2

Мы умеем вводить из консоли:

```clj
(defn hello []
  (let [input (read-line)]
    (println "Hello, " input)))
(hello)
;Aboba228
;Hello,  Aboba228
```

Умеем много вводить из консоли:
```clj
(defn hello []
  (let [input (read-line)]
    (if (= "." input) nil
                      (do (println "Hello, " input) (recur)))))
(hello)
; hello
; Hello,  hello
; clojure
; Hello,  clojure
; .
;
; Process finished with exit code 0
```

Умеем считать более умные штуки:

```clj
(defn rsum []
  (loop [sum 0]
    (let [input (read-line)]
      (if (= "." input)
        sum
        (let [sum' (+ sum (read-string input))]
          (println "sum = " sum')
          (recur sum')
          )
        ))
    ))
(rsum)
; 10
; sum =  10
; 20
; sum =  30
; 30
; sum =  60
; .

; Process finished with exit code 0
```

Вот так произвольные штуки
```clj 
(defn io [f input output]
  (spit output (f (slurp input))))
  ```
Пользоваться иожем так:
```clj
(io (fn [input] (apply str (mapv #(str "Hello, " % "\n") (clojure.string/split-lines input))))
    "data/hello.in"
    "data/hello.out"
    )
; "hello.in"
; Aboba 
; hi hi
; 
; "hello.out"
; Hello, Aboba  
; Hello, hi hi
```

```clj
(type (read-string "10")) ;Java.lang.Long
(type (read-string "(+ 10 x (* x y))")) ;clojure.lang.PersistentList
(mapv type (read-string "(+ 10 x (* x y))")) ;clojure.lang.Symbol java.lang.Long clojure.lang.PersistentList
```
read-string читает в кложурские формы

`'y` - обозначает символ y

```clj
(def expr (read-string "(+ 10 x (* x y))"))
(def x 10)
(def y 20)
(eval expr) ;220
(def y 200)
(eval expr) ;2020
```
```clj
(defn trace [value]
    (println "\t\t" value)
    value)
(defn add [x y]
    (trace "add")
    (+ x y ))
(add (trace 10) (trace 20))
; 10
; 20
; add
; Аппликативный порядок
(defn add [x y]
    (trace "add")
    (+ (eval x) (eval y) ))
(add '(trace 10) '(trace 20))
;add 
;10
;20 
; оно может несколько раз считать одно и то же
; Нормальный порядок

; Есть ленивый порядок!
(defn add [x y]
    (trace "add")
    (+ (force x) (force y) ))
(add (delay(trace 10)) (delay(trace 20)))
```
ГК: сейчас мы будем наглеть

```clj
;мы ушли в свой неймспейс ks
(defn cons [h t] [h t])
(defn first [[h t]] h)
(defn rest [[h t]] (force t))
(def empty nil)
(defn empty? [stream] (= empty stream))
(defn count [stream]
    (if (empty? stream) 0) 0 (inc (count (rest stream))))
(defn to-list [stream]
    (if (empty? stream) () 
    (c/cons (first stream)
    (to-list (rest stream))
    ))
)
(defn map [f stream]
    (if (empty? stream) empty)
    (c/cons (f (first stream))
        (map (rest stream))
        ) 
    )
(defn filter [p? stream]
(if (empty? stream) empty 
    (let [tail (filter p? (rest stream))] 
    (if (p? (first stream))
        (cons (first stream) tail)
        tail))))

(defn take [n stream]
    (cond (empty? stream) empty 
          (pos? n) (cons (first stream) (take (dec n) (rest stream)))
          :else empty))

(defn take-while [p? stream]
    (cond (empty? stream) empty 
          (p? (first-stream)) (cons (first stream) (take-while p? (rest stream)))
          :else empty))

(defn some [p? stream]
    (cond (empty? stream) false 
          (p? (first-stream)) true
          :else (some p? (rest stream))))

(defn every [p? stream]
    (cond (empty? stream) true
          (p? (first-stream)) (every p? (rest stream))
          :else false))
```

Создадим всякие приколы:
```clj
(def ones (ks/cons  1 (delay ones)))

(defn ints [n]
    (ks/cons s (ints (inc n))))
```
Получили бесконечную структуру данных!
```clj
(def primes 
    letfn(prime? [n]
          (not (ks/some #(zero? (mod n %) )
            (ks/take-while #(>= n (* % %)) primes)
          )))
          (ks/cons 2 (ks/filter prime? (ints 3))))
; ГК забыл делей у функций в  cs
(def lazy-ints [n] (lazy-seq n (lazy-ints (inc n))))

(def primes 
    letfn(prime? [n]
          (not (some #(zero? (mod n %) )
            (take-while #(>= n (* % %)) primes)
          )))
          (lazy-seq 2 (filter prime? ())))

(apply vector (take 30 primes ))
```

Есть отображение:
```clj
{"x" 1 "y" 2}
(type {"x" 1 "y" 2}) ; clojure.lang.PersistentArrayMap
(map? {"x" 1 "y" 2}) ; true
(empty? {"x" 1}) ;false
(contains? {"x" 1} "x") ; true
(contains? {"x" 1} "y") ; false
(contains? {"x" 1} 1) ; false
(count {"x" 1 "y" 2}) ; 2
(get {"x" 1 "y" 2} "x") ;1
(get {"x" 1 "y" 2} "z") ;nil
(keys {"x" 1 "y" 2} ) ; (x y)
(vals {"x" 1 "y" 2}) ; (1 2)
(assoc {"x" 1 "y" 2} "z" 3) ; добавило z
(assoc {"x" 1 "y" 2} "z") ; убавило я 
```