module Physicist
  module Laboratory
    class ScientistCreatedEvent < Metacosm::Event
      attr_accessor :scientist_id, :space_id, :name, :title, :position, :velocity
    end
  end
end
