# frozen_string_literal: true

require 'securerandom'
require 'Date'
require_relative 'work_log_file_dao'
require_relative 'work_log'

class WorkLogController
  def add_work_log(date, description)
    WorkLogFileDao.new.save(create_work_log(date, description))
  end

  def list(date)
    WorkLogFileDao.new.list(parse_date(date))
  end

  def list_all
    WorkLogFileDao.new.list_all
  end

  def delete(id)
    WorkLogFileDao.new.delete(id)
  end

  def find_by_month_and_year(month, year)
    WorkLogFileDao.new.find_by_month_and_year(month, year)
  end

  def find_by_year(year)
    WorkLogFileDao.new.find_by_year(year)
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
end
