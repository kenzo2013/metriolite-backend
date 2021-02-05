Rails.application.routes.draw do
  get 'forms/show'

  get '/inputs' => 'inputs#index'
  post '/inputs' => 'inputs#create'

  get '/forms/:id' => 'forms#show'
  put '/forms/:id' => 'forms#update'
  post '/forms' => 'forms#create'
  delete '/forms/:id' => 'forms#destroy'

end

