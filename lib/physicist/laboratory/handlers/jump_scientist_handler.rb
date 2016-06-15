module Physicist
  module Laboratory
    class JumpScientistHandler
      def handle(scientist_id:)
        scientist = Scientist.find(scientist_id)
        scientist.jump
      end
    end
  end
end
