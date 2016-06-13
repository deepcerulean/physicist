module Physicist
  module Laboratory
    class ScientistUpdatedEventListener < Metacosm::EventListener
      def receive(scientist_id:, position:, velocity:, updated_at:)
        p [ :scientist_updated, pos: position, vel: velocity ]
        scientist_view = ScientistView.find_by(scientist_id: scientist_id)
        scientist_view.update(
          position: position,
          velocity: velocity,
          t0: updated_at
        )
      end
    end
  end
end
