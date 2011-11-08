require "active_support/core_ext/module/attribute_accessors"
require "bongo/persistence"

module Bongo
  def self.included(base)
    base.send(:include, Bongo::Persistence)
  end

  mattr_accessor :db
end
