require 'work_log'
require 'Date'

describe WorkLog do
    
    describe '#initialize' do
        context 'given all the attributes are passed' do
            let(:work_log) { WorkLog.new('id', Date.today, 'description') }

            it 'reads all the attributes' do
                expect(work_log.id).to eq('id')
                expect(work_log.date).to eq(Date.today)
                expect(work_log.description).to eq('description')
            end

            it 'prints out date in the correct format and description, both as string representation' do
                expect("#{Date.today.strftime('%d/%m/%Y')} - description").to eq("#{work_log}")
            end
        end
    end
end