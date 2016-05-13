require 'rails_helper'

RSpec.describe SuperMemo, type: :service do

  let(:super_memo)         { SuperMemo.get_data( { err_number: 2,  internum: 2, efactor: 2.5 } ) }
  let(:super_memo_failure) { SuperMemo.get_data( { err_number: 20, internum: 8, efactor: 1.3 } ) }

  describe '#next_review_date' do

  let(:super_memo_9internum)  { SuperMemo.get_data( { err_number: 2,  internum: 9, efactor: 2.5 } ) }

    it 'should be 6 days later' do
      expect(super_memo[:review_date]).to eq(Date.today + 6.day)
    end

    it 'should be next day' do
      expect(super_memo_failure[:review_date]).to eq(Date.today + 1.day)
    end

    it 'should be 20 days later' do
      expect(super_memo_9internum[:review_date]).to eq(Date.today + 20.day)
    end
  end

  describe '#new_efactor' do

  let(:super_memo_success) { SuperMemo.get_data( { err_number:0, internum:1, efactor:2.5 } ) }

    it 'should be lesser than 2.5' do
      expect(super_memo[:efactor]).to be < 2.5
    end

    it 'should be eq to 1.3' do
      expect(super_memo_failure[:efactor]).to eq(1.3)
    end

    it 'should be eq to 2.5' do
      expect(super_memo_success[:efactor]).to eq(2.5)
    end
  end

  describe '#new_memo_count' do

    it 'should be 3' do
      expect(super_memo[:memo_count]).to eq(3)
    end

    it 'should be 1' do
      expect(super_memo_failure[:memo_count]).to eq(1)
    end
  end

end
