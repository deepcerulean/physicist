module Physicist
  module Laboratory
    class Screen < Dedalus::Screen
      include Dedalus::Elements
      attr_accessor :scientist, :map_grid, :camera

      def show
        [
          Paragraph.new(text: "Welcome to the lab, #{scientist.display_name}!"),
          Paragraph.new(text: "Pos: #{scientist.current.position}"),
          Paragraph.new(text: "Vel: #{scientist.current.velocity}"),
          field
        ]
      end

      def field
        SpriteField.new(
          grid: map_grid,
          scale: 1.0,
          camera_location: camera,
          tiles_path: "media/images/tiles.png",
          tile_width: 64,
          tile_height: 64,
          tile_class: "Dedalus::Elements::MapTile",
          sprite_map: sprite_map
        )
      end

      def sprite_map
        { scientist.current.position => [avatar_for(scientist)] }
      end

      def avatar_for(scientist)
        Dedalus::Elements::Sprite.new(
          path: 'media/images/walk.png',
          frame: 0,
          invert_x: false,
          asset_width: 64,
          asset_height: 64,
          scale: 2.0
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
