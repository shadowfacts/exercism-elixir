defmodule Bob do
  def hey(input) do
  	empty = input |> String.trim |> String.length == 0
  	yelling = yelling?(input)
  	question = question?(input)
    cond do
    	empty -> "Fine. Be that way!"
    	yelling && question -> "Calm down, I know what I'm doing!"
    	yelling -> "Whoa, chill out!"
    	question -> "Sure."
    	true -> "Whatever."
    end
  end

  def has_letters?(s), do: String.match?(s, ~r/[\p{L}]/)
  def yelling?(s), do: has_letters?(s) && String.upcase(s) == s
  def question?(s), do: String.ends_with?(s, "?")
end
