defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
  	words = String.split(sentence, ~r/[^\p{L}\p{N}-]/u)
  	Enum.reduce(words, %{}, fn (word, acc) ->
  			case word do
  				"" -> acc
  				_ -> Map.update(acc, String.downcase(word), 1, fn count -> count + 1 end)
  			end
  	end)
  end
end
