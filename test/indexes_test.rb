require "test_helper"

class TestIndexes < MiniTest::Unit::TestCase
  include EventedHelper
  include DatabaseHelper

  def test_indexes_creation
    assert_equal 1, TestEvent.new.class.indexes.size

    TestEvent.new.class.collection.index_information.callback do |indexes|
      assert_equal 2, indexes.size
      done
    end
  end
end
