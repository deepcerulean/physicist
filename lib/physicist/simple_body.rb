module Physicist
  class SimpleBody
    attr_reader :position, :dimensions

    def initialize(position:,dimensions:)
      @position = position
      @dimensions = dimensions
    end

    def self.collection_from_tiles(tile_grid)
      simple_bodies = []

      tile_grid.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          if cell
            simple_bodies << new(position: [x,y], dimensions: [1,1])
          end
        end
      end

      simple_bodies
    end
  end
end
