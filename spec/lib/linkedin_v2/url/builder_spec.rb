require "spec_helper"

describe LinkedinV2::Url::Builder do
  subject(:builder) { described_class }

  describe ".call" do
    context "when url exists" do
      describe "#shares" do
        it "succeeds" do
          expected_response = "/shares"

          result = builder.(:shares)

          expect(result).to eq(expected_response)
        end
      end

      describe "#ugc_post" do
        it "succeeds" do
          expected_response = "/ugcPosts"

          result = builder.(:ugc_post)

          expect(result).to eq(expected_response)
        end
      end

      describe "#organizations" do
        context "when projection is given" do
          it "succeeds" do
            projection = "(foo)"
            mock_cgi_response = "mock"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, projection: projection)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection is not given" do
          it "succeeds" do
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection="

            result = builder.(:organizations)

            expect(result).to eq(expected_response)
          end
        end
      end

      describe "#company" do
        context "when projection is given" do
          it "succeeds" do
            projection = "(foo)"
            identifier = 11111
            mock_cgi_response = "mock"
            expected_response = "/organizations/#{mock_cgi_response}?projection=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:company, identifier: identifier, projection: projection)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection is not given" do
          it "succeeds" do
            identifier = 11111
            mock_cgi_response = "mock"
            expected_response = "/organizations/#{mock_cgi_response}?projection="
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:company, identifier: identifier)

            expect(result).to eq(expected_response)
          end
        end
      end

      describe "#logo" do
        it "succeeds" do
          identifier = 11111
          mock_cgi_response = "mock"
          expected_response = "/organizations/#{mock_cgi_response}?projection=(coverPhotoV2(original~:playableStreams,cropped~:playableStreams,cropInfo),logoV2(original~:playableStreams,cropped~:playableStreams,cropInfo))"
          allow(CGI).to receive(:escape).and_return(mock_cgi_response)

          result = builder.(:logo, identifier: identifier)

          expect(result).to eq(expected_response)
        end
      end

      describe "#me" do
        context "when projection is given" do
          it "succeeds" do
            projection = "(foo)"
            mock_cgi_response = "mock"
            expected_response = "/me?projection=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:me, projection: projection)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection is not given" do
          it "succeeds" do
            expected_response = "/me?projection="

            result = builder.(:me)

            expect(result).to eq(expected_response)
          end
        end
      end

      describe "#upload_image" do
        it "succeeds" do
          expected_response = "/media/upload"

          result = builder.(:upload_image)

          expect(result).to eq(expected_response)
        end
      end
    end

    context "when url not found" do
      it "raises InvalidEndpointError exception" do
        expect {
          builder.(:url_not_found)
        }.to raise_error(LinkedinV2::InvalidEndpointError)
      end
    end
  end
end
