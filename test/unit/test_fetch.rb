# -*- encoding: utf-8 -*-
require 'helper'

class TestFetch < Volleycal::TestCase
  include Volleycal

  def setup
    @games = mocked do
      League.lookup(8750636).games
    end
  end

  def test_size
    refute_nil(@games)
    refute(@games.empty?)
    assert_equal(132, @games.size)
  end

  def test_ical
    stream = Calendar.new(@games).to_ical
    refute_nil(stream)

    cals = Icalendar.parse(stream)
    refute_nil(cals)
    assert_equal(1, cals.size)

    cal = cals.first
    assert_equal(132, cal.events.size)
    assert_equal('Dresdner SC - Köpenicker SC Berlin', cal.events[42].summary)
    assert_equal(1422727200, cal.events[102].dtstart.to_i)
    assert_equal(1420923300, cal.events[78].dtend.to_i)
  end
end
