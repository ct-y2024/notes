#import "../../../../common/template.typ": *
#include "../../../../common/template.typ"
#set heading(numbering: "1.1")
#let Ker = $op("Ker")$
#let Im = $op("Im")$
#let dim = $op("dim")$
#let span = $op("span")$
#let rg = $op("rg")$
#let def = $op("def")$
#let Hom = $op("Hom")$
#let End = $op("End")$
#let Aut = $op("Aut")$
#let diag = $op("diag")$
#let dsum = $limits(sum)$
#let dprod = $limits(product)$
#let QED = align(right)[Q.E.D.]
#let fbox(content) = rect(inset: 2pt, content)
// #hide[
// #text(0.0em)[
// =
// =
// =
// =
// =
// =
// ]
// ]
= Линейные отображения
== Основные определения. Теорема о ранге и дефекте линейного отображения.

$U, V$ --- линейные пространства над одним полем $K(RR, CC)$

Отображение $cal(A): U -> V$ называется *линейным* (или гомоморфизмом), если: 
$ forall lambda in K forall u_1, u_2 in V: cal(A)(u_1 + lambda u_2) = cal(A)(u_1) + lambda cal(A)(u_2) $

*Замечания.*
1. $cal(A)(u) = cal(A)u$
2. При фиксированном аргументе и разных отображениях $cal(A) и cal(B)$, $cal(A)u$ и $cal(B)u$ являются векторами и их можно складывать и домножать на скаляр.
3. $cal(A)bb(0)_U = bb(0)_V$

$forall lambda in K$, $cal(A), cal(B): U -> V$ --- линейные отображения:
- $lambda cal(A): U -> V$ --- *умножение отображения на скаляр*:
$ forall u in U: (lambda cal(A)) u = lambda(cal(A) u) $
- $cal(A) + cal(B): U -> V$ --- *сумма отображений*:
$ forall u in U: (cal(A) + cal(B))u = cal(A)u + cal(B)u $

*Нулевое линейное отображение* $cal(O): U -> V$: 
$ forall u in U: cal(O)u = bb(0)_V $

Заметим, что $cal(O)$ --- нейтральный элемент относительно сложения отображений.

Заметим, что $-1 cal(A) = -cal(A)$ --- элемент, обратный $cal(A)$ относительно сложения отображений.

Оказывается, что выполняются все 8 аксиом линейного пространства, значит обозначим $L(U, V) = Hom_K (U, V) = Hom(U, V)$, как линейное пространство всех линейных отображений из $U$ в $V$.

$cal(A) in L(U, V)$:
- $Im(cal(A)) = {v in V, v = cal(A)u | forall u in U}$ --- *образ линейного отображения*, является линейным подпространством.
- $Ker(cal(A)) = {u in U | cal(A)u = bb(0)_v}$ --- *ядро линейного отображения*, является линейным подпространством. Ядро всегда не пустое, так как $bb(0)_U in Ker(cal(A))$.

$rg cal(A) = dim(Im(cal(A)))$ --- *ранг отображения*.

$def cal(A) = dim(Ker(cal(A)))$ --- *дефект отображения*.

$cal(A) in L(U, V)$:
- $cal(A)$ --- *сюръекция*, если: 
$ Im cal(A) = V <=> rg cal(A) = dim(V) $
- $cal(A)$ --- *инъекция*, если:
$ Ker cal(A) = {bb(0)_V} <=> def cal(A) = 0 $
То есть:
$ forall u_1, u_2 in U: cal(A)u_1 = cal(A)u_2 => u_1 = u_2 $
$ cal(A)u_1 = cal(A)u_2 <=> cal(A)(u_1 - u_2) = bb(0)_V <=> u_1 - u_2 in Ker cal(A) $
- $cal(A)$ --- *биекция (изоморфизм)*, если:
$ cases(Im cal(A) = V, Ker cal(A) = {bb(0)_U}) <=> cases(rg cal(A) = dim V, def cal(A) = 0) $
- $cal(A)$ --- *эндоморфизм (линейный оператор)*, если $U = V$.
- $cal(A)$ --- *автоморфизм*, если является изоморфизмом и эндоморфизмом, то есть: 
$ cases(U = V, rg cal(A) = dim(V), def cal(A) = 0) $

Пусть $U = K^n, V = K^m, cal(A): U -> V = A = (a_(i j))_(m times n), a_(i j) in K$, то есть отображение представляет собой умножение матрицы на вектор. Тогда:
- $Im cal(A) = Im A = {y in K^m | y = A x forall x in K^n} = span(A_1, ..., A_n)$ --- *образ матрицы*.
- Определение ранга $A in M_(m times n)$совпадает с определением ранга $A in L(K^n, K^m)$:
$ rg cal(A) = dim span(A_1, ..., A_n) = rg A $
- $A$ --- сюръекция $<=> rg A = m$
- $ker A = {x in k^n | A x = 0}$ --- *ядро матрицы*, общее решение СЛОУ $A x = 0$.
- $def A = dim Ker A$ --- размерность общего решения СЛОУ $A x = 0$, то есть $n - rg A$ --- *дефект матрицы*.
- $dim U = n = def A + rg A$

Если отображение $cal(A) = A$:
- Инъекция, то:
$ def A = 0 <=> n - rg A = 0 <=> rg A = n $
- Изоморфизм, то:
$ cases(rg A = n, rg A = m) <=> n = m $
Значит матрица квадратная. По теореме об изоморфизме:
$ U limits(tilde.equiv)_A V <=> dim U = dim V $
- Автоморфизм, то:
$ rg A = n = m<=> exists A^(-1) $
- Эндоморфизм, то:
$ n = m <=> K^n = K^m $

$cal(A) in L(W, V), cal(B) in L(U, W)$. $cal(A) cal(B): U -> V = cal(A) dot cal(B)$ --- *Произведение (композиция) отображений*. Очевидно, что $cal(A) dot cal(B) in L(U, V)$.

Свойства:
1. $cal(A), cal(B)$ --- изоморфизмы $=> cal(A) dot cal(B)$ --- изоморфизм.
2. $cal(A)(cal(B)_1 + cal(B)_2) = cal(A)cal(B)_1 + cal(A)cal(B)_2$, $(cal(A)_1 + cal(A)_2)cal(B) = cal(A)_1cal(B) + cal(A)_2cal(B)$ --- левая и правая дистрибутивность.
3. $forall lambda in K: cal(A)(lambda cal(B)) = (lambda cal(A)) cal(B) = lambda(cal(A)cal(B))$
4. $cal(C) in L(V, Omega): cal(A)(cal(B)cal(C)) = (cal(A)cal(B))cal(C) = cal(A)cal(B)cal(C)$

Тогда $End(V)$ --- множество всех эндоморфизмов на $V$, является ассоциативной унитальной алгеброй. Нейтральным элементом для произведения служит $Epsilon_V$: $forall v in V: Epsilon_V v = v$

Если $cal(A) in L(U, V)$ --- изоморфизм, то $exists cal(A)^(-1): V -> U => cal(A)^(-1) in L(V, U)$ --- тоже изоморфизм.
$ cal(A) cal(A)^(-1) = Epsilon_U $
$ cal(A)^(-1) cal(A) = Epsilon_V $

$forall v_1 = cal(A)u_1, lambda v_2 = cal(A)u_2$:
$ cal(A)u_1 + lambda cal(A)u_2 &= cal(A)(u_1 + lambda u_2) = v_1 + lambda v_2 \
u_1 + lambda u_2 &= cal(A)^(-1) v_1 + lambda cal(A)^(-1) v_2 = cal(A)^(-1)(v_1 + lambda v_2) $
Значит $cal(A)^(-1) in L(V, U)$

$cal(A) in End(V)$ --- изоморфизм $<=> cal(A) in Aut(V)$ --- множество всех автоморфизмов.

Значит $cal(A)^(-1) in End(V) <=> cal(A)^(-1) in Aut(V)$ --- *обратный оператор* к $cal(A)$.
$ cal(A) cal(A)^(-1) = cal(A)^(-1) cal(A) = Epsilon_V $

Пусть $U_0 subset.eq U$ --- линейное подпространство, $cal(A) in L(U, V)$. 

Тогда $cal(A)_0 = cal(A) bar_U_0 : U_0 -> V$ --- *сужение линейного отображения* на линейное подпространство $U_0$. 
$ forall u in U_0: cal(A)_0 u = cal(A) u $
$cal(A)_0 in L(U_0, V)$ --- линейное отображение.

*Утверждение.* Если $cal(A) in L(U, V)$ --- изоморфизм, то $cal(A)_0 = cal(A) bar_U_0 in L(U_0, Im cal(A)_0)$ --- изоморфизм.

Доказательство:
- Сюръекция --- очевидно.
- Инъекция: $Ker cal(A)_0 subset.eq Ker cal(A) = {bb(0)_U} => Ker cal(A)_0 = {bb(0)_U}$
Значит $cal(A)_0$ --- изоморфизм.
#QED

*Теорема о ранге и дефекте линейного отображения*:
$ forall cal(A) in L(U, V): dim(V) = def cal(A) + rg cal(A) $

Доказательство:

Пусть $U_0 = Ker cal(A) subset.eq U$ --- линейное подпространство.

Пусть $U_1 subset.eq U$ --- линейное подпространство и прямое дополнение $U_0$: $U_0 plus.circle U_1 = U$
$ cal(A)_1 = cal(A) bar_(u_1) in L(u_1, Im cal(A_1)) $
$ forall u in U exists! space.med u = u_0 + u_1, u_0 in U_0, u_1 in U_1 $
$ cal(A) u = cal(A) u_0 + cal(A) u_1 = cal(A)u_1 $
$ Im cal(A) = Im cal(A)_1 => rg cal(A) = rg cal(A)_1 $
Покажем, что $cal(A)_1$ --- изоморфизм:
- Сюръекция --- очевидно.
- Инъекция: 
$ cases(reverse:#true, Ker cal(A)_1 subset.eq U_1, Ker cal(A)_1 subset.eq Ker cal(A)) => Ker cal(A)_1 subset.eq U_0 sect U_1 = {bb(0)_U} $

$cal(A)_1$ --- изоморфизм, значит: 
$ dim U_1 = dim Im cal(A)_1 = dim Im cal(A) = rg cal(A) $
$ U_0 plus.circle U_1 = U <=> dim U = dim U_0 + dim U_1 = def cal(A) + rg cal(A) $
#QED


*Следствие (характеристика автоморфизма).*
$ cal(A) in Aut(V) <=> rg cal(A) = dim V ("то есть " Im cal(A) = V) <=> def cal(A) = 0 ("то есть " Ker cal(A) = {bb(0)_V}) $

== Матрица линейного отображения. Координатный изоморфизм. Формула замены матрицы линейным отображением при замене базиса.

$cal(A) in L(U, V)$

$xi = (xi_1, ..., xi_n)$ --- базис $U$

$eta = (eta_1, ..., eta_m)$ --- базис $V$

$ u in U stretch(<->)_"координатный изоморфизм" u = vec(u_1, dots.v, u_n) in K^n, u = dsum_(i = 1)^n u_i xi_i $
$ v in V stretch(<->)_"координатный изоморфизм" v = vec(v_1, dots.v, v_m) in K^m, v = dsum_(j = 1)^m v_j eta_j $

Пусть $v in V = cal(A) u, u in U$:

$ v = cal(A)(dsum_(i = 1)^n x_i xi_i) = dsum_(i = 1)^n x_i cal(A) xi_i, cal(A) xi_i in V $
$ Im cal(A) = span(cal(A) xi_1, ..., cal(A) xi_n) $
$ rg cal(A) = rg(cal(A) xi_1, ..., cal(A) xi_n) $
$ cal(A) xi_i = dsum_(j = 1)^m a_(j i) eta_j stretch(<->)_"координатный изоморфизм" A_i = vec(a_(1 i), dots.v, a_(m i)) in K^m $

$A = (A_1, ..., A_n) = (a_(i j))_(m times n)$ --- *матрица линейного отображения* $cal(A)$ в базисах $xi, eta$ пространств $U$ и $V$ соответственно.

Так как $A_i$ --- координатный изоморфизм, то по свойствам изоморфизма:
$ rg(cal(A)) = rg(cal(A) xi_1, ..., cal(A) xi_n) = rg (A_1, ..., A_n) = rg(A) $
$ (cal(A) xi_1, ..., cal(A) xi_n) = (eta_1, ..., eta_m) A $

$cal(A) in End(V), e = (e_1, ..., e_n)$ --- базис $V$

$cal(A) e_i = dsum_(j = 1)^n a_(j i) e_j <=> (cal(A) e_1, ..., cal(A) e_n) = (e_1, ..., e_n) A$. 

$A$ --- квадратная *матрица оператора* $cal(A)$ в базисе $e$

*Утверждение.* $dim U = n, dim V = m$:
$ L(U, V) tilde.equiv M_(m times n) $

Доказательство:

- Взаимноодназначность --- уже есть
- Линейность --- проверим:
$ lambda in K: cal(A) + lambda cal(B) limits(<->)^? A + lambda B $
Где $A$ и $B$ --- соответствующие матрицы для $cal(A)$ и $cal(B)$ в базисах $(xi, eta)$.
$ i = 1 ... n: (cal(A) + lambda cal(B)) xi_i = cal(A) xi_i + lambda cal(B) xi_i = dsum_(j = 1)^m a_(j i) eta_j + lambda dsum_(j = 1)^m b_(j i) eta_j = dsum_(j = 1)^m (a_(j i) + lambda b_(j i)) eta_j $
$ (cal(A) + lambda cal(B)) limits(<->) (a_(j i) + lambda b_(j i))_(m times n) = (a_(j i))_(m times n) _ lambda (b_(j i))_(m times n) = A + lambda B $

*Утверждение.* $cal(A) in L(W, V), cal(B) in L(U, W)$; $omega, eta, xi$ --- базисы $W, V, U$; $A$ --- матрица $cal(A)$ в базисах $(omega, eta)$; $B$ --- матрица $cal(B)$ в базисах $(xi, omega) => A B$ --- матрица $cal(A) cal(B)$ в базисах $(xi, eta)$.

Доказательство:

$ cal(A) cal(B) xi_i = cal(A) (cal(B) xi_i) = cal(A) (dsum_(k = 1)^p b_(k i) omega k) = \
= dsum_(k = 1)^p b_(k i) cal(A) omega_k = dsum_(k = 1)^p b_(k i) dsum_(j = 1)^m a(j k) eta_j = \
= dsum_(j = 1)^m (dsum_(k = 1)^p a(j k) b_(k i)) eta_j = dsum_(j = 1)^m (A B)_(j i) eta_j $

*Следствие.* $cal(A) in L(U, V)$ --- изоморфизм, $A$ --- матрица $cal(A)$ в базисах $(xi, eta) => A^(-1)$ --- матрица $cal(A)^(-1)$ в базисах $(eta, xi)$.

Пусть $X$ --- матрица $cal(A)^(-1)$. Тогда:
$ cal(A) cal(A)^(-1) = Epsilon_V <=> A X = E $
$ cal(A)^(-1) cal(A) = Epsilon_V <=> X A = E $

$cal(A)$ --- изоморфизм $<=> dim V = dim V = n = rg cal(A) = rg A <=> exists A^(-1) => X = A^(-1)$

$cal(A) in L(limits(U)_xi, limits(V)_eta)$

$v = cal(A)u$

$v limits(<->)^eta sans(v) in K^m$

$u limits(<->)^xi sans(u) in K^n$

$ dsum_(j = 1)^m sans(v) eta_j = v = cal(A)u = dsum_(i = 1)^n sans(u)_i cal(A) xi_i = dsum_(i = 1)^n sans(u)_i dsum_(j = 1)^m a_(j i) eta_j = dsum_(i = 1)^n dsum_(j = 1)^m a_(j i) sans(u)_i eta_j $
$ sans(v) = dsum_(i = 1)^n a_(j i) sans(u)_i <=> sans(v) = A sans(u) $
Значит $sans(v) = A sans(u)$ --- форма записи отображения $cal(A)$ в базисах $(xi, eta)$, где $sans(u)$ --- координаты $u$ в $xi$, а $sans(v)$ --- координаты $v$ в $eta$.

*Теорема (Формула замены матрицы линейного отображения при замене базиса).*

$cal(A) in L(U, V)$, $xi, xi'$ --- базисы $U$, $eta, eta'$ --- базисы $U$:
$ cases(reverse:#true, cal(A) stretch(<->)_(xi, eta) A, cal(A) stretch(<->)_(xi', eta') A') => A' = T_(eta -> eta')^(-1) A T_(xi -> xi') $

Доказательство:

Построим схему отображений:
$ &U_xi& limits(->)^cal(A) V_eta & \
script(T_(xi -> xi') <-> Epsilon_U)&arrow.t & quad arrow.t & script(Epsilon_V <-> T_(eta -> eta'))\
&U_xi'& limits(->)^cal(A') V_eta'& $
$ cal(A) = Epsilon_V^(-1) cal(A) Epsilon_V <=> A' = T_(eta -> eta')^(-1) A T_(xi -> xi') $

*Следствие.* $cal(A) in End(V)$; $e, e'$ --- базисы $V$:
$ cases(reverse:#true, cal(A) limits(<->)_e A, cal(A) limits(<->)_e' A') => A' = T_(e -> e')^(-1) A T_(e -> e') $

Квадратные матрицы $A$ и $B$ --- *подобны*, если $exists$ невырожденная матрица $C$ такая, что 

$B = C^(-1) A C$

Значит матрицы операторов в разных базисах подобны.

*Замечание.*

$ cases(reverse:#true, v = cal(A)u stretch(<->)_((xi, eta)) sans(v) = A sans(u), v = cal(A)u stretch(<->)_((xi', eta')) sans(v)' = A' sans(u)') => cases(sans(v)' = T_(eta -> eta')^(-1) sans(v), sans(u) = T_(xi -> xi') sans(u)') $
$ sans(v)' = T_(eta -> eta')^(-1) sans(v) = T_(eta -> eta')^(-1) A sans(u) = T_(eta -> eta')^(-1) A T_(xi -> xi') sans(u)' = A' sans(u)' $

Значит форма записи линейного отображения не зависит от выбора базиса.

== Инварианты линейного отображения.

*Инвариант* --- некоторое свойство объекта, которое не меняется при определенных действиях и преобразованиях.

$cal(A)$ --- линейное отображение. Ранг и дефект инварианты относительно выбора базиса.

Пусть $cal(A) in End(V)$. Пусть $e_1, ..., e_n$ --- базис $v$.

Как мы знаем, $ exists! D$ $n$-форма, такая что $D(e_1, ..., e_n) = 1$. Тогда 
*определитель линейного оператора*:
$ det cal(A) = det(cal(A) e_1, ..., cal(A) e_n) = D(cal(A) e_1, ..., cal(A) e_n) $ 
*Замечание.* $det cal(A) = D(cal(A) e_1, ..., cal(A) e_n) = D(A e_1, ..., A e_n) = det A$ --- определение определителя линейного оператора и матрицы соотносятся.

*Теорема.*

$ forall cal(A) in End(V), det cal(A) = det A $

Доказательство:

Возьмем $e = (e_1, ..., e_n)$ базис $V$. Тогда:
$ cal(A) stretch(<->)_"вз. однозначно" A = (a_(i j))_(n times n) $
$ 
det cal(A) &= D(cal(A)e_1, ..., cal(A) e_n) = D(dsum_(i = 1)^n a_(i 1) e_(i_1), ..., dsum_(i = 1)^n a_(i n) e_(i_n)) = \
&= dsum_(i_1=1)^n ... dsum_(i_n=1)^n a_(i_11) dot ... dot a_(i_(n n)) D(e_(i_1), ..., e_(i_n)) = \
&= dsum_(sigma in S_n) a_(i_1 1) dot ... dot a_(i_n n) dot (-1)^(epsilon(sigma)) D(e_1, ..., e_n)= det A 
$ 

#QED

*Замечание.* $A$ и $B$ подобные матрицы, то $det A = det B$. 

*Замечание.* $det cal(A)$ --- инвариант линейного оператора, он не зависит от базиса.

*Следствие 1.* $forall n$-форма $f$ на $V$:
$ forall xi_1, ..., xi_n in V: f(cal(A) xi_1...., cal(A) xi_n) = det A f(xi_1, ..., xi_n) $ 
Доказательство:

Возьмем $e = (e_1, ..., e_n)$ --- базис $V$. $cal(A) stretch(<->)_e A$. Это значит, что мы берем матрицу линейного оператора в данном базисе.
$ f(cal(A) e_1, ..., cal(A) e_n) stretch(=)^"из доказательства теоремы" det A f(e_1, ..., e_n) $ 
На самом деле $alpha = f(e_1, ..., e_n)$, поэтому:
$ forall xi_1, ...,xi_n: g(xi_1,...,xi_n):= f(cal(A) xi_1,..., cal(A) xi_n) $ 
Заметим, что $g$ - полилинейное, т.к. $f$ полилинейное и $cal(A)$ - линейное отображение. Также $g$ - антисимметричное, т.к. $f$ - антисимметричное. откуда $g$ --- $n$-форма. Заметим интересный факт:
$ g(e_1, ..., e_n) = f(cal(A) e_1, ..., cal(A) e_n) = det A dot f(e_1, ..., e_n) $ 
откуда:
$ g(xi_1, ..., xi_n)= g(e_1, ..., e_n) D(xi_1, ..., xi_n) = det A dot alpha D(xi_1, ..., xi_n) = det A dot f(xi_1, ..., xi_n) $ 
#QED

*Замечание.* Мы можем вывести 9-ое свойство определителя по-другому. Пусть $cal(A) = A_(n times n)$ --- линейный оператор умножения.
$f = D$, $B_j in K^n$. Тогда:
$ det(A B_1, ..., A B_N) = det A dot det B $
*Следствие 2.* $cal(A), cal(B) in End(V) => det(cal(A) cal(B)) = det cal(A) dot det cal(B)$

Доказательство:

Пусть $e$ - базис $V$. Тогда $cal(A) stretch(<->)^e A, cal(B)stretch(<->)^e B$. Также $cal(A) cal(B) stretch(<->)^e A B$ по свойству. откуда:
$ det cal(A) cal(B) = det(A B) = det A dot det B = det cal(A) dot det cal(B) $ 
#QED

*Следствие 3.* $cal(A) in Aut(V) <=> det A != 0$. Причем $det cal(A)^(-1) = (1)/(det cal(A))$

Доказательство:
$ 
cal(A) in Aut(V) <=> 
cases(cal(A) in End(V), "изоморфизм") <=> 
cases(cal(A) in End(V), def cal(A) = dim ker cal(A) = 0) <=> 
cases(cal(A) in End(V), rg cal(A) = n) <=> 
cases(cal(A) stretch(<->)^e A "," det A != 0, rg A = n) $ 
Мы знаем, что существует $cal(A)^(-1)$. А также $cal(A) dot cal(A)^(-1) = epsilon $. откуда по свойству 3 получаем, что $det cal(A)^(-1)=det cal(A)
$
#QED

*Следствие 4.* $det(cal(A) cal(A)^(-1)) = 1 = det cal(A) dot det cal(A)^(-1)$

Вспомним старое определение $tr A = dsum_(i = 1)^n a_(i i)$ - _след матрицы_.

*Теорема (о следе подобных матриц).*

Если $A$ и $B$ подобны, то $tr A = tr B$.

Доказательство:

$A$ и $B$ подобны $<=> exists C: B = C^(-1) A C$. Пусть $C^(-1) = S = (s_(i j))$. откуда:
$ tr B = dsum_(i = 1)^n b_(i i) = dsum_(i = 1)^n dsum_(j = 1)^n s_(i j) (A C)_(j i) = dsum_(i = 1)^n dsum_(j = 1)^n dsum_(k = 1)^n s_(i j) dot a_(j k) dot c_(k i) = dsum_(j = 1)^n dsum_(k = 1)^n a_(j k) dsum_(i = 1)^n c_(k i)s_(i j) $ 
Заметим, что $(C S)_(k j) = delta_(k j)$, где $ delta_(k j) = cases(1"," k = j, 0 "," k != j)$. Так что получаем, что 
$ tr B = dsum_(i = 1)^n a_(i i) = tr A $ 
#QED

*Следствие.* $ forall cal(A) in End(V) => tr(A) = tr A'$, где $A$ и $A'$ матрицы оператора $cal(A)$ в базисе $e$ и $e'$ соответственно.

$cal(A) in End(V), tr cal(A) = tr A$ --- *след оператора*.

*Замечание.* след оператора инвариантен из следствия выше.

Линейное подпространство $L subset V$ называется *инвариантным* относительно линейного оператора $cal(A) in End(V)$, если $ forall v in L, cal(A) v in L$.

*Теорема 1.*

$L subset V$ - линейное подпространство. $L$ - инвариантно относительно $cal(A) in End(V)$. Тогда $exists$ базис пространства $V$ матрица, такой что матрица оператора $cal(A)$ в этом базисе будет иметь _ступенчатый вид_, при этом размерность $A^1 = k times k, k = dim L$.
$ A = mat(
A^1, *;
bb(0), A^2
) $ 
Доказательство:

$L = span (e_1, ..., e_k)$ - базис $L$.

Дополним базис $L$ до базиса $V$: $V = span (e_1,..., e_k, e_(k+1),...,e_n)$.

Запишем матрицу $A$ по определению:

$ forall e_i in L: cal(A) e_i in L => cal(A) e_i = dsum_(j=1)^k a_(j i) e_j <=> A_i = vec(a_(1i), dots.v, a_(k i), 0, dots.v, 0) $ 
откуда $A = mat(
a_(1 1), ..., a_(1 k), *, ..., *; 
dots.v, dots.down, dots.v, dots.v, dots.v, dots.v; 
a_(k 1), ..., a_(k 1), dots.v, dots.v, dots.v; 
0, ..., 0, dots.v, dots.v, dots.v; 
0, ..., 0, *, ..., *; 
) => A^1 = mat(
a_(1 1), ..., a_(1 k); 
dots.v, dots.down, dots.v; 
a_(k 1), ..., a_(k 1); 
)$

#QED

*Теорема 2.*

$V = limits(plus.circle.big)_(i = 1)^m L_i$, $L_i$ инвариантны относительно $cal(A) => exists$ базис пространства $V$, такое что матрица оператора $cal(A)$ будет иметь блочно-диагональный вид: 
$ 
mat(
A^1, ..., ..., bb(0); 
dots.v, A^2, ..., dots.v; 
dots.v, dots.v, dots.down, dots.v; 
bb(0), ..., ..., A^n
) $ 
Доказательство:

Пусть базис $V stretch(=)^("по эквив. условию" plus.circle)$ объединение базисов $L_i$.
$ L_i = span (e_1^i, ...,e_(k_i)^i), dim L_i = k_i $ 
Построим матрицу по определению. Не трудно заметить, что для каждого $L_i$ из доказательства прошлой теоремы, все кроме соответствующих строчек для $L_i$ будет зануленно.
#QED

*Замечание.* $A_i <-> A|_(L_i) in End(L_i)$.


*Теорема 3.*

$V = limits(plus.circle.big)_(i = 1)^m L_i$, $L_i$ инвариантны относительно $cal(A) => Im cal(A) = limits(plus.circle.big)_(i = 1)^m Im cal(A)|_(L_i)$, где
$cal(A)|_(L_i) in L(L_i,V)$


Доказательство:
$ V = limits(plus.circle.big)_(i = 1)^m L_i stretch(<=>)_"из т. об экв. опр. прямой суммы" forall v in V: exists! v = dsum_(i = 1)^m v_i, v_i in L_i $ 
$ forall v in V: Im cal(A) in.rev cal(A) v = cal(A) dsum_(i = 1)^m v_i = dsum_(i = 1)^m cal(A) v_i in Im A|_(L_i) $ 
Тогда всё, что нам осталось проверить это то, что наши пространства дизъюнкты. Но, если присмотреться к тому, что у нас написано, то у нас для любого вектора из $Im cal(A)$ существует лишь одно разложение через $Im A|_(L_i)$, что соответствует эквивалентному определению прямой суммы.
#QED

== Собственные числа и собственные векторы линейного оператора

$lambda in K $ называется *собственным числом* $cal(A) in End(V)$, если $ exists v in V,v!= 0$. $cal(A) v = lambda v$. Такой $v$ называют *собственным вектором* собственного числа $lambda$.

$ lambda in K: cases(cal(A) v = lambda v, v!= 0) <=> 
cases((A - lambda epsilon) v = 0, v != 0) <=>
cases(v in ker (A - lambda epsilon), v != 0)<=> $
$v$ --- собственный вектор собственного числа $lambda$.

$V_(lambda) = ker (A - lambda epsilon)$ --- *собственное подпространство* $cal(A)$ соответствующего собственного числа $lambda$. Это мн-во всех собственных векторов $V$, отвечающим собственному числу $lambda$ и нулевой вектор.

$gamma(lambda) = dim V_(lambda)$ --- *геометрическая кратность*.

*Свойства.*
1. $V_(lambda)$ инвариантно относительно $(cal(A) - lambda epsilon)$.
2. $V_(lambda)$ инвариантно относительно $cal(A)$.
3. $gamma(lambda)$ инвариант относительно базиса.

*Условие существования собственного числа*
$lambda in K_(cal(A))$ --- собственное число, $v$ --- собственный вектор $<=> ker (A - lambda epsilon)$ нетривиально $ <=> def(cal(A) - lambda epsilon) != 0 <=> rg(cal(A) - lambda epsilon) != n <=> det(cal(A) - lambda epsilon) = 0$

Т.к. определитель линейного оператора инвариантен, то:
$ det(cal(A) - lambda epsilon) = 0 <=> det(A - lambda E) = 0 $ 
$chi(t) = det(cal(A) - t epsilon)$ --- *характеристический многочлен* оператора $cal(A)$.

Т.к. $det$ оператора инвариантен $chi(t) = det(A - t E)$, где $A$ - матрица линейного оператора $cal(A)$ в некотором базисе.
$ chi(t) = mat(delim:"|",
a_(1 1) - t, a_(1 2), ..., a_(1 n); 
a_(2 1), a_(22)-t, ..., dots.v; 
dots.v, dots.v, dots.down, dots.v; 
a_(n 1), a_(n 2), ..., a_(n n) - t
) = (-1)^(n) dot t^n + (-1)^(n -1 )(tr A t^(n-1)) + ... + det A $ 
По теореме Виета:
$ cases(t_1 + ... + t_n = tr A, t_1 dot ... dot t_n = det A) $
Заметим, что $lambda$ --- собственное число $cal(A) <=> cases(
lambda in K, chi(lambda) = 0 "- корень хар. мн.")$

*Замечание.* Если все корни хар. мн. $in K$, то $cases(lambda_1 + ... + lambda_n = tr A, lambda_1 dot ... dot lambda_n = det A)$

*Спектром* оператора $cal(A)$ называется множество ${(lambda$, $alpha(lambda))}$, $alpha(lambda)$ - кратность $lambda$ лин. оператора в хар. уравнении (_алгебраическая кратность_). Спектр это множество пар.

*Простой спектр* --- все кратности равны 1.

*Теорема 1.*

$ forall cal(A) in End(V)$. $forall lambda$ с.ч. $cal(A) : 1 <= gamma(lambda) <= alpha(lambda)$

Доказательство:

$lambda$ с.ч. $cal(A) <=> ker(cal(A) - lambda epsilon) = V_(lambda)$ не тривиально $ <=> gamma_1 = dim V_lambda >= 1$.

Пусть $dim V_(lambda) = gamma$, $V_(lambda)$ инвариантно относительно $cal(A)$, значит по теореме 1 об инварианте подпространств существует $V$ такой, что матрица оператора $cal(A)$ будет иметь ступенчатый вид:
$ A = mat(
A^1, *; 
bb(0), A^2
) $ 
$ dim A^1 = gamma times gamma, V = span (e_1,..., e_(gamma), e_(gamma + 1), ..., e_(gamma)) $ 

При построении матрицы оператора $cal(A)$:

$cal(A) e_i = lambda e_i <=> A_i = vec(dots.v, 0, lambda, 0, dots.v)$ - $lambda$ на $i$-ой строчке. Немного распишем:

$ 
chi(t) &= det(A - t E) = \
&= mat(delim:"|",
A^1 - t E_(gamma times gamma), *; 
bb(0), A^2 -t E_((n-gamma) times (n-gamma))
) stretch(=)^"по 6-ому св-ву определителей" \
&= |A^1 - t E||A^2 - t E| = chi_(A^1)(t) dot chi_(A^2)(t) = \
&= (lambda - t)^gamma chi_(A_2)(t) => $
$=> lambda$ корень $chi(t)$, причем кратность $>= gamma$, т.к $lambda$ может оказаться корнем $chi_(A^2)$
#QED


*Теорема 2.*

$lambda_1, lambda_2, ..., lambda_n$ попарно различные с.ч $cal(A)$, $v_1, ..., v_n$ соответствуют с.в. $=> v_1,...,v_n$ --- линейно независимы.

Доказательство:

Докажем по индукции:

- База: $m = 1: lambda_1, v_1 => $ линейно независимы.

- Индукционный переход: Пусть верно для $m$, докажем для $m + 1$:

От противного: Пусть $lambda_1, ..., lambda_m, lambda_(m + 1)$ попарно различные собственные числа. 

$v_1, ..., v_m$ --- линейно независимы по предположению. $v_1, ..., v_m, v_(m + 1)$ - линейно зависимы. Откуда: $v_(m + 1) = dsum_(i = 1)^m alpha_i v_i$. С одной стороны:
$ cal(A) v_(m + 1) = lambda_(m + 1) v_(m + 1) = lambda_(m + 1) dsum_(i = 1)^m alpha_i v_i $ 
С другой стороны:
$ cal(A) v_(m + 1) = cal(A) dsum_(i = 1)^m alpha_i v_i = dsum_(i = 1)^m alpha_i cal(A) v_i = dsum_(i = 1)^m alpha_i lambda_i v_i $ 
$ dsum_(i = 1)^m (lambda_(m+1) - lambda_i) a_i v_i = 0 $ 

Но мы знаем, что $v_1, ..., v_m$ линейно независимы. Откуда эта линейная комбинация тривиальна, но с другой стороны, она такой быть не может, потому что $exists alpha_i != 0$, для которого $v_i$ не равен нулю, а так же, исходя из того что искомые с.ч. попарно различны, то $v_(m + 1) - v_i != 0$. Откуда комбинация нетривиальна. 
Противоречие.
#QED

*Следствие* $lambda_1, ..., lambda_m$ попарно различные с.ч. $cal(A) => limits(plus.circle.big)_(i = 1)^m V_(lambda_i)$, т.е $V_(lambda_i)$ дизъюнктны.

Доказательство:

$ bb(0) = v_1 + ... + v_m, v_i in V_(lambda_i) $ 
Если в сумме какой-то из векторов не нулевой, то это собственный вектор, а собственные вектора для различных с.ч. линейно независимы. Противоречие. откуда все вектора в сумме нулевые, откуда подпространства дизъюнктны.
#QED

*Теорема 3*

$V = limits(plus.circle.big)_(i = 1)^m L_i$, $L_i$ инвариантно относительно $cal(A) in End(V)$. Тогда:

$ chi(t) = det(cal(A) - t epsilon) = dprod_(i = 1)^m chi_(cal(A)_i)(t) $

Доказательство:

Смотрим теорему 3 об инв. подпр. Матрица A - блочно-диагональная:
$ A = mat(
A^1, ..., ..., bb(0); 
dots.v, A^2, ..., dots.v; 
dots.v, dots.v, dots.down, dots.v; 
bb(0), ..., ..., A^n
) $ 
Тогда $chi(t) = det(A - t E) stretch(=)^"по 6-ому свойству опр." dprod_(i = 1)^m det(A^i - t E) = dprod_(i = 1)^m chi_(A_i)(t) $
#QED


== Оператор простой структуры (о.п.с). Проекторы. Спектральное разложение. Функция от диагонализированной матрицы.

$cal(A) in End(V)$ называется *оператором простой структуры (о.п.с)*, если $exists$ базис пространства $V$ такой, что матрица оператора $cal(A)$ в этом базисе имеет диагональный вид.
$ Lambda = diag(lambda_1,...,lambda_n) = mat(
lambda_1, ..., 0; 
dots.v, dots.down, dots.v; 
0, ..., lambda_n
) $ 

Заметим, что в таком случае собственные числа оператора $cal(A)$ будут $lambda_i$, а так же собственные вектора этих чисел - соотв. столбики (легко проверить умножением). Отсюда все корни характеристического многочлена $chi in K <=> dsum_(lambda "- с.ч." cal(A)) alpha(lambda) = n = dim V$.

*Теорема.*

$ forall A in End(V)$, если $dsum_(lambda "-с.ч." cal(A)) alpha(lambda) = n$, то тогда:

$ cal(A) " - о.п.с" <=> forall lambda " - с.ч": gamma(lambda) = alpha(lambda) <=> dsum_(lambda "-с.ч." cal(A)) gamma(lambda) = n = dim V $ 

Доказательство:

$ dsum_(lambda "-с.ч." cal(A)) alpha(n) = n <=>$ все корни $chi in K$, откуда $cal(A)$ - о.п.с.

$cal(A)$ о.п.с. $<=> exists$ базис $V$ такой, что матрица диагональна $<=>$ 
$ <=> V = limits(plus.circle.big)_(lambda - "с.ч.")V_(lambda) <=> dsum_(lambda - "с.ч.") gamma(lambda) = n = dim V $ 
#QED

*Следствие.* Если все корни характ. многочлена $in K$, а также все $alpha(lambda) = 1$ (спектр простой), то $cal(A)$ - о.п.с.

$A_(n times n)$ называется *диагонализируемой*, если она подобна диагональной.

*Теорема (критерий диагональности матрицы $A$).*

#strike[это перепишем]

$A$ подобна диагональной $<=>$ матрица о.п.с $cal(A)$ в некотором базисе

Доказательство:


- #fbox($=>$)

Пусть $A$ - диагонализируемая $<=>$ подобна диагональной $<=> exists$ невырожд T: $T^(-1) A T= Lambda = diag(lambda_1, ..., lambda_n)$. $V$ - линейное пространство над полем $K$. $e = (e_1, ..., e_n)$ - базис $V$.

Пусть $A$ - матрица в базисе $e$. Тогда $A e_j = dsum_(i = 1)^n a_(i j)e_i$. $v =(v_1, ..., v_n)$ - базис.

Откуда $v_1, ..., v_n = (e_1, ..., e_n) T_(e -> v) => cal(A) stretch(<->)^v) A' = T^(-1) A T = Lambda$ 

- #fbox($arrow.l.double$)

$cal(A)$ о.п.с, $A$ - матрица в некотором базисе $e = (e_1, ..., e_n)$.
Возьму $v_1, ..., v_n$ - базис $V$, где $v_i$ - собственный вектор $cal(A)$. Заметим, что так как $cal(A)$ о.п.с, то такой базис существует.

Теперь давайте возьмем матрицу перехода из $T_(e -> v)$. Тогда $cal(A) stretch(<->)^v) A' = T^(-1) A T = Lambda => A$ подобна диагональной 
#QED

*Алгоритм поиска диагонального представления матрицы подобной диагональной*
1. Найти спектр: если все корни $chi in K $, переходим к 2.
2. Найти все $gamma(lambda)$, если $forall lambda$ с.ч $gamma(lambda) = alpha(lambda)$, то перейти к 3.
3. $T_("кан." -> v) = (v_1, ..., v_n)$ $T^(-1) A T = Lambda$
