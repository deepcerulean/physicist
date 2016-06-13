module Physicist
  module Laboratory
    class Space < Metacosm::Model
      # has_many :scientists

      attr_accessor :scientists
      attr_accessor :map
      # has_one :structure
    end
  end
end
