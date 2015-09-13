require IEx

IO.puts "Hello world
from Elixir"

# ========
# Анонимные функции

add = fn a, b -> a + b end
IO.puts add.(1, 3)

add_two = fn a -> add.(a, 2) end
IO.puts add_two.(4)

IO.puts (fn x -> "Hey, I'm anonymouse function. I return #{x}" end).("tvoju mamku")

# ========
# case

case {1, 2, 3} do
  {4, 5, 6} ->
    IO.puts "This clause won't match"
  {1, 2, 3} ->
    IO.puts "This clause will match and bind x to 2 in this clause"
  _ ->
    IO.puts "This clause would match any value"
end

# ========
# _ выступает в роли else

x = 3

case x do
  1 -> IO.puts "x = 1"
  2 -> IO.puts "x = 2"
  _ -> IO.puts "x not 1 or 2"
end


# ========
# В конструкции case можно использовать
# закешированное значение используя ^

foo = fn ->
  10
end
x = foo.()

IO.puts x

case 10 do
  ^x -> IO.puts "Won't match"
  _  -> IO.puts "Will match"
end


# =========
# cond

cond do
  2 + 2 == 5 ->
    IO.puts "This will not be true"
  2 * 2 == 3 ->
    IO.puts "Nor this"
  1 + 1 == 2 ->
    IO.puts "But this will"
end

cond do
  2 + 2 == 5 ->
    "This is never true"
  2 * 2 == 3 ->
    "Nor this"
  true ->
    "This is always true (equivalent to else)"
end

# любое значение кроме nil и false срабатывает как true
cond do
  hd([1,2,3]) ->
    "1 is considered as true"
end

# =========
# if

if true do
  IO.puts "This works!"
end

unless true do
  IO.puts "This not works!"
end

if nil do
  IO.puts "This won't be seen"
else
  IO.puts "This will"
end

# =========
# do/end blocks

if true, do: IO.puts(1 + 2)

if true do
  a = 1 + 2
  IO.puts a + 10
end

if true, do: (
  a = 1 + 3
  IO.puts a + 10
)

IO.puts if false, do: :this, else: :that

# =========
# Keyword lists

list = [{:a, 1}, {:b, 2}]
IO.puts list[:a]

foo = list ++ [c: 2]
bar = [a: 0] ++ foo

IO.inspect bar

# =========
# Maps

map = %{:a => 1, 2 => :b}
IO.puts map[:a]
IO.puts map[2]

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

IO.puts FooMath.sum(665, 1)

IO.puts FooMath.zero?(0)
IO.puts FooMath.zero?(1)


# ===========
# Захват функции

func = &Math.sum/2
# 2 это арность функции.

IO.puts func.(1,3)

# можно присваивать целые выражения
f = &(&1 + &2 + func.(1, 5))


# ===========
# Дефолтные параметры

defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world


defmodule DefaultTest do
  def dowork(x \\ IO.puts "DefaultTest - hello") do
    x
  end
end

IO.puts DefaultTest.dowork      #=> DefaultTest - hello
IO.puts DefaultTest.dowork 123  #=> 123


# ==========
# Рекурсия

defmodule Recursion do

  def greeting(string, n) when n <= 1 do
    IO.puts string
  end

  def greeting(string, n) do
    IO.puts string
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

Array.sum([5,2,3,6,1,7], 0)



