require "spec_helper"

describe LinkedinV2::Helpers::Attribute do
  subject(:helper) { described_class }

  describe ".present?" do
    context "when value is nil" do
      it "returns false" do
        attr = nil

        result = helper.present?(attr)

        expect(result).to be(false)
      end
    end

    context "when value is a String object" do
      context "and is a empty String" do
        it "returns false" do
          attr = ""

          result = helper.present?(attr)

          expect(result).to be(false)
        end
      end

      context "and is a String with whitespace" do
        it "returns false" do
          attr = "    "

          result = helper.present?(attr)

          expect(result).to be(false)
        end
      end

      context "and is a String with non whitespace character" do
        context "and is a backslash notation " do
          context "and is a newline" do
            it "returns false" do
              attr = "\n"

              result = helper.present?(attr)

              expect(result).to be(false)
            end
          end

          context "and is a tab" do
            it "returns false" do
              attr = "\t"

              result = helper.present?(attr)

              expect(result).to be(false)
            end
          end

          context "and is a carriage return" do
            it "returns false" do
              attr = "\r"

              result = helper.present?(attr)

              expect(result).to be(false)
            end
          end

          context "and is a form feed" do
            it "returns false" do
              attr = "\f"

              result = helper.present?(attr)

              expect(result).to be(false)
            end
          end
        end

        context "and is not a backslash notation" do
          it "returns true" do
            attr = "foo"

            result = helper.present?(attr)

            expect(result).to be(true)
          end
        end
      end
    end
  end
end
