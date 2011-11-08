require "em-mongo"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/concern"
require "bongo/persistence"
require "bongo/attributes"

module Bongo
  extend ActiveSupport::Concern

  included do
    include Bongo::Attributes
    include Bongo::Persistence
  end

  mattr_accessor :db
end
