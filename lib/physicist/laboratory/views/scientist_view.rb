module Physicist
  module Laboratory
    class ScientistView < Metacosm::View
      # belongs_to :workspace_view

      attr_accessor :scientist_id, :space_id
      attr_accessor :display_name, :position, :velocity, :t0

      def current # at(t)
        body.at(Time.now, obstacles: workspace_view.obstacles) #.position
      end

      def workspace_view
        WorkspaceView.find_by(space_id: space_id)
      end

      def body
        # ... integrate physicist bodies ...
        Physicist::Body.new(
          position: position,
          velocity: velocity,
          t0: t0 || Time.now,
          dimensions: [1,1]
        )
      end
    end

    class NullScientistView
      def display_name
        'Nohbdy'
      end

      def position
        [0,0]
      end

      def velocity
        [0,0]
      end

      def space_id
        nil
      end
    end
  end
end
