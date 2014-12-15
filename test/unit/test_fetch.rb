# -*- encoding: utf-8 -*-
require 'helper'
require 'open-uri'

class TestFetch < Volleycal::TestCase
  include Volleycal

  def setup
    io = mocked do
      open('http://www.volleyball-bundesliga.de/servlet/league/PlayingScheduleCsvExport?leagueId=8750636')
    end

    @games = Volleycal::Parser.parse(io, League.new(8750636, '1. Bundesliga Frauen'))
  end

  def test_size
    refute_nil(@games)
    refute(@games.empty?)
    assert_equal(132, @games.size)
  end

  def test_ical
    stream = Volleycal::Calendar.new(@games).to_ical
    refute_nil(stream)

    cals = Icalendar.parse(stream)
    refute_nil(cals)
    assert_equal(1, cals.size)

    cal = cals.first
    assert_equal(132, cal.events.size)
    assert_equal('Dresdner SC - Köpenicker SC Berlin', cal.events[42].summary)
    assert_equal(1422473400, cal.events[102].dtstart.to_i)
    assert_equal(1420923300, cal.events[78].dtend.to_i)
  end
end
