# frozen_string_literal: true
require_relative './player'
require_relative './gameboard'

class Game
  def initialize
    @players = []
    @current_player = 1
    @game_board = Gameboard.new
    @is_game_running = false

    @players.push(Player.new(Player.create_name(1)))
    @players.push(Player.new(Player.create_name(2)))
  end

  def start_new_game
    @is_game_running = true
    @game_board.clear
    puts '---Score:---'
    puts "#{@players[0].name}: #{@players[0].score}"
    puts "#{@players[1].name}: #{@players[1].score}"
    puts @game_board
  end

  def game_loop
    while @is_game_running
      puts "#{@players[@current_player - 1].name} select a spot: (ex A1)"
      selection = gets.chomp
      is_valid_selection = @game_board.input_valid?(selection) && @game_board.space_empty?(@game_board.convert_to_coord(selection))
      play_round selection if is_valid_selection
      finish_game if @game_board.game_won? @current_player
      @current_player = set_current_player if is_valid_selection
      puts 'Invalid choice, choose again.' unless is_valid_selection
    end
  end

  private

  def play_round(selection)
    coords = @game_board.convert_to_coord(selection)
    @game_board.mark_space coords[0], coords[1], @current_player
    puts @game_board
  end

  def set_current_player
    @current_player == 2 ? 1 : 2
  end

  def finish_game
    puts "#{@players[@current_player - 1].name} has won the game!"
    @players[@current_player - 1].score += 1
    start_new_game
  end
end
