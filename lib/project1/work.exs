defmodule Worker do
  @moduledoc """
  Documentation for worker.

  Receive the left and right number, then caculate the sum of squire number.

  Check whether the sum is a squire number and send return message to supervisor.
  """
  def start() do
    receive do
      {:ok, left, right, s_pid} ->
        num = isSquareNumber(left, right, 0)
        send(s_pid, {:return, num})
    end
    start()
  end

  def isSquareNumber(left, right, sum) when left<right do
    isSquareNumber(left, right-1, sum+right*right)
  end

  def isSquareNumber(left, right, sum) when left==right do
    if :math.sqrt(sum+right*right)==trunc(:math.sqrt(sum+right*right)) do
      left
    else
      -1
  end
end
end