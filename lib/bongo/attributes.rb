require "bongo"
require "virtus"
require "active_support/concern"

module Bongo
  module Attributes
    extend ActiveSupport::Concern

    included do
      include Virtus
    end
  end
end
