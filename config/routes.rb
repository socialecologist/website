Rails.application.routes.draw do
  # Homepage
  root to: 'archives#home'


  # Archives
  get 'archives', to: 'archives#index', as: :archives
  get 'archive',  to: redirect('/archives')


  # Articles
  # Article permalink
  get ':year/:month/:day/:slug',
      to:          'articles#show',
      constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ },
      as:          :article

  # Article listings by year, optional month, optional day
  get '(/:year)(/:month)(/:day)',
      to:          'articles#index',
      constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ },
      as:          :articles

  # Draft Article
  get 'drafts/:draft_code', to: 'articles#show', as: :draft

  # Articles Atom Feed
  get "feed", to: "articles#index", defaults: { format: "atom" }, as: :feed


  # Admin Dashboard
  get :admin, to: redirect('/admin/articles'), as: 'admin'
  namespace :admin do
    resources :users
    resources :articles
    resources :pages
    resources :links
    resources :settings
  end


  # Auth + User signup
  namespace :auth do
    resources :users,    only: [:create, :update, :destroy]
    resources :sessions, only: [:create]
  end

  get 'profile',  to: 'auth/users#show',       as: 'profile'
  get 'settings', to: 'auth/users#edit',       as: 'settings'
  get 'signup',   to: 'auth/users#new',        as: 'signup'
  get 'signin',   to: 'auth/sessions#new',     as: 'signin'
  get 'signout',  to: 'auth/sessions#destroy', as: 'signout'

  # Wordpress admin URL redirects
  get 'wp-admin.php', to: redirect('/admin')
  get 'wp-login.php', to: redirect('/signin')
  get 'wp-login.php?action=logout&_wpnonce=:nonce', to: redirect('/signout')


  # Pages
  get '*path', to: 'pages#show', as: :page, via: :all
end
