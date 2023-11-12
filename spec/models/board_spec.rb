# frozen_string_literal: true

# board_spec.rb
require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'is valid with a valid grid' do
    board = Board.new(grid: [[0, 1], [1, 0]])
    expect(board).to be_valid
  end

  it 'is not valid without a grid' do
    board = Board.new(grid: nil)
    expect(board).not_to be_valid
  end

  it 'is not valid with a non-2D grid' do
    board = Board.new(grid: [0, 1, 1])
    expect(board).not_to be_valid
  end

  it 'is not valid with unequal-sized rows' do
    board = Board.new(grid: [[0, 1], [1, 0, 1]])
    expect(board).not_to be_valid
  end

  it 'is not valid with values other than 0 or 1' do
    board = Board.new(grid: [[0, 1], [2, 1]])
    expect(board).not_to be_valid
  end
end
