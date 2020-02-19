require 'pstore'
require 'fileutils'

DB_FILE_NAME = 'myworklog.pstore'
DB_FOLDER = '.myworklog'
HOME_FOLDER = File.expand_path('~')
FULL_DB_FILE_PATH = "#{HOME_FOLDER}/#{DB_FOLDER}/#{DB_FILE_NAME}"

class WorkLogFileDao
    def initialize
        db_folder_full_path = "#{HOME_FOLDER}/#{DB_FOLDER}"
        FileUtils.mkdir_p(db_folder_full_path) unless File.directory?(db_folder_full_path)
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
        store.transaction(true) do 
          store.roots
            .map { |root| list << store[root] }
        end
        list
    end

    def delete(id)
        PStore.new(FULL_DB_FILE_PATH).transaction { |store| store.delete(id) }
    end
end