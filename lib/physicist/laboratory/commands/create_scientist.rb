module Physicist
  module Laboratory
    class CreateScientist < Metacosm::Command
      attr_accessor :scientist_id, :name, :title, :position, :velocity
    end
  end
end
