# frozen_string_literal: true

require 'thor'
require 'date'
require 'rubygems'
require 'work_log_controller'
require 'list_strategy'
require 'printer'

DATE_FORMAT = 'DD/MM/YYYY'

class WorkLogCli < Thor
  map %w[--version -v] => :__print_version

  desc 'add [DESCRIPTION]', "Adds a new work log with today's date as default. Use -d flag to specify a different date (e.g. myworklog add -d 10/10/2010 'I worked'). Date format #{DATE_FORMAT}"
  options d: :string
  def add(description)
    date = options[:d] || 'today'
    WorkLogController.new.add_work_log(date, description)
  rescue ArgumentError => e
    puts e
  end

  desc 'list', "Prints work logs for the current date. Date format #{DATE_FORMAT}"
  long_desc <<-LONGDESC
        Prints work logs for the current date if no option specified.

        Availble options:

          with [DATE], prints the work logged for the given date in DD/MM/YYYY

          With -m option, prints all the work logs for the specified month, assumes the current year

          With -m and -y options, prints all the work logs for the specified month and year

          With -y option, prints all the work logs for the specified year

          With --all option, prints all the work logs from the database

          Usage examples:

            `myworklog 10/10/2019`     Will print all the work logs for the given date

            `myworklog -m 2`           Will print all the work logs loggedi n Februrary of the current year

            `myworklog -m 2 -y 2019`   Will print all the work logs logged in Februrary of 2019

            `myworklog -y 2020`        Will print all the work logs logged in 2020

            `myworklog --all`

  LONGDESC
  options m: :numeric
  options y: :numeric
  options all: :string
  def list(date = '')
    return print(WorkLogController.new.list_all) if options[:all]

    print(ListStrategy.new(date, options[:m], options[:y]).execute)
  end

  desc 'delete [ID]', 'Deletes the work log by ID. You can use the `list` command to retrieve the ID'

  def delete(id)
    WorkLogController.new.delete(id)
    puts "Work log with #{id} ID has been deleted!"
  rescue ArgumentError => e
    puts e
  end

  desc '--version -v', 'Prints the current version'

  def __print_version
    spec = Gem::Specification.load('myworklog.gemspec')
    puts spec.version
  end

  private

  def list_by_year(year)
    print(WorkLogController.new.find_by_year(year))
  end

  def list_by_month(month)
    print(WorkLogController.new.find_by_month_and_year(month, Date.today.year))
  end

  def list_by_month_and_year(month, year)
    print(WorkLogController.new.find_by_month_and_year(month, year))
  end

  def print(work_log_list)
    Printer.new.print(work_log_list)
  end
end
