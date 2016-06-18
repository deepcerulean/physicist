module Physicist
  module Laboratory
    class CreateScientistHandler
      def handle(scientist_id:, name:, title:, position:, velocity:)
        p [ :creating_space ]

        map_data = (
          [
            [ 1, 1,   1,   1,   1,   1,   1,   1,   1,   1,   1 ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ],
            [ 1, nil, nil, nil, nil, 2, nil, nil, nil, nil, 1 ],
            [ 1, 1,   1,   1,   1,   1,   1,   1,   1,   1,   1 ]
          ]
        )

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
