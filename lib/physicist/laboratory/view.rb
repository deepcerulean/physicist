module Physicist
  module Laboratory
    class View < Dedalus::ApplicationView
      def app_screen
        Screen.new(
          scientist: application.scientist_view,
          map_grid: application.workspace_view.grid_map
        )
      end
    end
  end
end