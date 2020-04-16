class ApplicationController < Sinatra::Base
  configure do
    register Sinatra::ActiveRecordExtension
    set :views, proc { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    erb :index
  end
end