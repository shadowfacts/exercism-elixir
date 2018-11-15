defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    prefix(number) <> items(number) <> "."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
      |> Enum.to_list
      |> Enum.map(&verse/1)
      |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  @number_words ~w(
    first
    second
    third
    fourth
    fifth
    sixth
    seventh
    eighth
    ninth
    tenth
    eleventh
    twelfth
  )

  def prefix(day), do: "On the #{Enum.at(@number_words, day - 1)} day of Christmas my true love gave to me: "

  @items [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  def items(1), do: Enum.at(@items, 0)
  def items(2), do: "#{Enum.at(@items, 1)}, and #{Enum.at(@items, 0)}"
  def items(day) do
    Enum.at(@items, day - 1) <> ", " <> items(day - 1)
  end
end
