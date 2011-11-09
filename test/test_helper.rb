require "bundler/setup"
gem "minitest"
require "turn"
require "minitest/autorun"
require "em-spec/test"
require "active_support/concern"
require "bongo/persistence"


module DatabaseHelper
  def setup
    Bongo.db = EM::Mongo::Connection.new.db("bongo_test")
    super
  end

  def teardown
    Bongo.db.collections.callback do |collections|
      collections.select { |c| c.name !~ /^system\./ }.each do |collection|
        collection.remove
      end
    end
    super
  end
end

module EventedHelper
  extend ActiveSupport::Concern

  included do
    include EM::Test
    default_timeout(0.5)
  end

  def skip(*args)
    done
    super
  end
end
