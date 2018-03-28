class User < ApplicationRecord

  def update_registered_status
    a = Mechanize.new

    a.get('https://www.sos.state.co.us/voter/pages/pub/olvr/findVoterReg.xhtml') do |page|
      form = page.form_with(name: 'findVoterRegForm')

      first_name_field = form.field_with(name: 'findVoterRegForm:voterSearchFirstId')
      first_name_field.value = self.first_name

      last_name_field = form.field_with(name: 'findVoterRegForm:voterSearchLastId')
      last_name_field.value = self.last_name

      zip_code_field = form.field_with(name: 'findVoterRegForm:voterSearchZipId')
      zip_code_field.value = self.zip_code.to_s

      birthday_field = form.field_with(name: 'findVoterRegForm:voterDOB')
      birthday_field.value = self.birthday.strftime('%_m/%d/%Y')

      submit_button = form.button_with(value: 'Search')
      results_page = form.submit(submit_button)

      registered = false

      if results_page.uri.to_s == 'https://www.sos.state.co.us/voter/pages/pub/olvr/regVoterDetail.xhtml'
        registered = true
      elsif results_page.uri.to_s == 'https://www.sos.state.co.us/voter/pages/pub/olvr/findVoterReg.xhtml'
        error_span_text = results_page.at('.error').text

        if error_span_text == 'If you have questions about your registration information or need further assistance, contact your County Clerk and Recorder.'
          registered = true
        else
          registered = false
        end
      end

      puts "#{self.first_name} #{self.last_name} #{self.email} #{ registered ? 'IS SUCCESSFULLY REGISTERED.' : 'IS NOT REGISTERED'}"
      self.registered_to_vote = registered
      self.save
    end
  end
end
