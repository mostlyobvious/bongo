require 'test_helper'

class TestEvent
  include Bongo

  attribute :name, String
  attribute :priority, Integer
end

class IntegrationTest < Test::Unit::TestCase
  include EventedHelper
  include DatabaseHelper

  def test_persistence_with_attributes
    ev = TestEvent.new(name: 'insert operation', priority: 1)
    ev.save.callback do |id|
      TestEvent.find(id).callback do |ev|
        assert_equal 'insert operation', ev.name
        assert_equal 1, ev.priority
      end
    end
  end
end
