require "bongo"
require "active_support/core_ext/hash/slice"

module Bongo
  module Indexes
    def self.included(base)
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def initialize(*args)
        self.class.indexes.each do |attr, opts|
          self.class.collection.create_index(attr, opts)
        end
        super if defined?(:super)
      end
    end

    module ClassMethods
      def index(attr, options = {})
        indexes[attr] = options
      end

      def indexes
        @indexes ||= {}
      end
    end
  end
end
