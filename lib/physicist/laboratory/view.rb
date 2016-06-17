module Physicist
  module Laboratory
    class View < Dedalus::ApplicationView
      def app_screen
        Screen.new(
          scientist: scientist_view,
          map_grid: application.workspace_view.grid_map,
          camera: camera_location
        )
      end

      def scientist_view
        application.scientist_view
      end

      def tile_size
        64
      end

      def camera_location
        cx, cy = *scientist_view.current.position
        mx, my = (window.width / 2) / tile_size, (window.height / 2) / tile_size
        [ cx - mx, cy - my ]
      end
    end
  end
end
