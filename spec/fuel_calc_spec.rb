require "rspec"

require_relative "../lib/nasa_helper"

describe NasaHelper::FuelCalc do
  subject { NasaHelper::FuelCalc }

  describe "#total_fuel" do
    it "return the total fuel needed for landing on Earth" do
      calc = subject.new(
        equipment_weight: 28_801,
        route: [[:land, 9.807]]
      )
      expect(calc.total_fuel).to eq(13_447)
    end

    it "return the total fuel needed for Earth - Moon - Earth route" do
      calc = subject.new(
        equipment_weight: 28_801,
        route: [
          [:launch, 9.807],
          [:land, 1.62],
          [:launch, 1.62],
          [:land, 9.807]
        ]
      )
      expect(calc.total_fuel).to eq(51_898)
    end

    it "return the total fuel needed for Earth - Mars - Earth route" do
      calc = subject.new(
        equipment_weight: 14_606,
        route: [
          [:launch, 9.807],
          [:land, 3.711],
          [:launch, 3.711],
          [:land, 9.807]
        ]
      )
      expect(calc.total_fuel).to eq(33_388)
    end

    it "return the total fuel needed for Earth - Moon - Mars - Earth route" do
      calc = subject.new(
        equipment_weight: 75_432,
        route: [
          [:launch, 9.807],
          [:land, 1.62],
          [:launch, 1.62],
          [:land, 3.711],
          [:launch, 3.711],
          [:land, 9.807]
        ]
      )
      expect(calc.total_fuel).to eq(212_161)
    end
  end
end
