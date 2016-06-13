require_relative 'screen'
require_relative 'view'

require_relative 'commands/create_scientist'
require_relative 'commands/move_scientist'

require_relative 'handlers/create_scientist_handler'
require_relative 'handlers/move_scientist_handler'

require_relative 'events/scientist_created_event'
require_relative 'events/scientist_updated_event'

require_relative 'listeners/scientist_created_event_listener'
require_relative 'listeners/scientist_updated_event_listener'

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

      def tick
        @ticks ||= 0
        @ticks += 1
        if (@ticks % 20 == 0)
          # fire(ping) #

          # poll for movement keys...
          if window.button_down?(Gosu::KbLeft)
            fire(move_scientist(:left))
          elsif window.button_down?(Gosu::KbRight)
            fire(move_scientist(:right))
          end

          # TODO
          # if window.button_down?(Gosu::KbUp)
          #   fire(jump)
          # end
        end
      end

      def press(key)
        if key == Gosu::KbLeft
          fire(move_scientist(:left))
        elsif key == Gosu::KbRight
          fire(move_scientist(:right))
        end

        # if key == Gosu::KbUp
        #   fire(jump)
        # end
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

      def move_scientist(direction)
        MoveScientist.create(scientist_id: scientist_id, direction: direction)
      end

      def scientist_id
        @scientist_id ||= SecureRandom.uuid
      end
    end
  end
end
