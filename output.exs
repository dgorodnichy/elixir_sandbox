require IEx

IO.puts "Hello world
from Elixir"

# ========
# Анонимные функции

add = fn a, b -> a + b end
add.(1, 3) #=> 4

add_two = fn a -> add.(a, 2) end
add_two.(4) #=> 6

(fn x -> "Hey, I'm anonymouse function. I return #{x}" end).("tvoju mamku")
#=> Hey, I'm anonymouse function. I return tvoju mamku

# ========
# case

case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, 2, 3} ->
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "This clause would match any value"
end
#=> This clause will match and bind x to 2 in this clause

# ========
# _ выступает в роли else

x = 3

case x do
  1 -> "x = 1"
  2 -> "x = 2"
  _ -> "x not 1 or 2"
end
#=> x not 1 or 2

# В конструкции case можно использовать
# закешированное значение используя ^

foo = fn ->
  10
end
x = foo.()
x #=> 10

case 10 do
  ^x -> "Won't match"
  _  -> "Will match"
end
#=> Won't match


# =========
# cond

cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end
#=> But this will

cond do
  2 + 2 == 5 ->
    "This is never true"
  2 * 2 == 3 ->
    "Nor this"
  true ->
    "This is always true (equivalent to else)"
end
#=> "This is always true (equivalent to else)"

# любое значение кроме nil и false срабатывает как true
cond do
  hd([1,2,3]) ->
    "1 is considered as true"
end
#=> "1 is considered as true"

# =========
# if

if true do
  "This works!"
end
#=> "This works!"

unless true do
  "This not works!"
end
#=> nil

if nil do
  "This won't be seen"
else
  "This will"
end
#=> "This will"

# =========
# do/end blocks

if true, do: (1 + 2)
#=> 3

if true do
  a = 1 + 2
  a + 10
end
#=> 13

if true, do: (
  a = 1 + 3
  a + 10
)
#=> 14

if false, do: :this, else: :that
#=> :that

# =========
# Keyword lists

list = [{:a, 1}, {:b, 2}]
list[:a] #=> 1

foo = list ++ [c: 2] #=> [a: 1, b: 2, c: 2]
bar = [a: 0] ++ foo  #=> [a: 0, a: 1, b: 2, c: 2]

# =========
# Maps

map = %{:a => 1, 2 => :b}
map[:a] #=> 1
map[2]  #=> :b

# ===========
# Modules

defmodule FooMath do

  # public functions
  def sum(a, b) do
    do_sum(a, b)
  end

  def zero?(0) do
    true
  end

  def zero?(x) when is_number(x) do
    false
  end

  # private function
  defp do_sum(a, b) do
    a + b
  end
end

FooMath.sum(665, 1) #=> 666

FooMath.zero?(0) #=> true
FooMath.zero?(1) #=> false


# ===========
# Захват функции

func = &Math.sum/2
# 2 это арность функции.

func.(1,3) #=> 4

# можно присваивать целые выражения
f = &(&1 + &2 + func.(1, 5))


# ===========
# Дефолтные параметры

defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

Concat.join("Hello", "world")      #=> Hello world
Concat.join("Hello", "world", "_") #=> Hello_world


defmodule DefaultTest do
  def dowork(x \\ IO.puts "DefaultTest - hello") do
    x
  end
end

DefaultTest.dowork      #=> DefaultTest - hello
DefaultTest.dowork 123  #=> 123


# ==========
# Рекурсия

defmodule Recursion do

  def greeting(string, n) when n <= 1 do
    string
  end

  def greeting(string, n) do
    string
    greeting(string, n-1)
  end

end

Recursion.greeting("Hello!", 3)
#=> Hello!
#=> Hello!
#=> Hello!

defmodule Array do
  def sum([head|tail], accumulator) do
    sum(tail, accumulator + head)
  end

  def sum([], accumulator) do
    IO.puts accumulator
  end
end

Array.sum([5,2,3,6,1,7], 0) #=> 24

# =============
# Enumerables

Enum.map([1, 2, 3], fn x -> x * 2 end)
#=> [2, 4, 6]

Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)
#=> [2, 12]

# ranges:
Enum.map(1..4, fn x -> x end)
#=> [1, 2, 3, 4]

odd? = &(rem(&1, 2) != 0)
Enum.filter(1..3, odd?)
#=> [1, 3]

1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum
#=> 7500000000

Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))
#=> 7500000000


# ============
# Streams

1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
#=> 7500000000

