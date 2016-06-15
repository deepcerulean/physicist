module Physicist
  module Laboratory
    class CreateScientistHandler
      def handle(scientist_id:, name:, title:, position:, velocity:)
        p [ :creating_space ]
        # could also just create the space here....
        map_width, map_height = 14,14
        map_data = (
          Array.new(map_height - 1) {
            Array.new(map_width) { nil }
          } +
          [
            Array.new(map_width) { 0 }
          ]
        )

        # he needs a space to live in...
        space = Space.create(grid_map: map_data)

        p [ :creating_scientist, name: name ]
        space.create_scientist(
          id: scientist_id,
          name: name,
          title: title,
          position: position,
          velocity: velocity
        )
      end
    end
  end
end
