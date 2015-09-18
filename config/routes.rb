Rails.application.routes.draw do
  # static_pagesコントローラのhomeアクション（homeビュー）をルートに指定
  root to: 'static_pages#home'
  # GETリクエスト /signup を usersコントローラのnewアクションに割り当て
  get 'signup', to: 'users#new'
  
  # RESTfulなURLを自動生成
  resources :users
end
