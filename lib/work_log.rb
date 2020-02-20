class WorkLog
    attr_reader :id, :date, :description

    def initialize(id, date, description)
        @id = id
        @date = date
        @description = description
    end

    def to_s
        "#{@date.strftime('%d/%m/%Y')} - #{@description}"
    end
end