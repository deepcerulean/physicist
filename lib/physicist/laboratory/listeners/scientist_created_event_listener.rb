module Physicist
  module Laboratory
    class ScientistCreatedEventListener < Metacosm::EventListener
      def receive(scientist_id:, space_id:, name:, title:, position:, velocity:)
        ScientistView.create(
          scientist_id: scientist_id,
          space_id: space_id,
          display_name: "#{name} the #{title}",
          position: position,
          velocity: velocity
        )
      end
    end
  end
end
