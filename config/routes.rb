Shutil::Engine.routes.draw do
  resources :job_status, :defaults => { :format => :json }, only: [:show]
end
