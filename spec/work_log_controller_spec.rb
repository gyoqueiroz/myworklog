require 'work_log_controller'
require 'work_log_file_dao'
require 'Date'

describe WorkLogController do
    subject { described_class.new }

    let(:dao_double) { double(WorkLogFileDao) }
    let(:securerandom_double) { class_double(SecureRandom) }

    before do
        allow(SecureRandom).to receive(:uuid).and_return('id')
        allow(WorkLogFileDao).to receive(:new).and_return(dao_double)
    end

    context 'given #add_work_log is called' do
        context "with valid params and 'today' string value as date" do
            it 'work log object is created with ID generated, date as current date and correct description' do
                verify_work_log_attributes('id', Date.today, 'description')
                subject.add_work_log('today', 'description')
            end
        end

        context 'with valid params and empty string as date' do
            it 'work log object is created with ID generated, date as current date and correct description' do
                verify_work_log_attributes('id', Date.today, 'description')
                subject.add_work_log('', 'description')
            end
        end

        context 'with valid params and date in DD/MM/YYYY format' do
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

    context 'given #list is called' do
        let(:work_log_1) { WorkLog.new('1', Date.today, 'description') }
        let(:work_log_2) { WorkLog.new('2', Date.today.prev_day, 'description') }

        context 'when a valid date is passed' do
            let(:today_date_str_param) { Date.today.strftime('%d/%m/%Y') }
            let(:date_with_no_records) { '10/10/2019' }

            before do
                allow(dao_double).to receive(:list).with(Date.today).and_return([work_log_1])
                allow(dao_double).to receive(:list).with(Date.today.prev_day).and_return([work_log_2])
                allow(dao_double).to receive(:list).with(Date::strptime(date_with_no_records, "%d/%m/%Y")).and_return([])
            end
            
            it 'returns a list of work logs for the given date' do
                expect(subject.list(today_date_str_param)).to eq([work_log_1])
            end

            it "returns a list of work logs for date as 'today'" do
                expect(subject.list('today')).to eq([work_log_1])
            end

            it "returns a list of work logs for date as 'yesterday'" do
                expect(subject.list('yesterday')).to eq([work_log_2])
            end

            it 'returns an empty list when no work logs are found for the given date' do
                expect(subject.list(date_with_no_records)).to eq([])
            end
        end
    end

    context 'given #list_all is called' do
        context 'when there is data in the database' do
            let(:work_log_1) { WorkLog.new('1', Date.today, 'description') }
            let(:work_log_2) { WorkLog.new('2', Date.today.prev_day, 'description') }
            let(:all_records) { [work_log_1, work_log_2] }
            
            before do
                allow(dao_double).to receive(:list_all).and_return(all_records)
            end

            it 'returns all the records from the database' do
                expect(subject.list_all).to eq(all_records)
            end
        end

        context 'when the database is empty' do
            before do
                allow(dao_double).to receive(:list_all).and_return([])
            end

            it 'returns an empty list' do
                expect(subject.list_all).to eq([])
            end
        end
    end

    context 'given #delete is called' do
        context 'when an existing ID is provided' do
            it 'calls the #WorkLogFileDao.delete' do
                allow(dao_double).to receive(:delete).with('1')
                subject.delete('1')
            end
        end
    end
end