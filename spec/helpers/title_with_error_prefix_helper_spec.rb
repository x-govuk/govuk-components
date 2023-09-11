require 'spec_helper'

RSpec.describe(TitleWithErrorPrefixHelper, type: 'helper') do
  describe '#title_with_error_prefix' do
    context 'when there is an error' do
      subject { title_with_error_prefix('What is their name?', error: true) }

      it 'should include the Error: prefix' do
        expect(subject).to eql('Error: What is their name?')
      end
    end

    context 'when there is not an error' do
      subject { title_with_error_prefix('What is their name?', error: false) }

      it 'should not include a prefix' do
        expect(subject).to eql('What is their name?')
      end
    end

    context 'when error is not specified' do
      subject { title_with_error_prefix('What is their name?') }

      it 'should raise an argument error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when an alternative error prefix is given' do
      subject { title_with_error_prefix('What is their name?', error: true, error_prefix: "Opps: ") }

      it 'should include the alternative error prefix' do
        expect(subject).to eql('Opps: What is their name?')
      end
    end
  end
end
