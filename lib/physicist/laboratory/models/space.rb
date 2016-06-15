module Physicist
  module Laboratory
    class Space < Metacosm::Model
      has_many :scientists

      # attr_accessor :scientists
      attr_accessor :grid_map

      def obstacles
        SimpleBody.collection_from_tiles(grid_map)
      end
    end
  end
end
