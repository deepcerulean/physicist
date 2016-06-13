module Physicist
  module Laboratory
    class ScientistUpdatedEvent < Metacosm::Event
      attr_accessor :scientist_id, :position, :velocity, :updated_at
    end
  end
end
