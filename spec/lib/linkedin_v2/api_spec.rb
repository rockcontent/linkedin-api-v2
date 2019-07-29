require "spec_helper"

describe LinkedinV2::Api do
  describe "constants" do
    describe ".ORGANIZATION_ENTITY" do
      it "equal to organization" do
        expect(LinkedinV2::Api::Organizations::ORGANIZATION_ENTITY).to eq("organization")
      end
    end

    describe ".PROFILE_ENTITY" do
      it "equal to person" do
        expect(LinkedinV2::Api::Profiles::PROFILE_ENTITY).to eq("person")
      end
    end
  end
end
