require 'csv'

namespace :students do
  desc 'Import new students from'
  task :import, [:students_data_file] => [:environment] do |t, args|
    puts 'Importing students...'

    CSV.foreach(args[:students_data_file]) do |student|
      # Student array format:
      # [First, Last, Email, Birthday, Zip Code]
      # [0,    1,     2,     3,        4] (Indicies)

      first_name = student[0]
      last_name = student[1]
      email = student[2]
      birthday = Date.parse(student[3])
      zip_code = student[4].to_i

      puts "name: #{first_name} #{last_name}, email: #{email}, birthday: #{birthday}, zip code: #{zip_code}"

      user = User.new(first_name: first_name, last_name: last_name, email: email, birthday: birthday, zip_code: zip_code)

      duplicate = User.where(email: email).first

      if duplicate
        puts "DUPLICATE FOUND WITH STUDENT #{first_name} #{last_name} #{email}. SKIPPING."
        next
      end

      if user.save
        puts "#{first_name} #{last_name} #{email} SUCCESSFULLY SAVED."
      else
        puts "#{first_name} #{last_name} #{email} FAILED. DETAILS:"
        puts user.errors.inspect
      end

    end
  end
end