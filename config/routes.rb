
Rails.application.routes.draw do
  root 'welcome#index'
  resources :timecards
  resources :time_entries

end
