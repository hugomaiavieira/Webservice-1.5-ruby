require "cielo/ws15"

RSpec.describe Cielo::Holder do
  describe "#initialize" do
    context "sets the expiration value" do
      it "when expiration_month is a number less than 10" do
        subject = described_class.new(anything, 2018, 5)
        expect(subject.expiration).to eql("201805")
      end

      it "when expiration_month is a number greater than or equal to 10" do
        subject = described_class.new(anything, 2018, 10)
        expect(subject.expiration).to eql("201810")
      end

      it "when expiration_month is a string" do
        subject = described_class.new(anything, 2018, "05")
        expect(subject.expiration).to eql("201805")
      end
    end
  end
end