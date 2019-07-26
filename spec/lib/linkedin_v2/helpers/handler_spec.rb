require "spec_helper"
require "linkedin_v2/helpers/handler"

describe LinkedinV2::Helpers::Handler do
  describe ".request" do
    context "when subclass implements token method" do
      class DummyClass
        include LinkedinV2::Helpers::Handler

        def token
          "token"
        end
      end

      context "when api successfully responds" do
        it "calls RestClient::Resource#method" do
          method = :post
          response = { foo: "bar" }
          mocked_response = JSON.generate(response)
          dummy_class = DummyClass.new
          allow_any_instance_of(RestClient::Resource).to(
            receive(method).and_return(mocked_response)
          )
          expect_any_instance_of(RestClient::Resource).to(
            receive(method)
          )

          dummy_class.request(method, "/endpoint")
        end

        it "returns a hash as response" do
          method = :post
          mocked_response = JSON.generate({ foo: "bar" })
          dummy_class = DummyClass.new
          allow_any_instance_of(RestClient::Resource).to(
            receive(method).and_return(mocked_response)
          )

          result = dummy_class.request(method, "/endpoint")

          expect(result).to eq({ "foo" => "bar" })
        end
      end

      context "when api unsuccessfully responds" do
        it "raises LinkedinV2::LinkedinResponseError" do
          method = :post
          dummy_class = DummyClass.new
          allow_any_instance_of(RestClient::Resource).to(
            receive(method).and_raise(RestClient::ExceptionWithResponse)
          )

          expect {
            dummy_class.request(method, "/endpoint")
          }.to raise_error(LinkedinV2::LinkedinResponseError)
        end
      end
    end

    context "when subclass does not implement token method" do
      class FakeClass
        include LinkedinV2::Helpers::Handler
      end

      it "raises NameError exception" do
        method = :post
        response = { foo: "bar" }
        mocked_response = JSON.generate(response)
        fake_class = FakeClass.new
        allow_any_instance_of(RestClient::Resource).to(
          receive(method).and_return(mocked_response)
        )

        expect {
          fake_class.request(method, "/endpoint")
        }.to raise_error(NameError)
      end
    end
  end
end
