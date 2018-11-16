defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
  	word
  		|> String.downcase
  		|> String.graphemes
  		|> Enum.map(&letter_score/1)
  		|> Enum.reduce(0, fn(score, acc) -> score + acc end)
  end

  def letter_score(l) when l in ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"], do: 1
  def letter_score(l) when l in ["d", "g"], do: 2
  def letter_score(l) when l in ["b", "c", "m", "p"], do: 3
  def letter_score(l) when l in ["f", "h", "v", "w", "y"], do: 4
  def letter_score("k"), do: 5
  def letter_score(l) when l in ["j", "x"], do: 8
  def letter_score(l) when l in ["q", "z"], do: 10
  def letter_score(_), do: 0
end
