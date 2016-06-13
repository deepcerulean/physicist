module Physicist
  module Laboratory
    class ScientistCreatedEventListener < Metacosm::EventListener
      def receive(scientist_id:, name:, title:, position:, velocity:)
        ScientistView.create(
          scientist_id: scientist_id,
          display_name: "#{name} the #{title}",
          position: position,
          velocity: velocity
        )
      end
    end
  end
end
