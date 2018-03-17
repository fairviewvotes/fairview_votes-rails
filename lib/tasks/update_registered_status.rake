require 'nokogiri'
require 'rubygems'
require 'mechanize'

namespace :students do
  desc 'Update students\' voter registration statuses'
  task :update_registered_status => [ :environment ] do |t|
    puts 'Updating students\' voter registration statuses...'

    User.all.each do |u|
      a = Mechanize.new

      a.get('https://www.sos.state.co.us/voter/pages/pub/olvr/findVoterReg.xhtml') do |page|
        form = page.form_with(name: 'findVoterRegForm')

        first_name_field = form.field_with(name: 'findVoterRegForm:voterSearchFirstId')
        first_name_field.value = u.first_name

        last_name_field = form.field_with(name: 'findVoterRegForm:voterSearchLastId')
        last_name_field.value = u.last_name

        zip_code_field = form.field_with(name: 'findVoterRegForm:voterSearchZipId')
        zip_code_field.value = u.zip_code.to_s

        birthday_field = form.field_with(name: 'findVoterRegForm:voterDOB')
        birthday_field.value = u.birthday.strftime('%_m/%d/%Y')

        submit_button = form.button_with(value: 'Search')
        results_page = form.submit(submit_button)

        if results_page.uri.to_s == 'https://www.sos.state.co.us/voter/pages/pub/olvr/regVoterDetail.xhtml'
          puts "#{u.first_name} #{u.last_name} #{u.email} IS SUCCESSFULLY REGISTERED."
          u.registered_to_vote = true
          u.save
        elsif results_page.uri.to_s == 'https://www.sos.state.co.us/voter/pages/pub/olvr/findVoterReg.xhtml'
          error_span_text = results_page.at('.error').text

          if error_span_text == 'If you have questions about your registration information or need further assistance, please contact your County Clerk and Recorder.'
            puts "#{u.first_name} #{u.last_name} #{u.email} IS SUCCESSFULLY REGISTERED."
            u.registered_to_vote = true
            u.save
          else
            puts "#{u.first_name} #{u.last_name} #{u.email} IS NOT REGISTERED."
          end
        end

        puts results_page.uri.to_s
      end
    end
  end
end