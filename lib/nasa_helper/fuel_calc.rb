class NasaHelper
  class FuelCalc
    LAUNCH_MODIFIERS = {
      multiplier: 0.042,
      substractor: 33
    }.freeze

    LANDING_MODIFIERS = {
      multiplier: 0.033,
      substractor: 42
    }.freeze

    def initialize(equipment_weight:, route:)
      @equipment_weight = equipment_weight
      @route = route
    end

    def total_fuel
      @route.reverse.reduce(0) do |required_fuel, (directive, gravity)|
        modifiers = directive == :launch ? LAUNCH_MODIFIERS : LANDING_MODIFIERS

        additional_fuel = fuel_for(
          @equipment_weight + required_fuel,
          gravity,
          **modifiers
        )

        required_fuel + additional_fuel
      end
    end

    private

    def fuel_for(weight, gravity, multiplier:, substractor:)
      extra_weight = (weight * gravity * multiplier - substractor).floor
      return 0 if extra_weight <= 0

      extra_weight + fuel_for(extra_weight, gravity, multiplier:, substractor:)
    end
  end
end
