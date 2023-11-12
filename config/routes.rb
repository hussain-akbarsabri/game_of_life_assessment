# frozen_string_literal: true

Rails.application.routes.draw do
  resources :boards do
    member do
      get 'next_state'
      get 'final_state'
    end
  end
end
