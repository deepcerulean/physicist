module Physicist
  module Laboratory
    # user avatars are 'scientists'
    class Scientist < Metacosm::Model
      belongs_to :space
      attr_accessor :name, :title
      attr_accessor :position, :velocity
      attr_accessor :updated_at

      def name_with_title
        "#{title} #{name}"
      end
    end

    class ScientistView < Metacosm::View
      attr_accessor :display_name, :position, :velocity, :t0

      def apparent_position(t)
        body.at(t).position
      end

      def body
        # ... integrate physicist bodies ...
      end

      # def player_sprite
      #   # p [ :player_position, position ]
      #   Dedalus::Elements::Sprite.new(
      #     path: path,
      #     frame: frame,
      #     invert_x: invert_x,
      #     overlay_color: player_color,
      #     asset_width: 64,
      #     asset_height: 64,
      #     scale: 2.0
      #   )
      # end

      # def path
      #   "media/images/walk.png"
      # end

      # def invert_x
      #   vx,_ = *velocity
      #   vx > 0
      # end

      # def frame
      #   if velocity == [0,0]
      #     0
      #   else
      #     1 + (Gosu::milliseconds / 150 % 4)
      #   end
      # end
    end
  end
end
