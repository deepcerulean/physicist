module Physicist
  module Laboratory
    class Screen < Dedalus::Screen
      include Dedalus::Elements
      attr_accessor :scientist, :map_grid

      def show
        [
          Paragraph.new(text: "Welcome to the lab, #{scientist.name}!"),
          field
        ]
      end

      def field
        SpriteField.new(
          grid: map_grid,
          scale: 0.5,
          # camera_location: [-1.2,-2.4],
          tiles_path: "media/images/tiles.png",
          tile_width: 64,
          tile_height: 64,
          tile_class: "Dedalus::Elements::MapTile",
          sprite_map: sprite_map 
        )
      end

      def sprite_map
        { scientist.position => [avatar_for(scientist)] }
      end

      def avatar_for(scientist)
        Dedalus::Elements::Sprite.new(
          path: 'media/images/walk.png',
          frame: 0,
          invert_x: false,
          asset_width: 64,
          asset_height: 64,
          scale: 0.5
        )
      end

      def heading
        [
          Heading.new(text: "[Physics Laboratory]"),
          Paragraph.new(text: "Hello, #{scientist.name_with_title}")
        ]
      end
    end
  end
end
