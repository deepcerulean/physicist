module Physicist
  module Laboratory
    class WorkspaceView < Metacosm::View
      # has_many :scientist_views
      attr_accessor :space_id, :grid_map

      def obstacles
        SimpleBody.collection_from_tiles(grid_map)
      end
    end

    class NullWorkspaceView
      def grid_map
        [[1,2],[3,4]]
      end
    end
  end
end
