module Physicist
  module Laboratory
    class MoveScientist < Metacosm::Command
      attr_accessor :scientist_id, :direction
    end
  end
end
