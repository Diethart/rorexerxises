require 'rails_helper'

describe AdminsPolicy do
  subject { described_class }

  context "users" do
    let(:user)  { FactoryGirl.create(:user)  }
    let(:admin) { FactoryGirl.create(:admin) }

    permissions :admin? do
      it { should_not permit user }
      it { should permit admin }
    end
  end
end
