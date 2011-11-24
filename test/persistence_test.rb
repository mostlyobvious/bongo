require "test_helper"

class TestPersistence < MiniTest::Unit::TestCase
  include EventedHelper
  include DatabaseHelper

  def test_insert
    event = TestEvent.new
    event.name = 'insert operation'
    assert event.new_record?, 'is not a new record'

    defer = event.save
    defer.callback do |id|
      assert !event.new_record?, 'is a new record'

      TestEvent.find(id).callback do |ev|
        assert_equal 'insert operation', ev.name
        done
      end
    end
  end

  def test_passing_safe_insert
    event = TestEvent.new
    event.name = 'insert operation'
    assert event.new_record?, 'is not a new record'

    defer = event.save!
    defer.callback do |id|
      assert !event.new_record?, 'is a new record'

      TestEvent.find(id).callback do |ev|
        assert_equal 'insert operation', ev.name
        done
      end
    end
  end

  def test_failing_safe_insert
    skip "untestable unless unique constraint defined in db"

    event = TestEvent.new
    assert event.new_record?

    defer = event.save!
    defer.errback do |id|
      assert event.new_record?
      assert_not_nil id

      TestEvent.find(id).callback do |ev|
        assert_nil id
        done
      end
    end
  end
end
