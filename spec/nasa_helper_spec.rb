require_relative "../lib/nasa_helper"

describe NasaHelper do
  subject { NasaHelper }
  describe "#calculate_fuel" do
    context "when equipment weight is not a positive number" do
      it "raise an ArgumentError" do
        expect { subject.new(equipment_weight: 0, route: []).calculate_fuel }
          .to raise_error(ArgumentError, "Equipment weight must be a positive number")
      end
    end

    context "when directive is invalid" do
      it "raise an ArgumentError" do
        expect { subject.new(equipment_weight: 1, route: [[:invalid, "earth"]]).calculate_fuel }
          .to raise_error(ArgumentError, "Directive 'invalid' is invalid")
      end
    end

    context "when gravity is unknown" do
      it "raise an ArgumentError" do
        expect { subject.new(equipment_weight: 1, route: [[:launch, "jupiter"]]).calculate_fuel }
          .to raise_error(ArgumentError, "Gravity is unknown for jupiter")
      end
    end
  end
end
