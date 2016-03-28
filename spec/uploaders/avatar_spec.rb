require 'carrierwave/test/matchers'

describe CardAvatarUploader do
  include CarrierWave::Test::Matchers
  let!(:card) { FactoryGirl.create(:card) }
  let(:image_test) { "app/assets/images/test.jpg" }

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
