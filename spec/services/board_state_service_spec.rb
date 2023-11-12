# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardStateService do
  describe '#calculate_next_state' do
    it 'returns a 2D array' do
      board = Board.create(grid: [[0, 1, 0], [0, 1, 0], [0, 1, 0]])
      next_grid = BoardStateService.new(board.grid).calculate_next_state
      expect(next_grid).to be_a(Array)
      next_grid.each do |row|
        expect(row).to be_a(Array)
      end
    end
  end
end
