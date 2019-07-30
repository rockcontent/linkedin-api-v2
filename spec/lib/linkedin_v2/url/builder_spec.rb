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
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=#{mock_cgi_response}&start=&count="
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, projection: projection)

            expect(result).to eq(expected_response)
          end
        end

        context "when start is given" do
          it "succeeds" do
            start = "1"
            mock_cgi_response = "1"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=&start=#{mock_cgi_response}&count="
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, start: start)

            expect(result).to eq(expected_response)
          end
        end

        context "when count is given" do
          it "succeeds" do
            count = "10"
            mock_cgi_response = "10"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=&start=&count=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, count: count)

            expect(result).to eq(expected_response)
          end
        end

        context "when count and start are given" do
          it "succeeds" do
            start = "1"
            count = "1"
            mock_cgi_response = "1"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=&start=#{mock_cgi_response}&count=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, count: count, start: start)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection and start are given" do
          it "succeeds" do
            start = "1"
            projection = "(foo)"
            mock_cgi_response = "1"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=#{mock_cgi_response}&start=#{mock_cgi_response}&count="
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, projection: projection, start: start)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection and count are given" do
          it "succeeds" do
            count = "1"
            projection = "(foo)"
            mock_cgi_response = "1"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=#{mock_cgi_response}&start=&count=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(:organizations, projection: projection, count: count)

            expect(result).to eq(expected_response)
          end
        end

        context "when projection, start and count are given" do
          it "succeeds" do
            start = "1"
            count = "1"
            projection = "(foo)"
            mock_cgi_response = "1"
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=#{mock_cgi_response}&start=#{mock_cgi_response}&count=#{mock_cgi_response}"
            allow(CGI).to receive(:escape).and_return(mock_cgi_response)

            result = builder.(
              :organizations,
              projection: projection,
              count: count,
              start: start
            )

            expect(result).to eq(expected_response)
          end
        end

        context "when no parameter is given" do
          it "succeeds" do
            expected_response = "/organizationalEntityAcls?q=roleAssignee&projection=&start=&count="

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
