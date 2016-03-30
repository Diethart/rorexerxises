require 'carrierwave/test/matchers'

describe CardAvatarUploader do
  include CarrierWave::Test::Matchers
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }
  let(:image_test) { "spec/test.jpg" }

  context 'the uploader' do
    it "should return true after saving" do

      File.open(image_test) do |f|
        card.avatar = f
      end
      card.remove_avatar = true
      expect(card.save!).to be true
    end
  end
end
