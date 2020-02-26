# frozen_string_literal: true

require 'work_log_controller'

class ListStrategy
  attr_reader :date, :month, :year

  def initialize(date, month, year)
    @date = date
    @month = month
    @year = year
  end

  def execute
    return list_by_month_and_year if @month && @year
    return list_by_month_current_year if @month && @year.nil?
    return list_by_year if @month.nil? && @year

    list_by_date
  end

  private

  def list_by_date
    WorkLogController.new.list(@date)
  end

  def list_by_month_and_year
    WorkLogController.new.find_by_month_and_year(@month, @year)
  end

  def list_by_month_current_year
    WorkLogController.new.find_by_month_and_year(@month, Date.today.year)
  end

  def list_by_year
    WorkLogController.new.find_by_year(@year)
  end
end
