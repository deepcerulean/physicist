require_relative 'screen'
require_relative 'view'
require_relative 'models/scientist'
require_relative 'models/space'

module Physicist
  module Laboratory
    class App < Joyce::Application
      viewed_with Physicist::Laboratory::View

      attr_accessor :scientist

      def setup(*)
        p [ :lab_setup! ]
      end

      def scientist
        @scientist ||= Scientist.create(
          name: "Bill Nye",
          title: "Science Guy",
          position: [10,12],
          velocity: [0,0]
        )
      end

      def workspace
        map_width, map_height = 30,14
        @workspace = Space.create(
          scientists: [ scientist ],
          map:  # [[0,0,0,0]],
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
    end
  end
end
