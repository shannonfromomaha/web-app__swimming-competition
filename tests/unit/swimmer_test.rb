require 'test_helper'

class SwimmerTest < Minitest::Test
  
  def setup
    super
    @ocs = College.new
    @ocs.college_name = "Omaha Code School"
    @ocs.save

    @shannon_jackson = Swimmer.new
    @shannon_jackson.first_name = "Shannon Swimmer"
    @shannon_jackson.last_name = "Jackson"
    @shannon_jackson.college_id = @ocs.id
    @shannon_jackson.save

    @andrew = Swimmer.new
    @andrew.first_name = "Andrew Swimmer"
    @andrew.last_name = "Yolland"
    @andrew.college_id = @ocs.id
    @andrew.save

    @b = Swimmer.new
    @b.save

    @event = Event.new
    @event.event_name = "Swim"
    @event.save
    @event2 = Event.new
    @event2.event_name = "Sink"
    @event2.save

    @register = Signup.new
    @register.swimmer_id = @shannon_jackson.id
    @register.event_id = @event.id
    @register.save

    @f = Finish.new
    @f.swimmer_id = @shannon_jackson.id
    @f.event_id = @event.id
    @f.finish_time = 100
    @f.save

  end

  def test_swimmer_name
    assert_equal("Shannon Swimmer Jackson", @shannon_jackson.swimmer_name)
  end

  def test_find_collge_name
    assert_equal("Omaha Code School", @shannon_jackson.find_college_name)
  end

  def test_registered_events
    assert_equal([@event.id], @shannon_jackson.registered_events)
    assert_equal("n/a", @andrew.registered_events)
    refute_equal([@event2.id], @shannon_jackson.registered_events)
  end

  def test_finishtime
    assert_equal(100, @shannon_jackson.finishtime(@event.id))
    assert_equal(0,@andrew.finishtime(@event.id))
  end

  def test_register
    @e2 = Event.new
    @e2.save

    @e3 = Event.new
    @e3.save

    @andrew.register([@e2.id, @e3.id])

    assert_equal([@e2.id, @e3.id], @andrew.registered_events)
  end

  def test_get_and_set_errors
    assert_equal(["Must include first name","Must include last name","Must choose a College"], @b.get_errors)
    assert_equal(nil, @andrew.set_errors)
  end

  def test_is_valid
    assert_equal(true, @shannon_jackson.is_valid)
    refute_equal(false, @andrew.is_valid)
    assert_equal(false,@b.is_valid)
  end

  def test_register_errors
    arr = [@event.id, @event2.id]
    assert_equal([@event2.id], @shannon_jackson.register_errors(arr))
    assert_equal(arr, @andrew.register_errors(arr))
  end

end