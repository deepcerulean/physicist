require 'ostruct'
module Physicist
  module Laboratory
    class ScientistView < Metacosm::View
      attr_accessor :scientist_id, :space_id
      attr_accessor :display_name, :position, :velocity, :t0

      after_update {
        @body = construct_body
      }

      def current # at(t)
        @body = body.at(Time.now, obstacles: workspace_view.obstacles)
      end

      def body
        # ... integrate physicist bodies ...
        @body ||= construct_body
      end
      
      def construct_body
        Physicist::Body.new(
          position: position,
          velocity: velocity,
          t0: t0 || Time.now,
          dimensions: [2,2]
        )
      end

      def workspace_view
        WorkspaceView.find_by(space_id: space_id)
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

      def current
        OpenStruct.new(position: position, velocity: velocity)
      end
    end
  end
end
