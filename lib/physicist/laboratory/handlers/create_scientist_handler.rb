module Physicist
  module Laboratory
    class CreateScientistHandler
      def handle(scientist_id:, name:, title:, position:, velocity:)
        map_data = (
          [
            [ 1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 ],
            [ nil, nil, nil, nil, nil, 1,   1,   nil, nil, nil, nil, 2,   1 ],
            [ nil, nil, nil, nil, nil, 1,   1,   nil, nil, nil, nil, nil, 1 ],
            [ nil, nil, nil, nil, nil, 1,   1,   nil, nil, nil, nil, nil, 1 ],
            [ nil, nil, nil, nil, nil, 1,   1,   nil, nil, nil, nil, nil, 1 ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1 ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 3,   1 ],
            [ 1,   1,   nil, nil, 1,   1,   1,   1,   nil, nil, nil, 2,   1 ],
            [ 1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1]
          ]
        )

        space = Space.create(grid_map: map_data)

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
