module Physicist
  module Laboratory
    # user avatars are 'scientists'
    class Scientist < Metacosm::Model
      belongs_to :space

      # attr_accessor :space_id #??
      attr_accessor :name, :title
      attr_accessor :position, :velocity
      attr_accessor :updated_at

      def tick
        update(
          position: current.position, 
          velocity: current.velocity, 
          updated_at: Time.now
        )
      end

      def ground_speed
        5
      end

      def max_ground_speed
        10
      end

      def leg_strength # ??
        -12
      end

      def max_jump_velocity
        -30
      end

      def move(direction:)
        vx,vy = *current.velocity
        speed = ground_speed
        dvx = direction == :left ? -speed : speed
        vxt = vx + dvx
        return unless vxt.abs < max_ground_speed

        update(
          position: current.position,
          velocity: [vxt, vy],
          updated_at: Time.now
        )
      end

      def jump
        vx, vy = *current.velocity
        return if vy.abs > 0.0 

        dvy = leg_strength
        update(
          position: current.position,
          velocity: [vx, vy + dvy],
          updated_at: Time.now
        )
      end

      def current
        @body = body.at(Time.now, obstacles: space.obstacles)
      end

      def body
        construct_body
      end

      def construct_body
        # ...integrate physicist bodies...
        Physicist::Body.new(
          position: position,
          velocity: velocity,
          t0: updated_at || Time.now,
          dimensions: [2,2]
        )
      end
    end
  end
end
