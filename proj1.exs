defmodule Project1 do
  @moduledoc """
  Documentation for Project1.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Project1.hello()
      :world

  """
  def hello do
    :world
  end

  def main(args,argss) do
    IO.puts args
    IO.puts argss
  end
end

@doc """
send arguments to 
"""
args = System.argv()
Supervise.start(args)


