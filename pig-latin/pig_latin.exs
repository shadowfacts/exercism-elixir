defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    ~w(#{phrase})
      |> Enum.map(&word/1)
      |> Enum.join(" ")
  end

  @vowel_sounds ~w(a e i o u)

  def word(word) do
    if Enum.member?(@vowel_sounds, String.first(word)) do
      "#{word}ay"
    else
      {_, index} = first_vowel(word)
      before = before_index(word, index)
      remaining = after_index(word, index)
      "#{remaining}#{before}ay"
    end
  end

  def before_index(word, 0), do: ""
  def before_index(word, index), do: String.slice(word, 0..index-1)

  def after_index(word, 0), do: word
  def after_index(word, index), do: String.slice(word, index..-1)

  def first_vowel(word) do
    word
      |> String.graphemes
      |> Enum.with_index
      |> Enum.find(fn el -> is_vowel(el, word) end)
  end

  def is_vowel({"u", index}, word), do: index == 0 || String.at(word, index - 1) != "q"
  def is_vowel({"x", index}, word), do: index == 0 && String.length(word) > 1 && !Enum.member?(@vowel_sounds, String.at(word, 1))
  def is_vowel({"y", index}, word), do: index == 0 && String.length(word) > 1 && !Enum.member?(@vowel_sounds, String.at(word, 1))
  def is_vowel({c, index}, word), do: Enum.member?(@vowel_sounds, c)
end
