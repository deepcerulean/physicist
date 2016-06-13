require_relative 'screen'
require_relative 'view'

require_relative 'commands/create_scientist'
require_relative 'handlers/create_scientist_handler'
require_relative 'events/scientist_created_event'
require_relative 'listeners/scientist_created_event_listener'

require_relative 'models/scientist'
require_relative 'models/space'
require_relative 'views/scientist_view'

module Physicist
  module Laboratory
    class App < Joyce::Application
      viewed_with Physicist::Laboratory::View

      attr_accessor :scientist

      def setup(*)
        p [ :lab_setup! ]
        fire(
          create_scientist(
            scientist_id: scientist_id,
            name: "Bill Bye",
            title: "Science Guy",
            position: [10,12],
            velocity: [0,0]
          )
        )

        # @scientist_view = 
        # ScientistView.create(scientist_id: scientist_id)
        sim.params[:active_scientist_id] ||= scientist_id
      end

      class NullScientistView
        def name
          'Nohbdy'
        end

        def position
          [0,0]
        end

        def velocity
          [0,0]
        end
      end

      def scientist_view
        ScientistView.where(scientist_id: scientist_id).first || NullScientistView.new
      end

      def workspace
        map_width, map_height = 30,14
        @workspace = Space.create(
          scientists: [ scientist_view ],
          map:
            (
              Array.new(map_height - 1) {
                Array.new(map_width) { nil }
              } +
              [
                Array.new(map_width) { 0 }
              ]
            )
        )
      end

      def create_scientist(*args)
        CreateScientist.create(*args)
      end

      def scientist_id
        @scientist_id ||= SecureRandom.uuid
      end
    end
  end
end
