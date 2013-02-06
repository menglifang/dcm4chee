Dcm4chee::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, constraints: Dcm4chee::ApiConstraints.new(version: 1, default: true) do
      resources :patients, only: [:index, :create]
      resources :studies, only: [:index, :create]
      resources :series, only: [:index, :create]
      resources :instances, only: [:index, :create]

      resources :modalities, only: :index
      resources :source_aets, only: :index

      resources :trashed_patients, only: [:index, :create, :destroy]
      resources :trashed_studies, only: [:index, :create, :destroy]
      resources :trashed_series, only: [:index, :create, :destroy]
      resources :trashed_instances, only: [:index, :create, :destroy]

      resources :file_systems, only: :index

      resource  :trash, only: :destroy

      resources :application_entities, only: [:index, :create, :update, :destroy]
      resources :dicom_objects, only: [:move] do
        post :move, on: :collection
      end
    end
  end
end
