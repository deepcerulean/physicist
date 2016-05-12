require 'physicist/version'

module Physicist
  class SimpleBody
    attr_reader :position, :dimensions

    def initialize(position:,dimensions:)
      @position = position
      @dimensions = dimensions
    end
  end

  class Body
    attr_reader :position, :velocity, :t0, :dimensions

    def initialize(position:, velocity:, t0:, dimensions:)
      @position = position
      @velocity = velocity
      @dimensions = dimensions
      @t0 = t0
    end

    # def x; position[0] end
    # def y; position[1] end

    def width
      dimensions[0]
    end

    def height
      dimensions[1]
    end

    def at(t, obstacles:[])
      x0,y0   = *position
      vx0,vy0 = *velocity

      dt = t - t0

      vx = vx0 # - dry friction ?
      vy = vy0 + (gravity * dt)

      next_y_obstacle = next_obstacle_on_y_axis(vy,t,obstacles:obstacles)

      if next_y_obstacle
        distance_to_next_y_obstacle = 
          if vy > 0
            ((y0+height) - next_y_obstacle.position[1]).abs
          else
            (y0 - next_y_obstacle.position[1]).abs
          end
            # if vy > 0
            #   distance_to_next_y_obstacle -= height
            # end

        distance_travelled_in_y_axis_if_no_obstacles = (vy * dt)

        # require 'pry'
        # binding.pry

        if distance_travelled_in_y_axis_if_no_obstacles < distance_to_next_y_obstacle
          # the no-obstacles within relevant distance case
          # # TODO handle other coordinate (x)
          x = x0 + (vx * dt)
          y = y0 + (vy * dt)

        else
          # TODO handle other coordinate here too...
          x = x0 + (vx * dt)
          y = y0 + distance_to_next_y_obstacle # - height
          vy = 0
        end
      else
        x = x0 + (vx * dt)
        y = y0 + (vy * dt)
      end

      Body.new(
        position: [x,y],
        velocity: [vx,vy],
        dimensions: dimensions,
        t0: t
      )
    end

    def next_obstacle_on_y_axis(vy,t,obstacles:)
      x0,y0 = *position


      # does the line from y-infinity 
      obstacles_along_axis = obstacles.select do |obstacle|
        ox,_ = *obstacle.position
        ow,_ = *obstacle.dimensions
        ox <= x0 + width && x0 <= ox + ow
      end

      obstacles_in_direction_of_movement = if vy > 0
        obstacles_along_axis.select do |obstacle|
          _,oy = *obstacle.position
          # _,oh = *obstacle.dimensions

          oy >= y0 + height # && y0 < oy + oh
        end
      elsif vy < 0
        obstacles_along_axis.select do |obstacle|
          _,oy = *obstacle.position
          _,oh = *obstacle.dimensions

          oy + oh <= y0 # + height # && y0 > oy + oh
        end
      end


      obstacles_in_direction_of_movement.min_by do |obstacle|
        _,oy = *obstacle.position
        # distance to me
        (y0 - oy).abs
      end
    end

    def gravity
      9.8
    end
  end

  # class Environment
  #   def initialize(gravity:,friction:,t0:)
  #   end

  #   def add_body(body)
  #   end
  #
  #   def add_obstacle(obstacle)
  #   end

  #   def at(t)
  #   end
  # end
end
