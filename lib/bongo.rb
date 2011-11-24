require "active_support/core_ext/module/attribute_accessors"
require "bongo/persistence"
require "bongo/indexes"

module Bongo
  mattr_accessor :db

  def self.included(base)
    base.send(:include, Bongo::Persistence)
    base.send(:include, Bongo::Indexes)
  end
end
