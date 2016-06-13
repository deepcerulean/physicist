module Physicist
  module Laboratory
    # user avatars are 'scientists'
    class Scientist < Metacosm::Model
      # belongs_to :space
      attr_accessor :name, :title
      attr_accessor :position, :velocity
      attr_accessor :updated_at

      def name_with_title
        "#{title} #{name}"
      end
    end
  end
end
