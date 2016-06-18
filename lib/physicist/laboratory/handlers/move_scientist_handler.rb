module Physicist
  module Laboratory
    class MoveScientistHandler
      def handle(scientist_id:, direction:)
        scientist = Scientist.find(scientist_id)
        scientist.move(direction: direction) if scientist # ???
      end
    end
  end
end
