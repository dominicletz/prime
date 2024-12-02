#!/usr/bin/env elixir

defmodule Prime do
  def check_prime(number) do
    check_prime(number, 2)
  end

  def check_prime(number, divisor) do
    cond do
      rem(number, divisor) == 0 -> 0
      divisor >= div(number, divisor) -> 1
      true -> check_prime(number, divisor + 1)
    end
  end
end

if not File.exists?("prime.csv") do
  File.write("prime.csv", "number,prime\n1,1\n2,1\n3,1\n4,0\n")
end

[number, _prime] = File.read!("prime.csv") |> String.split("\n", trim: true) |> List.last() |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)

for i <- 1..100 do
  if Prime.check_prime(number+i) == 1 do
    IO.puts("#{number+i},1")
    File.write("prime.csv", "#{number+i},1\n", [:append])
    {_, 0} = System.cmd("git", ["commit", "-m", "Added #{number+i} to prime.csv"])
  end
end
