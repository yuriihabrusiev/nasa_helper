# NASA Helper

Simple app to calculate fuel required for spaceship to launch/land on Earth, Moon or Mars.

To use, simply import the module `nasa_helper`, provide spacecraft weight and route, and call the `calculate_fuel` function.

```ruby
require "nasa_helper"

helper = NasaHelper.new(
  equipment_weight: 28_801,
  route: [[:launch, "earth"], [:land, "moon"], [:launch, "moon"], [:land, "earth"]]
)
helper.calculate_fuel # => 13_447
```
