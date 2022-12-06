require 'pry'

class CryptoKey
  attr_reader :key

  def initialize(key)
    @key = key.strip
  end

  def >(other)
    return :draw if decrypted_key == other.decrypted_key

    case decrypted_key
    when :rock
     other.decrypted_key == :scissors ? :win : :lose
    when :paper
     other.decrypted_key == :rock ? :win : :lose
    when :scissors
     other.decrypted_key == :paper ? :win : :lose
    end
  end

  def score
    case decrypted_key
    when :rock then 1
    when :paper then 2
    when :scissors then 3
    end
  end

  def decrypted_key
    crypto_key[key]
  end

  private

  def crypto_key
    {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }
  end
end

class Round
  attr_reader :my_choice, :opponent_choice
  def initialize(data)
    @opponent_choice, @my_choice = data.split(" ").map{|d| CryptoKey.new(d) }
  end

  def score
    score = case my_choice > opponent_choice
    when :win then 6
    when :draw then 3
    when :lose then 0
    else
      raise StandardError, "CryptoKey#> returned a weird value: #{my_choice > opponent_choice}"
    end

    my_choice.score + score
  end
end

class Solver
  attr_reader :rounds
  def initialize
    data = File.read(File.join(File.dirname(__FILE__), 'input')).strip
    @rounds = data.split("\n").map{ |d| Round.new(d) }
  end

  def solve
    score = rounds.reduce(0) { |acc, round| acc + round.score }
    puts "Answer: #{score}"
  end
end

Solver.new.solve


