Rails.application.routes.draw do
  
  devise_for :users
  root 'pages#home'

  get '/about' => 'pages#about', as: :about
  get '/contact' => 'pages#contact', as: :contact
  get '/list_of_labs' => 'pages#list_of_labs', as: :list_of_labs  
  get '/list_of_doctors' => 'pages#list_of_doctors', as: :list_of_doctors

  get '/admin' => 'admin#index', as: :admin_index
  get '/admin/create_user' => 'admin#create_user', as: :create_user
  post '/admin/create_user' => 'admin#create_user_post'
  get '/admin/manage_users' => 'admin#manage_users', as: :manage_users

  get '/patients' => 'patients#index', as: :patients
  post '/patients' => 'patients#create'
  get '/patients/new' => 'patients#new', as: :new_patient
  get '/patients/:name/edit' => 'patients#edit', as: :edit_patient
  get '/patients/:name' => 'patients#show', as: :patient
  patch '/patients/:name' => 'patients#update'
  delete '/patients/:name' => 'patients#destroy'
  get '/patients/:name/reports/:id' => 'patients#see_report', as: :see_report
  post '/patients/:name/reports/:id' => 'patients#see_report_post'
  get '/patients/:name/book_appointment' => 'patients#book_appointment', as: :book_appointment
  post '/patients/:name/book_appointment' => 'patients#save_appointment'
  get '/patients/:name/check_appointments' => 'patients#check_appointments', as: :check_patient_appointments

  get '/lab' => 'labs#index', as: :labs
  get '/lab/add_report' => 'labs#add_report', as: :add_report
  post '/lab/add_report' => 'labs#save_report'
  get '/lab/patient_information' => 'labs#patient_info', as: :patient_info
  get '/lab/appointments' => 'labs#check_appointments', as: :check_lab_appointments
  get '/lab/patient_information/:name' => 'labs#show_patient', as: :show_patient

  get '/doctors' => 'doctor#index', as: :doctors
  get '/doctors/edit' => 'doctor#edit', as: :edit_profile
  patch '/doctors/edit' => 'doctor#update'
  get '/doctors/profile' => 'doctor#show', as: :show_profile
  get '/doctors/patient_information' => 'doctor#patient_info', as: :patient_d_info
  get '/doctors/patient_information/:name' => 'doctor#show_patient', as: :show_d_patient
  get '/doctors/check_opinion_requests' => 'doctor#check_opinion_requests', as: :check_opinion_requests
  get '/doctors/patient_information/:name/:id' => 'doctor#give_treatment',as: :give_treatment
  post '/doctors/patient_information/:name/:id' => 'doctor#give_treatment_post'
  get '/doctors/patient_information/:name/:id/give_opinion' => 'doctor#give_opinion',as: :give_opinion
  post '/doctors/patient_information/:name/:id/give_opinion' => 'doctor#give_opinion_post'

  get '*path' => redirect('/')

end
