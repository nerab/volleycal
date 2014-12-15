require 'icalendar'
require 'active_support/core_ext/date/calculations'

module Volleycal
  class Calendar
    def initialize(games)
      @games = games
    end

    def to_ical
      cal = Icalendar::Calendar.new
      @games.each do |game|
        cal.event do |e|
          e.dtstart     = Icalendar::Values::DateTime.new(game.date)
          e.dtend       = Icalendar::Values::DateTime.new(game.date.advance(minutes: 115))
          e.summary     = "#{game.home} - #{game.guest}"
          e.description = game.to_s
          e.location    = game.place
        end
      end

      cal.publish
      cal.to_ical
    end
  end
end
