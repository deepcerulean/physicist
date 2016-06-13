module Physicist
  module Laboratory
    class ScientistView < Metacosm::View
      attr_accessor :scientist_id
      attr_accessor :display_name, :position, :velocity, :t0

      def apparent_position(t)
        body.at(t).position
      end

      def body
        # ... integrate physicist bodies ...
      end
    end

  end
end
