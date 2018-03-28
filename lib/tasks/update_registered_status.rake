require 'nokogiri'
require 'rubygems'
require 'mechanize'

namespace :students do
  desc 'Update students\' voter registration statuses'
  task :update_registered_status => [ :environment ] do |t|
    puts 'Updating students\' voter registration statuses...'

    User.all.each do |u|
      u.update_registered_status
    end
  end
end