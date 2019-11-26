ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

def fi_check_migration
  begin
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    raise ActiveRecord::PendingMigrationError.new <<-EX_MSG
Migrations are pending. To resolve this issue, run:
      rake db:migrate SINATRA_ENV=test
EX_MSG
  end
end

# This will allow the Sinatra app to find my `.html.erb` same as `.erb`.
# That matters, because my editor will only help with autocomplete for 
# HTML if the file actually has `.html` in it :)
Tilt.register Tilt::ERBTemplate, 'html.erb'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app/models/concerns'
require_all 'app'
require_all 'lib'
