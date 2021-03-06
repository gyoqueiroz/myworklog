# frozen_string_literal: true

require 'securerandom'
require 'Date'
require_relative 'work_log_file_dao'
require_relative 'work_log'

class WorkLogController
  def add_work_log(date, description)
    if description.nil? || description.empty?
      raise ArgumentError, 'Description must not be empty'
    end

    WorkLogFileDao.new.save(create_work_log(date, description))
  end

  def list(date)
    sort_by_date(WorkLogFileDao.new.list(parse_date(date)))
  end

  def list_all
    sort_by_date(WorkLogFileDao.new.list_all)
  end

  def delete(id)
    WorkLogFileDao.new.delete(id)
  end

  def find_by_month_and_year(month, year)
    sort_by_date(WorkLogFileDao.new.find_by_month_and_year(month, year))
  end

  def find_by_year(year)
    sort_by_date(WorkLogFileDao.new.find_by_year(year))
  end

  private

  def create_work_log(date, description)
    WorkLog.new(SecureRandom.uuid, parse_date(date), description)
  end

  def parse_date(date)
    if date.nil? || date.empty? || date.downcase == 'today'
      Date.today
    elsif date.downcase == 'yesterday'
      Date.today.prev_day
    else
      Date.strptime(date, '%d/%m/%Y')
    end
  end

  def sort_by_date(work_log_list)
    work_log_list.sort_by(&:date)
  end
end
