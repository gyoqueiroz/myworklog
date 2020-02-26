# frozen_string_literal: true

class Printer
  def print(work_log_list)
    puts ''
    if work_log_list.empty?
      puts 'Work log(s) not found'
    else
      work_log_list.each do |work_log|
        puts "#{work_log.id} | #{work_log}"
      end
    end
    puts ''
  end
end
