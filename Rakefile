ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.

desc 'Will load a console with the environment'
task :console do
  def reload!
    load_all 'app'
  end
  Pry.start
end
