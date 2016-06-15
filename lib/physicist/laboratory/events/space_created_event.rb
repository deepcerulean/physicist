module Physicist
  module Laboratory
    class SpaceCreatedEvent < Metacosm::Event
      attr_accessor :space_id, :grid_map
    end
  end
end
