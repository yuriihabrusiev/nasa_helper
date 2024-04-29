require_relative "nasa_helper/fuel_calc"

class NasaHelper
  GRAVITIES = {
    earth: 9.807,
    moon: 1.62,
    mars: 3.711
  }.freeze

  def initialize(equipment_weight:, route:)
    @equipment_weight = equipment_weight
    @route = route
  end

  def calculate_fuel
    FuelCalc.new(
      equipment_weight: validated_weight,
      route: normalized_route
    ).total_fuel
  end

  private

  def validated_weight
    raise ArgumentError, "Equipment weight must be a positive number" unless @equipment_weight.positive?

    @equipment_weight
  end

  def normalized_route
    @normalized_route ||= @route.map do |directive, planet|
      planet = planet.downcase.to_sym
      raise ArgumentError, "Directive '#{directive}' is invalid" unless %i[launch land].include?(directive)
      raise ArgumentError, "Gravity is unknown for #{planet}" unless GRAVITIES.keys.include?(planet)

      [directive, GRAVITIES[planet]]
    end
  end
end
