Rails.application.routes.draw do

  # ユーザー用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}



  # ユーザー側のルーティング設定
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :users, only:[:edit, :update]
    get '/users/my_page' => 'users#show'
    get '/users/unsubscribe' => 'users#unsubscribe'
    patch '/users/withdraw' => 'users#withdraw'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only:[:create, :dest]
    end

  end


  # 管理者側のルーティング設定
  namespace :admin do
    root to: 'homes#top'
    # get '/about' => 'homes#about'
    resources :users, only:[:index, :edit, :update, :destroy]
    resources :tag, only:[:index, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
