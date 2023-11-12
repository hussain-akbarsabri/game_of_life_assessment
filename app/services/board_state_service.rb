# frozen_string_literal: true

# BoardStateService
class BoardStateService
  def initialize(grid)
    @grid = grid
    @rows = @grid[0].length
    @cols = @grid.length
  end

  def calculate_next_state
    next_grid = Array.new(@cols) { Array.new(@rows) }

    (0..@cols - 1).each do |i|
      (0..@rows - 1).each do |j|
        neighbors = count_neighbors(@grid, i, j)
        state = @grid[i][j]

        next_grid[i][j] = next_state(state, neighbors)
      end
    end
    next_grid
  end

  private

  def count_neighbors(grid, col_x, row_y)
    sum = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        col = (col_x + i + @cols) % @cols
        row = (row_y + j + @rows) % @rows

        sum += grid[col][row]
      end
    end
    sum - grid[col_x][row_y]
  end

  def next_state(state, neighbors)
    if state.zero? && neighbors == 3
      1
    elsif state == 1 && (neighbors < 2 || neighbors > 3)
      0
    else
      state
    end
  end
end
