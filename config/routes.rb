Rails.application.routes.draw do
  # static_pagesコントローラのhomeアクション（homeビュー）をルートに指定
  root to: 'static_pages#home'
  # GETリクエスト /signup を usersコントローラのnewアクションに割り当て
  get 'signup', to: 'users#new'
  # GETリクエスト /login を sessionsコントローラのnewアクションに割り当て
  get 'login' => 'sessions#new'
  # 
  post 'login' => 'sessions#create'
  # 
  delete 'logout' => 'sessions#destroy'
  
  # RESTfulなURLを自動生成
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
