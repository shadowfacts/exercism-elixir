defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    use Bitwise

    code
      |> Integer.digits(2) # split the code into binary digits
      |> Enum.take(-4) # take only the five LO bits, ignore any higher ones
      |> Enum.reverse # order HO -> LO
      |> Enum.with_index
      |> Enum.map(&command/1)
      |> Enum.reject(&is_nil/1) # remove nils included by command
      |> reverse(code &&& 0b10000) # reverse if the reverse bit is set
  end

  @commands %{
    0 => "wink",
    1 => "double blink",
    2 => "close your eyes",
    3 => "jump"
  }
  
  def command({1, index}), do: @commands[index]
  def command({0, index}), do: nil
  
  def reverse(actions, 0b10000), do: Enum.reverse(actions)
  def reverse(actions, 0b00000), do: actions
end
