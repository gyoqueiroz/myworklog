require 'thor'
require 'date'
require_relative 'work_log_controller'

DATE_FORMAT = 'DD/MM/YYYY'

class WorkLogCli < Thor
    desc 'add [DESCRIPTION]', "Adds a new work log with today's date as default. Use -d flag to specify a different date (e.g. myworklog add -d 10/10/2010 'I worked'). Date format #{DATE_FORMAT}"
    options :d => :string
    def add(description)
        begin
            date = options[:d] ? options[:d] : 'today'
            WorkLogController.new.add_work_log(date, description)
        rescue ArgumentError => msg
            puts msg
        end
    end

    desc 'list [DATE]', "prints work logs limited by DATE. Use 'today' or leave it empty for current day. Date format #{DATE_FORMAT}"

    def list(date='')
        print(WorkLogController.new.list(date))
    end

    desc 'list_all', "prints all the work logs"

    def list_all
        print(WorkLogController.new.list_all)
    end

    desc 'delete [ID]', 'Deletes the work log by ID. You can use the `list` command to retrieve the ID'

    def delete(id)
        begin
            WorkLogController.new.delete(id)
            puts "Work log with #{id} ID has been deleted!"
        rescue Exception => msg
            puts msg
        end
    end

    private

    def print(work_log_list)
        puts ''
        if work_log_list.empty?
            puts 'Work log(s) not found'
        elsif
            work_log_list.each do |work_log|
                puts "#{work_log.id} | #{work_log}"
            end
        end
        puts ''
    end
end