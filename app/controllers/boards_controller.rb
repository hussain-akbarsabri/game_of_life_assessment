# frozen_string_literal: true

# BoardsController
class BoardsController < ApplicationController
  MAX_NO_OF_STATES = 9999

  before_action :set_board, only: %i[next_state final_state]

  def create
    board = Board.new(board_params)

    if board.save
      render json: board, status: :created
    else
      render json: { errors: board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def next_state
    if params[:no_of_states]
      if params[:no_of_states].to_i > MAX_NO_OF_STATES
        return render json: { errors: "No of states can be bigger than #{MAX_NO_OF_STATES}" }, status: :forbidden
      end

      update_multiple_states(params[:no_of_states].to_i - 1)
    else
      @board.update(grid: BoardStateService.new(@board.grid).calculate_next_state)
    end
    render json: @board, status: :ok
  end

  def final_state
    board_grid = @board.grid
    MAX_NO_OF_STATES.times do
      new_board_grid = BoardStateService.new(board_grid).calculate_next_state
      if new_board_grid == board_grid
        @board.update(grid: new_board_grid)
        return render json: { board: @board, message: 'concluded successfully' }, status: :ok
      end
    end

    render json: { errors: 'Tried max no of tries' }, status: :bad_request
  end

  private

  def board_params
    params.require(:board).permit(:grid).tap do |whitelisted|
      whitelisted[:grid] = JSON.parse(whitelisted[:grid])
    end
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def update_multiple_states(no_of_states)
    board_grid = @board.grid
    (0..no_of_states).each do |_x|
      board_grid = BoardStateService.new(board_grid).calculate_next_state
    end
    @board.update(grid: board_grid)
  end
end
