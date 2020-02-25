# frozen_string_literal: true

require 'work_log_cli'
require 'work_log_controller'

describe WorkLogCli do
  let(:controller_double) { double(WorkLogController) }

  before do
    allow(WorkLogController).to receive(:new).and_return(controller_double)
  end

  context 'when the #add command is called' do
    context 'with a valid description parameter' do
      it 'calls the controller assuming date parameter as today' do
        allow(controller_double).to receive(:add_work_log).with('today', 'description')

        expect { subject.add('description') }.not_to raise_error
      end
    end

    # context 'with an empty description parameter' do
    #   it 'prints out the validation error message' do
    #     allow(controller_double).to receive(:add_work_log).with('today', '')
    #                                                       .and_raise(ArgumentError.new('Error message'))

    #     expect { subject.add('') }.to raise_error
    #       .and output("Error message\n").to_stdout
    #   end
    # end
  end
end
