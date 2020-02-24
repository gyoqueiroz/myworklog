# frozen_string_literal: true

require 'pstore'
require 'fileutils'

class WorkLogFileDao
  DB_FILE_NAME = 'myworklog.pstore'
  DB_FOLDER = '.myworklog'
  HOME_FOLDER = File.expand_path('~')
  FULL_DB_FILE_PATH = "#{HOME_FOLDER}/#{DB_FOLDER}/#{DB_FILE_NAME}"

  def initialize
    db_folder_full_path = "#{HOME_FOLDER}/#{DB_FOLDER}"
    unless File.directory?(db_folder_full_path)
      FileUtils.mkdir_p(db_folder_full_path)
    end
  end

  def save(work_log)
    PStore.new(FULL_DB_FILE_PATH).transaction { |store| store[work_log.id] = work_log }
  end

  def list(date)
    store = PStore.new(FULL_DB_FILE_PATH)
    list = []
    store.transaction(true) do
      store.roots
           .map { |root| list << store[root] if store[root].date == date }
    end
    list
  end

  def list_all
    store = PStore.new(FULL_DB_FILE_PATH)
    list = []
    store.transaction(true) { store.roots.map { |root| list << store[root] } }
    list
  end

  def delete(id)
    PStore.new(FULL_DB_FILE_PATH).transaction do |store|
      raise ArgumentError, "Id #{id} not found" if store[id].nil?

      store.delete(id)
    end
  end

  def find_by_month_and_year(month, year)
    store = PStore.new(FULL_DB_FILE_PATH)
    list = []
    store.transaction(true) do
      store.roots.map do |root|
        if store[root].date.month == month && store[root].date.year == year
          list << store[root]
        end
      end
    end
    list
  end

  def find_by_year(year)
    store = PStore.new(FULL_DB_FILE_PATH)
    list = []
    store.transaction(true) do
      store.roots
           .map do |root|
        list << store[root] if store[root].date.year == year
      end
    end
    list
  end
end
