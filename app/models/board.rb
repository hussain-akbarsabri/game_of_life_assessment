# frozen_string_literal: true

# Board
class Board < ApplicationRecord
  validates :grid, presence: true
  validate :grid_is_two_dimentional
  validate :equal_sized_grid
  validate :grid_contains_only_zeros_and_ones

  private

  def grid_is_two_dimentional
    return if grid.is_a?(Array) && grid.all? { |row| row.is_a?(Array) }

    errors.add(:grid, 'is not two dimentional')
  end

  def equal_sized_grid
    return unless grid.present? && grid.all? { |row| row.is_a?(Array) }

    no_of_rows = grid.length
    return if no_of_rows.zero?

    grid.each do |row|
      unless row.length == no_of_rows
        errors.add(:grid, 'columns in each row must be equal')
        break
      end
    end
  end

  def grid_contains_only_zeros_and_ones
    return unless grid.present? && grid.all? { |row| row.is_a?(Array) }

    return unless grid.flatten.any? { |value| ![0, 1].include?(value) }

    errors.add(:grid, 'can only store 0 or 1')
  end
end
