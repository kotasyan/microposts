Rails.application.routes.draw do
  # static_pagesコントローラのhomeアクション（homeビュー）をルートに指定
  root to: 'static_pages#home'
end
