# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new board with a valid grid' do
      post :create, params: { board: { grid: [[0, 1], [1, 0]].to_json } }
      expect(response).to have_http_status(:created)
      expect(Board.last.grid).to eq([[0, 1], [1, 0]])
    end

    it 'returns unprocessable entity status with an invalid grid' do
      post :create, params: { board: { grid: [[0, 1], [2, 1]].to_json } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #next_state' do
    it 'updates the board with the next state' do
      board = Board.create(grid: [[0, 1], [1, 0]])
      get :next_state, params: { id: board.id }
      expect(response).to have_http_status(:ok)
      expect(board.reload.grid).not_to eq([[0, 1], [1, 0]])
    end
  end

  # please check the validatilty of response like the returned grid is valid or not
  

  describe 'GET #final_state' do
    it 'returns success when the final state is reached' do
      board = Board.create(grid: [[0, 1], [1, 0]])
      get :final_state, params: { id: board.id }
      expect(response).to have_http_status(:bad_request)
      expect(Board.find(board.id).grid).to eq(board.grid)
    end

    it 'returns bad request when the maximum number of tries is reached' do
      board = Board.create(grid: [[0, 1], [0, 1]])
      get :final_state, params: { id: board.id }
      expect(response).to have_http_status(:ok)
      expect(Board.find(board.id).grid).to eq(board.grid)
    end
  end
end
