defmodule Supervise do
  @moduledoc """
  Documentation for Supervise.

  First, get N and K from argument.

  Secondly, using spawn to generate worker and storage worker's pid into pid_list.

  Thirdly, using send function to send number to each worker and then return the result. if result equal to -1, which means that the squire sum is not a squire number.

  Finally, get the answer of each worker from buffer and save in ans_list. Then sort the list and print it. 
  """
  def start(args) do
    [n, k] = args
    {n, _} = Integer.parse(n)
    {k, _}= Integer.parse(k)
    num_actor = 1000;
    num_loop = div(n, num_actor) + 1
    s_pid = self()
    pid_list = []
    ans_list = []
    pid_list = 
    for x <- Enum.to_list(1..num_actor) do
      pid = spawn(Worker, :start, [])
      pid_list ++ pid
    end
    pid_list

    for x <- Enum.to_list(1..num_loop) do
      for y <- Enum.to_list(1..num_actor) do
        left = (x - 1) * num_actor + y
        right = left + k - 1 
        if left <= n do
          pid = Enum.at(pid_list, y - 1);
          send(pid, {:ok, left, right, s_pid})
        end
      end
    end
    
    ans_list =
    for x <- Enum.to_list(1..n) do
      ans = getAns()
      if ans != -1 do
        ans_list ++ ans
      end
    end
    ans_list
    ans_list = Enum.filter(ans_list, & !is_nil(&1))
    ans_list = Enum.sort(ans_list)
    list_length = length ans_list
    for x <- Enum.to_list(0..list_length - 1) do
      IO.puts Enum.at(ans_list, x)
    end
    '''
    IO.puts inspect(ans_list)
    '''
  end

  def getAns() do
    receive do
      {:return, num} ->
        num
    end
  end
end