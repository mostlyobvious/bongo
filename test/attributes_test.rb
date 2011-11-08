require "test_helper"

class TestEvent
  include Bongo::Attributes

  attribute :name, String
end

class TestAttributes < Test::Unit::TestCase
  def test_attributes_in_initialze
    ev = TestEvent.new(name: 'attribute set')
    assert_equal 'attribute set', ev.name
    assert_equal ev.attributes, {name: 'attribute set'}
  end

  def test_attributes_on_object
    ev = TestEvent.new
    ev.name = 'attribute set'
    assert_equal ev.attributes, {name: 'attribute set'}
  end

  def test_non_existing_attribute
    ev = TestEvent.new(priority: 1)
    assert_equal ev.attributes, {name: nil}
    assert_raises(NoMethodError) { ev.priority }
    assert_raises(NoMethodError) { ev.priority = 2 }
  end
end
