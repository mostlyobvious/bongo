require "bongo"
require "virtus"
require "em-mongo"
require "active_support/core_ext/hash/indifferent_access"
require "active_support/inflector"

module Bongo
  module Persistence
    def self.included(base)
      base.extend ClassMethods
      base.send(:include, Virtus) # order is important
      base.send(:include, InstanceMethods)
      base.send(:attr_writer, :db)
    end

    module InstanceMethods
      def initialize(*args)
        super if defined?(:super)
        @new_record = true
        @destroyed  = false
      end

      def new_record?
        !!@new_record
      end

      def destroyed?
        !!@destroyed
      end

      def save(opts = {})
        new_record? ? insert(opts) : update(opts)
      end

      def save!(opts = {})
        save(opts.merge(safe: true))
      end

      def destroy(opts = {})
        remove(opts)
      end

      def destroy!(opts = {})
        destroy(opts.merge(safe: true))
      end

      protected
      def document
        attributes
      end

      def insert(opts = {})
        safe = opts.delete(:safe) || false
        resp = self.class.collection.safe_insert(document, safe: safe)
        resp.callback { @new_record = false }
        resp
      end

      def insert!(opts = {})
        insert(opts.merge(safe: true))
      end

      def update(opts = {})

      end

      def update!(opts = {})
        update(opts.merge(safe: true))
      end

      def remove(opts = {})
        @destroyed = true
      end

      def remove!(opts)
        remove(opts.merge(safe: true))
      end
    end

    module ClassMethods
      def db
        @db || Bongo.db
      end

      def collection_name
        self.name.tableize
      end

      def collection
        db.collection(collection_name)
      end

      def find(id)
        defer  = EM::DefaultDeferrable.new
        finder = collection.find_one(id)
        finder.callback do |document|
          instance = self.new(document)
          defer.succeed(instance)
        end
        finder.errback  { defer.fail }
        defer
      end
    end
  end
end
