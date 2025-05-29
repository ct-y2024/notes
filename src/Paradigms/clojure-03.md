# Объекты на clojure


## JavaScript - style
```clj
(def point {:x 10 :y 20})

(def spoint {:prototype point :dx 1 :dy 2 :y 200})
```
Пока магии нет. Сделаем магию:

```clj
(defn proto-get
  "Returns object property respecting the prototype chain"
  ([this key] (proto-get this key nil))
  ([this key default]
   (cond
     (contains? this key) (this key)
     (contains? this :prototype) (proto-get (this :prototype) key default)
     :else default)))
```
Теперь магия работает.

```clj
(def point {
    :x 10 
    :y 20
    :getX (fn [this] (proto-get this :x))
    :getY (fn [this] (proto-get this :y))
    :setX (fn [this value] (assoc this :x value))
    :setY (fn [this value] (assoc this :y value))
    :add (fn [this a b] ( + a b))})
(def spoint {
    :prototype point 
    :dx 1 
    :dy 2
    :getX (fn [this] (+ (proto-get this :x) (proto-get this :dx)))
    :getY (fn [this] (+ (proto-get this :y) (proto-get this :dy)))
    })
```

```clj
(defn proto-call
  "Calls object method respecting the prototype chain"
  [this key & args]
  (apply (proto-get this key) this args))
```

Синтаксис выглядит не самым хорошим образом. JS-like objects.

```clj
(defn field
  "Creates field"
  [key] (fn
          ([this] (proto-get this key))
          ([this def] (proto-get this key def))))

(defn method
  "Creates method"
  [key] (fn [this & args] (apply proto-call this key args)))

(defn constructor
  "Defines constructor"
  [ctor prototype]
  (fn [& args] (apply ctor {:prototype prototype} args)))
```

Если честно, то это выглядит очень страшно и этим настолько страшно пользоваться, что я не хочу это 

```clj
(section "Syntactic sugar")

(example "Field declaration"
         (defn field
           "Creates field"
           [key] (fn
             ([this] (proto-get this key))
             ([this default] (proto-get this key default)))))
(example "Method declaration"
         (defn method
           "Creates method"
           [key] (fn [this & args] (apply proto-call this key args))))
(example "Fields"
         (def __x (field :x))
         (def __y (field :y))
         (def __dx (field :dx))
         (def __dy (field :dy)))
(example "Methods"
         (def _getX (method :getX))
         (def _getY (method :getY))
         (def _setX (method :setX))
         (def _setY (method :setY))
         (def _add (method :add)))

(example "Points"
         (def point
           {:x 10
            :y 20
            :getX __x
            :getY __y
            :setX (fn [this x] (assoc this :x x))
            :setY (fn [this y] (assoc this :y y))
            :add (fn [this a b] (+ a b))
            })
         (def shifted-point
           {:prototype point
            :dx 1
            :dy 2
            :getX (fn [this] (+ (__x this) (__dx this)))
            :getY (fn [this] (+ (__y this) (__dy this)))
            }))
(example "Fields usage"
         (__x point)
         (__x shifted-point)
         (__dx shifted-point)
         (__dx point 100))
(example "Methods usage"
         (_getX point)
         (_getX shifted-point)
         (_getX (_setX shifted-point 1000))
         (_add shifted-point 2 3))


(section "Constructors")

(example "Constructor declaration"
         (defn constructor
           "Defines constructor"
           [ctor prototype]
           (fn [& args] (apply ctor {:prototype prototype} args))))

(example "Supertype"
         (declare _Point)
         (def _distance (method :distance))
         (def _length (method :length))
         (def _sub (method :sub))
         (def PointPrototype
           {:getX __x
            :getY __y
            :sub (fn [this that] (_Point (- (_getX this) (_getX that))
                                         (- (_getY this) (_getY that))))
            :length (fn [this] (let [square #(* % %)] (Math/sqrt (+ (square (_getX this)) (square (_getY this))))))
            :distance (fn [this that] (_length (_sub this that)))
            })
         (defn Point [this x y]
           (assoc this
             :x x
             :y y))
         (def _Point (constructor Point PointPrototype)))

(example "Subtype"
         (def ShiftedPointPrototype
           (assoc PointPrototype
             :getX (fn [this] (+ (__x this) (__dx this)))
             :getY (fn [this] (+ (__y this) (__dy this)))))
         (defn ShiftedPoint [this x y dx dy]
           (assoc (Point this x y)
             :dx dx
             :dy dy
             ))
         (def _ShiftedPoint (constructor ShiftedPoint ShiftedPointPrototype)))

(example "Instances"
         (def point (_Point 10 20))
         (def shifted-point (_ShiftedPoint 10 20 1 2))
         (_getX point)
         (_getX shifted-point)
         (__x point)
         (__x shifted-point)
         (__dx shifted-point)
         (_length (_Point 4 3))
         (_sub (_Point -1 -2) (_Point 2 2))
         (_distance (_Point -1 -2) (_Point 2 2)))
```
## Java style

Интерфейсы:
```clj
(definterface IPoint
  (^Number getX [])
  (^Number getY []))
```
Имплементация:
```clojure
(deftype JPoint [x y]
  IPoint
  (getX [this] (.-x this))
  (getY [this] (.-y this)))
(deftype JShiftedPoint [x y dx dy]
  IPoint
  (getX [this] (+ (.-x this) (.-dx this)))
  (getY [this] (+ (.-y this) (.-dy this))))


(def point (JPoint. 10 20))
point
(type point)
(def shifted-point (JShiftedPoint. 10 20 1 2))
shifted-point
(type shifted-point)
```