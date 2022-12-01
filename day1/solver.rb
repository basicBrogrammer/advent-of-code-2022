data = File.read("./data.txt")

class Elf 
  attr_reader :rations, :position

  def initialize(rations, position)
    raise ArgumentError, "rations must be a string" unless rations.is_a?(String)

    @rations = rations.split("\n").map(&:to_i)
    @position = position + 1
  end

  def total_rations
    @rations.reduce(:+)
  end
end

elves = data.split("\n\n").each_with_index.map{ |elf_data, idx| Elf.new(elf_data, idx)}
elves.sort_by! { |elf| elf.total_rations }.reverse!
# elf_with_most_calories = elves.last
# puts "Elf number #{elf_with_most_calories.position} has the most calories (#{elf_with_most_calories.total_rations})"
top_3_elves = elves.slice(0, 3)

puts "The top 3 elves are carrying #{top_3_elves.map(&:total_rations).reduce(:+)} calories"

