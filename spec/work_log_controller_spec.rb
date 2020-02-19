require 'work_log_controller'
require 'work_log_file_dao'

describe WorkLogController do
    subject { described_class.new }

    let(:dao_double) { double(WorkLogFileDao) }
    let(:securerandom_double) { class_double(SecureRandom) }

    before do
        allow(SecureRandom).to receive(:uuid).and_return('id')
        allow(WorkLogFileDao).to receive(:new).and_return(dao_double)
    end

    context 'given add_work_log is called' do
        context "with valid params and 'today' string value as date" do
            it 'work log object is created with ID generated, date as current date and correct description' do
                verify_work_log_attributes('id', Date.today, 'description')
                subject.add_work_log('today', 'description')
            end
        end

        context "with valid params and empty string as date" do
            it 'work log object is created with ID generated, date as current date and correct description' do
                verify_work_log_attributes('id', Date.today, 'description')
                subject.add_work_log('', 'description')
            end
        end

        context "with valid params and date in DD/MM/YYYY format" do
            it 'work log object is created with ID generated, correct date and correct description' do
                verify_work_log_attributes('id', Date::strptime('20/01/2010', "%d/%m/%Y"), 'description')
                subject.add_work_log('20/01/2010', 'description')
            end
        end

        def verify_work_log_attributes(id, date, description)
            expect(dao_double).to receive(:save) do |work_log_provided|
                expect(work_log_provided.id).to eq(id)
                expect(work_log_provided.date).to eq(date)
                expect(work_log_provided.description).to eq(description)
            end
        end
    end

end