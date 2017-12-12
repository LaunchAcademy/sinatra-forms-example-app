require 'sinatra'
require 'pry'
require 'csv'
require_relative "models/task"

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  redirect "/tasks"
end

get "/tasks" do
  @tasks = CSV.readlines('tasks.csv')
  erb :index
end

post '/tasks/new' do
  task_name = params['task_name']
  priority = params['priority']

  CSV.open('tasks.csv', 'a') do |csv|
    csv << [task_name, priority]
  end

  redirect '/tasks'
end

get '/tasks/new' do
  erb :new
end
