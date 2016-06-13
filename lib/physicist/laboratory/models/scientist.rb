module Physicist
  module Laboratory
    # user avatars are 'scientists'
    class Scientist < Metacosm::Model
      # belongs_to :space
      attr_accessor :name, :title
      attr_accessor :position, :velocity
      attr_accessor :updated_at

      def name_with_title
        "#{title} #{name}"
      end

      def ground_speed
        10
      end

      def move(direction:)
        p [ :move, dir: direction, current: current ]
        vx,vy = *current.velocity
        speed = ground_speed
        dvx = direction == :left ? -speed : speed


        # TODO more specific event?
        update(
          position: current.position,
          velocity: [vx + dvx, vy],
          updated_at: Time.now
        )
      end

      def current
        body.at(Time.now)
      end

      def body
        # ...integrate physicist bodies...
        Physicist::Body.new(
          position: position,
          velocity: velocity,
          t0: updated_at || Time.now,
          dimensions: [1,1]
        )
      end
    end
  end
end
