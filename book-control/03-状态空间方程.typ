#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "状态空间方程",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 状态空间
<状态空间>

== 状态空间方程

对弹簧阻尼系统

$ m dot.double(x) + B dot(x) + k x = f(t) $

选择状态变量

- $z_1 = x$
- $z_2 = x ̇$

由此，得

$ z ̇ = 1 / m u(t) - B / m z_2 - k / m z_1 $

转化为矩阵形式

$
  dot(z) = A z + B u\
  y = C z + D u
$

对原方程两端做 Laplace 变换，得

$ m s^2 X(s) + B s X(s) + k X(s) = F(s) $

结合状态空间方程，有

$ G(s) = frac(X (s), F(s)) = frac(Y (s), U(s)) = frac(1, m s^2 + B s + k) $

对状态空间方程两端做 Laplace 变换，得

$
  Z(s) = (s 𝑰 - 𝑨)^(-1) B U(s)\
  Y(s) = C (s 𝑰 - 𝑨)^(-1) B U(s) + D U(s)
$

由此，得

$ G(s) = frac(Y(s), U(s)) = C (s 𝑰 - 𝑨)^(-1) B + D $

又

$
  s 𝑰 - 𝑨 = mat(delim: "[", s, 0; 0, s) - mat(delim: "[", 0, 1; - k/m, - B/m) = mat(delim: "[", s, - 1; k/m, s + B/m)
$

则

$
  (s 𝑰 - 𝑨)^(-1) = (s 𝑰 - 𝑨)^*|s 𝑰 - 𝑨| =
  frac(mat(delim: "[", s + B/m, 1; - k/m, s), s (s + B/m)) - (-1) k / m =
  frac(mat(delim: "[", s + B/m, 1; - k/m, s), s^2 + B/m s + k/m)
$

代入可知，空间状态方程和传递函数是统一的。

#pagebreak()

== 特征行列式

- $G(s)$的极点：$G(s)$分母的根
  - 决定系统的稳定性
  - 数值上等于$𝑨$的特征值，即$|s 𝑰 - 𝑨|$的根

= 矩阵指数函数

== 推导

对独立方程组

$
  dot(x)_1(t) &= x_1(t)\
  dot(x)_2(t) &= -2 x_2(t)
$

即

$
  dot(x)_1(t) &= x_1 (0) e^t\
  dot(x)_2(t) &= x_2 (0) e^(-2 t)
$

矩阵形式为

$ dv(𝒙, t) = 𝑨 𝒙 $

其中，$𝒙 = mat(delim: "[", x_1; x_2)$。

对耦合方程组

$
  dot(x)_1(t) &= x_1(t) + x_2(t)\
  dot(x)_2(t) &= 4 x_1(t) - 2 x_2(t)
$

矩阵形式中，$𝒙(t) = e^(𝑨 t) 𝒙(0)$。

由 Taylor 级数

$ e^(𝑨 t) = ∑_(i = 0) frac(1, i!)(𝑨 t)^i $

于是

$ dv(e^(𝑨 t), t) = ∑_(i=1) frac(1, (i - 1))! 𝑨^i t^(i - 1) = 𝑨 e^(𝑨 t) $

而$e^(𝑨 t)$被称为矩阵$𝑨$的指数函数。

== 性质

设有矩阵指数函数$e^(𝑨 t)$，则

- 当$𝑨 = 𝟎$，$e^(𝑨 t) = 𝑰$
- 当$𝑨 = 𝚲$，$e^(𝑨 t) = dmat(delim: "[", e^(λ_1 t), e^(λ_t t), ⋱, e^(λ_n t))$
- $e^(𝑨 t) = 𝑷 e^(𝜦 t) 𝑷^(-1)$

对状态空间方程

$ dv(𝒙(t), t) = 𝑨 𝒙(t) + 𝑩 𝒖(t) $

其中，$𝒖(t)$为系统输入。

两端同时乘以$e^(𝑨 t)$，得

$
  e^(-𝑨 t) 𝑩 𝒖(t) = e^(-𝑨 t) dv(𝒙(t), t) - 𝑨 e^(-𝑨 t) 𝒙(t)
  = dv(e^(-𝑨 t) 𝒙(t), t)
$

两端同时定积分，得

$ e^(-𝑨 τ) 𝒙(τ) bar.v_(t_0)^t = ∫_(t_0)^t e^(-𝑨 τ) 𝑩 𝒖(τ) dd(τ) $

整理，得

$ 𝒙(t) = e^(𝑨 (t - t_0)) 𝒙(t_0) + ∫_(t_0)^t e^((t - τ)) 𝑩 𝒖(τ) dd(τ) $

其中

- 第一项的$e^(𝑨 (t - t_0))$被称为状态转移矩阵（$n × n$），其变化由$𝑨$的特征值决定。
- 第二项为卷积运算

= 相平面
<相平面>

== 过渡矩阵

设$𝑷 = mat(delim: "[", 𝒗_1, 𝒗_2)$，则

#let mv = (i, j) => $v_(#(i)#(j))$

$
  𝑨 𝑷 &= mat(delim: "[", 𝑨 𝒗_1, 𝑨 𝒗_2)
  = mat(delim: "[", 𝑨 mat(delim: "[", v_(11); v_(12)), 𝑨 mat(delim: "[", v_(12); v_(22))) = xmat(delim: "[", 2, 2, #mv)
  dmat(delim: "[", λ_1, λ_2) = 𝑷
  dmat(delim: "[", λ_1, λ_2)
$

== 二维相平面
<二维相平面>

#let ma = (i, j) => $a_(#(i)#(j))$

$
  dv(, t)
  mat(delim: "[", z(t)_1; z(t)_2) = 𝑨
  mat(delim: "[", z(t)_1; z(t)_2) =
  xmat(delim: "[", 2, 2, #ma)
  mat(delim: "[", z(t)_1; z(t)_2)
$

- 实数根

#figure(
  table(
    columns: 4,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [$λ_1 λ_2$], [$λ_1 + λ_2$], [点类型], [稳定性],
    [$> 0$], [$< 0$], [node], [✓],
    [$> 0$], [$> 0$], [node], [×],
    [$< 0$], [], [saddle], [×],
  ),
  caption: [实数根],
  supplement: "表",
  kind: table,
)

- 复数根

#figure(
  table(
    columns: 3,
    align: center + horizon,
    inset: 3pt,
    stroke: frame(rgb("000")),
    [$λ_i$], [点类型], [稳定性],
    [$a > 0$], [focus], [×],
    [$a < 0$], [focus], [✓],
    [$a = 0$], [center], [✓⁻],
  ),
  caption: [复数根],
  supplement: "表",
  kind: table,
)

#tip[
  ✓⁻：Lyapunov 稳定，见后续章节。
]
