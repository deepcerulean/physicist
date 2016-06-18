require_relative 'screen'
require_relative 'view'

require_relative 'commands/create_scientist'
require_relative 'commands/move_scientist'
require_relative 'commands/jump_scientist'

require_relative 'handlers/create_scientist_handler'
require_relative 'handlers/move_scientist_handler'
require_relative 'handlers/jump_scientist_handler'

require_relative 'events/scientist_created_event'
require_relative 'events/scientist_updated_event'
require_relative 'events/space_created_event'

require_relative 'listeners/scientist_created_event_listener'
require_relative 'listeners/scientist_updated_event_listener'
require_relative 'listeners/space_created_event_listener'

require_relative 'models/scientist'
require_relative 'models/space'

require_relative 'views/scientist_view'
require_relative 'views/workspace_view'

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
            position: [0,2],
            velocity: [0,0]
          )
        )
      end

      def tick
        Scientist.all.each(&:tick)


        # poll for movement keys...
        if window.button_down?(Gosu::KbLeft)
          fire(move_scientist(:left))
        elsif window.button_down?(Gosu::KbRight)
          fire(move_scientist(:right))
        end

        # TODO
        p [ :check_jump ]
        if window.button_down?(Gosu::KbUp)
          p [ :jump! ]
          fire(jump)
        else
          p [ :no_jump! ]
        end
      end

      def press(key)
        if key == Gosu::KbLeft
          fire(move_scientist(:left))
        elsif key == Gosu::KbRight
          fire(move_scientist(:right))
        end

        if key == Gosu::KbUp
          fire(jump)
        end
      end

      def scientist_view
        ScientistView.where(scientist_id: scientist_id).first || NullScientistView.new
      end

      def workspace_view
        WorkspaceView.where(space_id: scientist_view.space_id).first || NullWorkspaceView.new
      end

      def create_scientist(*args)
        CreateScientist.create(*args)
      end

      def move_scientist(direction)
        MoveScientist.create(scientist_id: scientist_id, direction: direction)
      end

      def jump
        JumpScientist.create(scientist_id: scientist_id)
      end

      def scientist_id
        @scientist_id ||= SecureRandom.uuid
      end
    end
  end
end
