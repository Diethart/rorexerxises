require 'rails_helper'

RSpec.describe SuperMemo, type: :service do
  let(:super_memo) { SuperMemo.new( { err_number: 2, internum: 2, efactor: 2.5 } ) }

  describe '#next_review_date' do
  let(:super_memo_failure) { SuperMemo.new( { err_number: 20, internum: 8, efactor: 1.4 } ) }

    it 'should be 6 days later' do
      expect(super_memo.next_review_date).to eq(Date.today + 6.day)
    end

    it 'should be next day' do
      expect(super_memo_failure.next_review_date).to eq(Date.today + 1.day)
    end
  end

  describe '#new_efactor' do

    it 'should be lesser than 2.5' do
      expect(super_memo.new_efactor).to be < 2.5
    end
  end

  describe '#new_memo_count' do

    it 'should be 3' do
      expect(super_memo.new_memo_count).to eq(3)
    end
  end
end
