DuneOnline::Application.routes.draw do
  match '/help' => 'help#help', :as => :help
  match '/help/landsraad' => 'help#landsraad', :as => :help_landsraad
  match '/help/suroviny' => 'help#suroviny', :as => :help_suroviny
  match '/help/planety_a_lena' => 'help#planety_a_lena', :as => :help_planety_a_lena
  match '/help/budovy' => 'help#budovy', :as => :help_budovy
  match '/help/arrakis' => 'help#arrakis', :as => :help_arrakis
  match '/help/transport' => 'help#transport', :as => :help_transport
  match '/help/presun' => 'help#presun', :as => :help_presun
  match '/help/trh' => 'help#trh', :as => :help_trh
  match '/help/vyzkum' => 'help#vyzkum', :as => :help_vyzkum
  match '/help/komunikace' => 'help#komunikace', :as => :help_komunikace
  match '/help/sprava' => 'help#sprava', :as => :help_sprava

  resources :productions
  match 'presun_vyrobku' => 'productions#presun_vyrobku', :as => :presun_vyrobku

  resources :products


	resources :markets
	match 'buy' => 'markets#buy', :as => :buy
	match 'my_offers' => 'markets#my_offers', :as => :my_offers
	match 'zlevnit' => 'markets#zlevnit', :as => :zlevnit
	match 'zdrazet' => 'markets#zdrazet', :as => :zdrazet

	resources :messages
	match 'reply' => 'messages#reply', :as => :reply
  match 'trash' => 'messages#trash', :as => :trash
	match 'odeslana_posta' => 'messages#odeslana_posta'

  resources :posts

  resources :topics

  resources :syselaads
  get 'syselaad/:kind' => 'syselaads#show', :as => :syselaad

  resources :laws

  resources :polls

  resources :operations

  resources :eods
  match 'zobraz_eod' => 'eods#zobraz_eod', :as => :zobraz_eod
  
  resources :technologies
  match 'vylepsi_technology' => 'technologies#vylepsi_technology', :as => :vylepsi_technology
	match 'narodni_vyskum' => 'technologies#narodni_vyskum', :as => :narodni_vyskum
  resources :systems

  resources :votes

  resources :planet_types

  resources :effects

  resources :buildings

  resources :fields
  match 'prejmenuj_pole' => 'fields#prejmenuj_pole', :as => :prejmenuj_pole
  match 'postavit_budovu' => 'fields#postavit_budovu', :as => :postavit_budovu
  match 'postavit_arrakis' => 'fields#postavit_arrakis', :as => :postavit_arrakis
  match 'presun_suroviny' => 'fields#presun_suroviny', :as => :presun_suroviny

  resources :properties

  resources :planets
  match 'list_osidlitelnych' => 'planets#list_osidlitelnych', :as => :list_osidlitelnych
  match 'osidlit_pole' => 'planets#osidlit_pole', :as => :osidlit_pole
  match 'zobraz_arrakis' => 'planets#zobraz_arrakis', :as => :zobraz_arrakis

  resources :subhouses
  match 'sprava_mr/(:id)' => 'subhouses#sprava_mr', :as => :sprava_mr
  match 'posli_mr_sur' => 'subhouses#posli_mr_sur', :as => :posli_mr_sur
  match 'vyhod_mr/:id' => 'subhouses#vyhod_mr', :as => :vyhod_mr
  match 'prijmi_hrace_mr' => 'subhouses#prijmi_hrace_mr', :as => :prijmi_hrace_mr
  match 'menuj_vice' => 'subhouses#menuj_vice', :as => :menuj_vice


  resources :houses
  match 'kolonizuj' => 'houses#kolonizuj', :as => :kolonizuj
  match 'sprava_rod' => 'houses#sprava_rod', :as => :sprava_rod
  match 'posli_rodove_suroviny' => 'houses#posli_rodove_suroviny', :as => :posli_rodove_suroviny
  match 'posli_mr_sur' => 'houses#posli_mr_sur', :as => :posli_mr_sur
  match 'prijmi_hrace' => 'houses#prijmi_hrace', :as => :prijmi_hrace
  match 'send_products_house' => 'houses#send_products_house', :as => :send_products_house
  match 'vyhosteni_hrace' => 'houses#vyhosteni_hrace', :as => :vyhosteni_hrace

  resources :discoverables
  
#  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions

  resources :users
  match 'zmen_prava' => 'users#zmen_prava', :as => :zmen_prava
  match 'hlasovat' => 'users#hlasovat', :as => :hlasovat
  match 'sprava' => 'users#sprava', :as => :sprava
	match 'opustit' => 'users#opustit', :as => :opustit
	match 'opustit_mr' => 'users#opustit_mr', :as => :opustit_mr
	match 'ziadost' => 'users#ziadost', :as => :ziadost
	match 'ziadost_malorod' => 'users#ziadost_malorod', :as => :ziadost_malorod
  match 'pridel_pravo' => 'users#pridel_pravo', :as => :pridel_pravo
  match 'odeber_pravo' => 'users#odeber_pravo', :as => :odeber_pravo
  match 'posli_suroviny' => 'users#posli_suroviny', :as => :posli_suroviny
	match 'udalosti' => 'users#udalosti', :as => :udalosti
	match 'oprava_katastrofy' => 'users#oprava_katastrofy', :as => :oprava_katastrofy
  match 'zmena_hesla_f' => 'users#zmena_hesla_f', :as => :zmena_hesla_f
  match 'zmena_hesla' => 'users#zmena_hesla', :as => :zmena_hesla
	match 'send_products' => 'users#send_products', :as => :send_products


	mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'

#  resources :admin
  match 'wipe' => 'admin#wipe', :as => :wipe
  match 'prepni_prihlasovani' => 'admin#prepni_povoleni_prihlasovani'
  match 'prepni_zakladani' => 'admin#prepni_povoleni_zakladani'
  match 'zamkni_hru' => 'admin#zamkni_hru', :as => :zamkni_hru
  match 'prepocti_vliv' => 'admin#prepocti_vliv', :as => :prepocti_vliv
  match 'kompletni_prepocet' => 'admin#kompletni_prepocet', :as => :kompletni_prepocet
  match 'pridej_suroviny' => 'admin#pridej_suroviny', :as => :pridej_suroviny
  match 'global_index' => 'admin#global_index', :as => :global_index
  match 'update_global/:id' => 'admin#update_global', :as => :global
  match 'sweep_session' => 'admin#sweep_session', :as => :sweep_session
	match 'udalosti_admin' => 'admin#udalosti_admin', :as => :udalosti_admin
	match 'update_udalost/:id' => 'admin#update_udalost', :as => :environment
	match 'leno_update_udalost/:id' => 'admin#leno_update_udalost', :as => :influence
  
  match 'show' => 'imperium#show', :as => :imperium
  match 'sprava_imperia' => 'imperium#sprava', :as => :sprava_imperia
  match 'posli_imperialni_suroviny' => 'imperium#posli_imperialni_suroviny', :as => :posli_imperialni_suroviny

  match 'landsraad_show' => 'landsraad#show', :as => :landsraad_show
  match 'landsraad_jednani' => 'landsraad#jednani', :as => :landsraad_jednani
  match 'volba_imperatora' => 'landsraad#volba_imperatora', :as => :volba_imperatora
	match 'imperator_zakony' => 'landsraad#imperator_zakony', :as => :imperator_zakony
	match 'podepisat_zakon' => 'landsraad#podepisat_zakon', :as => :podepisat_zakon

  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
