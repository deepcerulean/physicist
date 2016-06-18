module Physicist
  class Body
    attr_reader :position, :velocity, :t0, :dimensions

    def initialize(position:, velocity:, t0:, dimensions:)
      @position = position
      @velocity = velocity
      @dimensions = dimensions
      @t0 = t0
    end

    def width
      dimensions[0]
    end

    def height
      dimensions[1]
    end

    def gravity
      50.0
    end

    def friction
      10.0
    end

    def at(t, obstacles:[])
      # p [ :body, at: t, pos: position, vel: velocity ]
      x0, _   = *position
      vx0,vy0 = *velocity

      x_speed  = vx0.abs
      sign_x = vx0 > 0.0 ? 1.0 : (vx0 < -0.0 ? -1.0 : 0.0)

      dt = t - t0

      vy = vy0 + (gravity * dt)

      fric = friction * dt
      x_halted = false

      vx = if (3*fric) < x_speed
             vx0 + (fric * -sign_x)
           else
             x_halted = true
             x_stopping_distance = (vx0 ** 2) / (3 * friction)
             0
           end

      xt,yt,vxt,vyt = deduce_y_coordinate(vy,t,obstacles:obstacles) do |y,_vyt|
        if x_halted
          [x0 + (x_stopping_distance * sign_x), y, vx, _vyt]
        else
          deduce_x_coordinate(y,vx,t,obstacles:obstacles) do |x,_vxt|
            [x, y, _vxt, _vyt]
          end
        end
      end

      vxt = 0 if -0.05 < vx && vx < 0.05
      vyt = 0 if -0.05 < vy && vy < 0.05

      Body.new(
        position: [xt,yt],
        velocity: [vxt,vyt],
        dimensions: dimensions,
        t0: t
      )
    end

    private
    def deduce_x_coordinate(y,vx,t,obstacles:,&blk)
      x0,_ = *position
      dt = t - t0

      next_x_obstacle = next_obstacle_on_x_axis(y,vx,t,obstacles:obstacles)
      if next_x_obstacle
        ox,_ = *next_x_obstacle.position
        ow,_ = *next_x_obstacle.dimensions

        distance_to_next_x_obstacle =
          if vx > 0
            ((x0+width) - ox).abs
          elsif vx < 0
            ((x0) - (ox+ow)).abs
          end

        distance_travelled_in_x_axis_if_no_obstacles = vx * dt
        p [ :next_x_obs, at: ox, distance: distance_to_next_x_obstacle, distance_without_obs: distance_travelled_in_x_axis_if_no_obstacles ]
        # require 'pry'
        # binding.pry

        if distance_travelled_in_x_axis_if_no_obstacles.abs < distance_to_next_x_obstacle
          p [ :travel_x_less_than_obs_x ]
          yield [x0 + (vx*dt), vx]
        else
          p [ :travel_x_more_than_obs_x ]
          if vx > 0
            yield [next_x_obstacle.position[0]-width, 0]
          else
            yield [next_x_obstacle.position[0]+next_x_obstacle.dimensions[0], 0]
          end
        end
      else
        yield [x0 + (vx*dt), vx]
      end
    end

    def deduce_y_coordinate(vy,t,obstacles:,&blk)
      _,y0   = *position
      dt = t - t0

      next_y_obstacle = next_obstacle_on_y_axis(vy,t,obstacles:obstacles)

      if next_y_obstacle
        distance_to_next_y_obstacle =
          if vy > 0
            ((y0+height) - next_y_obstacle.position[1]).abs
          else
            (y0 - (next_y_obstacle.position[1] + next_y_obstacle.dimensions[1])).abs
          end
        distance_travelled_in_y_axis_if_no_obstacles = (vy * dt)

        if distance_travelled_in_y_axis_if_no_obstacles.abs < distance_to_next_y_obstacle
          yield [y0 + (vy * dt), vy ]
        else
          if vy > 0
            p [ height: height ]
            yield [next_y_obstacle.position[1] - (height) - 0.001, 0]
          else 
            yield [next_y_obstacle.position[1] + next_y_obstacle.dimensions[1] + 0.1, 0]
          end
        end
      else
        yield [y0 + (vy * dt), vy]
      end
    end

    def next_obstacle_on_x_axis(y,vx,t,obstacles:)
      x0,_ = *position

      obstacles_along_axis = obstacles.select do |obstacle|
        _,oy = *obstacle.position
        _,oh = *obstacle.dimensions

        oy <= y + height && y <= oy + oh
      end

      obstacles_in_direction_of_movement =
        if vx > 0
          obstacles_along_axis.select do |obstacle|
            ox,_ = *obstacle.position
            # ow,oh = *obstacle.dimensions

            ox >= x0 + width
          end
        elsif vx < 0
          # require 'pry'
          # binding.pry
          obstacles_along_axis.select do |obstacle|
            ox,_ = *obstacle.position
            ow,_ = *obstacle.dimensions
            x0 >= ox + ow
            # ox + ow >= x0
          end
        else
          []
        end

      if obstacles_in_direction_of_movement.any?
        obstacles_in_direction_of_movement.min_by do |obstacle|
          ox,_ = *obstacle.position
          (x0 - ox).abs
        end
      else
        nil
      end
    end

    def next_obstacle_on_y_axis(vy,t,obstacles:)
      x0,y0 = *position

      # x0 += width/4
      w = width #/2

      obstacles_along_axis = obstacles.select do |obstacle|
        ox,_ = *obstacle.position
        ow,_ = *obstacle.dimensions
        ox <= x0 + w && x0 <= ox + ow
      end

      obstacles_in_direction_of_movement =
        if vy > 0
          obstacles_along_axis.select do |obstacle|
            _,oy = *obstacle.position

            oy >= y0 + height
          end
        elsif vy < 0
          obstacles_along_axis.select do |obstacle|
            _,oy = *obstacle.position
            _,oh = *obstacle.dimensions

            oy + oh <= y0
          end
        else
          []
        end

      if obstacles_in_direction_of_movement
        obstacles_in_direction_of_movement.min_by do |obstacle|
          _,oy = *obstacle.position

          # distance to me
          (y0 - oy).abs
        end
      else
        nil
      end
    end
  end
end
