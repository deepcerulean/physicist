module Physicist
  module Laboratory
    class CreateScientistHandler
      def handle(scientist_id:, name:, title:, position:, velocity:)
        p [ :creating_scientist! ]
        Scientist.create(
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
