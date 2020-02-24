# frozen_string_literal: true

require 'pstore'
require 'work_log_file_dao'
require 'work_log'

describe WorkLogFileDao do
  subject { described_class.new }

  let(:pstore_double) { double(PStore) }
  let(:work_log_1) { WorkLog.new('1', Date.today.prev_day, 'description') }
  let(:work_log_2) { WorkLog.new('2', Date.today, 'description') }
  let(:ids) { %w[1 2] }

  before do
    expect(pstore_double).to receive(:transaction)
    allow(PStore).to receive(:new).with(WorkLogFileDao::FULL_DB_FILE_PATH)
                                  .and_return(pstore_double)

    allow(pstore_double).to receive(:roots)
      .and_return(ids)
    allow(pstore_double).to receive(:[]).with('1')
                                        .and_return(work_log_1)
    allow(pstore_double).to receive(:[]).with('2')
                                        .and_return(work_log_2)
  end

  context 'given #save is called with a valid work log' do
    let(:work_log) { WorkLog.new('id', Date.today, 'description') }

    before do
      allow(pstore_double).to receive(:[]=).with('id', work_log).and_return(nil)
      allow(pstore_double).to receive(:transaction).and_yield(pstore_double)
    end

    it 'persists the object in the database' do
      subject.save(work_log)
    end
  end

  context 'given #list is called' do
    before do
      allow(pstore_double).to receive(:transaction).with(true).and_yield
    end

    it 'returns work logs for the given date' do
      expect(subject.list(Date.today)).to eq([work_log_2])
    end

    it 'returns empty array when no work logs found for the given date' do
      expect(subject.list(Date.today.prev_day.prev_day)).to eq([])
    end
  end

  context 'given #list_all is called' do
    before do
      allow(pstore_double).to receive(:transaction).with(true).and_yield
    end

    context 'when there are records in the database' do
      it 'returns all the work logs from the database' do
        expect(subject.list_all).to eq([work_log_1, work_log_2])
      end
    end

    context 'when the database is empty' do
      before do
        allow(pstore_double).to receive(:roots).and_return([])
      end

      it 'returns an empty array' do
        expect(subject.list_all).to eq([])
      end
    end
  end

  context 'given #delete is called' do
    let(:work_log) { WorkLog.new('id', Date.today, 'description') }

    before do
      allow(pstore_double).to receive(:transaction).and_yield(pstore_double)
    end

    context 'when the ID exists' do
      it 'should call PStore.delete' do
        allow(pstore_double).to receive(:delete).with('id')
        allow(pstore_double).to receive(:[]).with('id').and_return(work_log)

        subject.delete('id')
      end
    end

    context 'when the ID does not exist' do
      it 'raises an exception' do
        allow(pstore_double).to receive(:[]).with('id').and_return(nil)

        expect { subject.delete('id') }.to raise_exception(Exception, 'Id id not found')
      end
    end
  end

  context 'given #find_by_month_and_year is called' do
    before do
      allow(pstore_double).to receive(:transaction).with(true).and_yield
    end

    context 'when there are records in the database matching the criteria' do
      it 'returns a list of records' do
        expect(subject.find_by_month_and_year(2, 2020)).to eq([work_log_1, work_log_2])
      end
    end

    context 'when there are no records matching the criteria' do
      it 'returns an empty list' do
        expect(subject.find_by_month_and_year(12, 1900)).to eq([])
      end
    end
  end

  context 'given #find_by_year is called' do
    before do
      allow(pstore_double).to receive(:transaction).with(true).and_yield
    end

    context 'when there are records in the database matching the criteria' do
      it 'returns a list of records' do
        expect(subject.find_by_year(2020)).to eq([work_log_1, work_log_2])
      end
    end

    context 'when there are no records matching the criteria' do
      it 'returns an empty list' do
        expect(subject.find_by_year(1900)).to eq([])
      end
    end
  end
end
