# frozen_string_literal: true

class Gameboard
  attr_accessor :board

  def initialize
    self.board = Array.new(3) { Array.new(3, 0) }
  end

  def mark_space(x, y, player_number)
    board[x][y] = player_number
  end

  def spot_chosen?(x, y)
    true unless board[x][y].zero?
    false
  end

  def input_valid?(pos)
    pos.gsub(' ', '')
    is_valid = true

    is_valid = false if pos.length >= 3
    pos.each_char { |c| is_valid = false unless user_given_pos_in_threshold? c }

    is_valid
  end

  def space_empty?(coords)
    board[coords[0]][coords[1]].zero?
  end

  def convert_to_coord(pos)
    pos.gsub(' ', '')
    coord = [pos[0].to_i, pos[1].to_i]

    coord.each.with_index do |c, i|
      coord[i] = pos[i] =~ /[A-Za-z]/ ? letter_to_number(pos[i].upcase) : c - 1
    end

    coord
  end

  def number_of_filled_spaces
    board.flatten.reduce(0) { |amount, space| amount + space != 0 ? 1 : 0 }
  end

  def game_won?(player_number)
    winning_lanes = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]],
                     [[0, 0], [1, 0], [2, 0]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]],
                     [[0, 0], [1, 1], [2, 2]], [[2, 0], [1, 1], [0, 2]]]

    is_win = false

    winning_lanes.each do |lane|
      is_win = true if lane.all? { |space| board[space[0]][space[1]] == player_number }
    end

    is_win
  end

  def clear
    self.board = Array.new(3) { Array.new(3, 0) }
  end

  def to_s
    "  A B C\n1 #{get_space_marker 0, 0}|#{get_space_marker 1, 0}|#{get_space_marker 2, 0}\n  -----
2 #{get_space_marker 0, 1}|#{get_space_marker 1, 1}|#{get_space_marker 2, 1}\n  -----
3 #{get_space_marker 0, 2}|#{get_space_marker 1, 2}|#{get_space_marker 2, 2}"
  end

  private

  def get_space_marker(x, y)
    if board[x][y] == 1
      'x'
    elsif board[x][y] == 2
      'o'
    else
      ' '
    end
  end

  def user_given_pos_in_threshold?(pos)
    if pos =~ /[A-Za-z]/ && pos.upcase <= 'C'
      true
    elsif pos =~ /[1-9]/ && pos.to_i >= 1 && pos.to_i <= 3
      true
    else
      false
    end
  end

  def letter_to_number(letter)
    conversions = {
      'A' => 0,
      'B' => 1,
      'C' => 2
    }

    conversions[letter]
  end
end
