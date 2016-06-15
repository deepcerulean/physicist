module Physicist
  module Laboratory
    class SpaceCreatedEventListener < Metacosm::EventListener
      def receive(space_id:, grid_map:)
        WorkspaceView.create(space_id: space_id, grid_map: grid_map)
      end
    end
  end
end
