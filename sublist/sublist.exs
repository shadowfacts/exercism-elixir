defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
  	cond do
  		a === b -> :equal
  		Enum.count(b) >= Enum.count(a) && sublist?(a, b) -> :sublist
  		Enum.count(a) > Enum.count(b) && sublist?(b, a) -> :superlist
  		true -> :unequal
  	end
  end

  def prefix?([], _), do: true
  def prefix?(_, []), do: false
  def prefix?([small_head | small_tail], [big_head | big_tail]) do
  	small_head === big_head && prefix?(small_tail, big_tail)
  end

  def sublist?([], _), do: true
  def sublist?(_, []), do: false
  def sublist?(small, big) do	
  	prefix?(small, big) || sublist?(small, tl(big))
  end
end
