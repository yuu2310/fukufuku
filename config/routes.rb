Rails.application.routes.draw do

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー側のルーティング設定
    scope module: :public do
      root to: 'homes#top'
      get '/about' => 'homes#about'
      #退会確認画面
      get '/users/unsubscribe' => 'users#unsubscribe'
      #論理削除用のルーティング
      patch '/users/withdraw' => 'users#withdraw'
      resources :users, only: [:index, :edit, :update, :show] do
        member do
    # member doを使うとユーザーidが含まれるurlを使えるようになる
          get :favorites
        end
        resource :relationships, only: [:create, :destroy]
        get :followeds, on: :member
        #あるユーザーがフォローしている人全員を表示させるルーティング
        get :followers, on: :member
        #あるユーザーにフォローされている人全員を表示させるルーティング
      end
      resources :posts do
        resource :favorites, only: [:create, :destroy]
        resources :post_comments, only:[:create, :destroy]
      end
      resources :post_details
      get '/posts/hashtags/:name' => 'posts#hashtag'
      resources :hashtags, only: [:index, :show]
    end

  # 管理者側のルーティング設定
    namespace :admin do
      root to: 'homes#top'
      get '/about' => 'homes#about'
      resources :users, only:[:index, :show, :edit, :update, :destroy]
      resources :tags, only:[:index, :create]
      resources :categories, only:[:index, :create, :edit, :update, :destroy]
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
