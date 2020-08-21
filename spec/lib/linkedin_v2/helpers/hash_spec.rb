require "spec_helper"

describe LinkedinV2::Helpers::Hash do
  subject(:helper) { described_class }

  describe ".get_deep" do
    context "when given path exists" do
      it "returns value" do
        deep_hash = { foo: { bar: "hello" } }

        result = helper.get_deep(deep_hash, :foo, :bar)

        expect(result).to eq("hello")
      end
    end

    context "when given path does not exists" do
      it "returns nil" do
        deep_hash = { foo: { bar: "hello" } }

        result = helper.get_deep(deep_hash, :foo, :bla)

        expect(result).to eq(nil)
      end
    end
  end

  describe ".deep_merge" do
    context "when values from same key are Hash object" do
      it "returns hash merged on first level" do
        first_hash = { foo: "foo" }
        second_hash = { bar: "bar" }
        expected_response = { foo: "foo", bar: "bar" }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end

      it "returns nested merged hash" do
        first_hash = { foo: { a: 1 } }
        second_hash = { foo: { b: 2 } }
        expected_response = { foo: { a: 1, b: 2 } }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when values from same key are Array object" do
      it "returns the union from both values" do
        first_hash = { foo: [ 1, 2 ] }
        second_hash = { foo: [ 2, 3 ] }
        expected_response = { foo: [ 1, 2, 3 ] }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when second hash value is :undefined" do
      it "returns first hash" do
        first_hash = { foo: "foo" }
        second_hash = { foo: :undefined }
        expected_response = { foo: "foo" }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when second hash value is nil" do
      it "returns first hash" do
        first_hash = { foo: "foo" }
        second_hash = { foo: nil }
        expected_response = { foo: "foo" }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when second hash value is :nil" do
      it "returns first hash" do
        first_hash = { foo: "foo" }
        second_hash = { foo: :nil }
        expected_response = { foo: "foo" }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when both values does not have same type" do
      it "returns second hash" do
        first_hash = { foo: "foo" }
        second_hash = { foo: [ 1 ] }
        expected_response = { foo: [ 1 ] }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end

    context "when keys are not equal" do
      it "returns both keys and values" do
        first_hash = { foo: "foo" }
        second_hash = { bar: [ 1 ] }
        expected_response = { foo: "foo", bar: [ 1 ] }

        result = helper.deep_merge(first_hash, second_hash)

        expect(result).to be_a(Hash)
        expect(result).to eq(expected_response)
      end
    end
  end
end
