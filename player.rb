# frozen_string_literal: true

class Player
  attr_accessor :name, :score

  def initialize(name)
    self.name = name
    self.score = 0
  end

  def self.create_name(player_number)
    puts "What is Player #{player_number}\'s name?"
    name = gets.chomp
    name.empty? ? "Player #{player_number}" : name
  end
end
