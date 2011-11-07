require "test_helper"

class TestEvent
  include Bongo::Persistence
end

class TestPersistence < Test::Unit::TestCase
  include DatabaseHelper
  include EventedHelper

  def test_insert
    event = TestEvent.new
    assert event.new_record?

    defer = event.save
    defer.callback do
      assert !event.new_record?
      done
    end
  end

  def test_passing_safe_insert
    event = TestEvent.new
    assert event.new_record?

    defer = event.save!
    defer.callback do
      assert !event.new_record?
      done
    end
  end

  def test_failing_safe_insert
    skip "untestable unless unique constraint defined in db"

    event = TestEvent.new
    assert event.new_record?

    defer = event.save!
    defer.errback do
      assert event.new_record?
      done
    end
  end
end
