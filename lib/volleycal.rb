require 'volleycal/version'
require 'csv'

module Volleycal
  class League < Struct.new(:id, :title)
    alias :to_s :title
  end

  class Game < Struct.new(:id, :date, :place, :match_day, :home, :guest, :host, :result, :league)
    MissingFieldError = Class.new(StandardError)
    NILLABLE_FIELDS = [:place, :result, :league]

    def validate!
      errors = (members - NILLABLE_FIELDS).map{|required_field| MissingFieldError.new(required_field) if required_field.nil?}.compact
      raise errors.join(',') if errors.any?
      raise "Unexpected order or home '#{home}' and host '#{host}'" unless home == host
      raise "Either place or result are required" if place.nil? && result.nil?
    end

    def to_s
      result ? "Ergebnis: #{result}" : "#{match_day} der #{league}"
    end
  end

  module CsvMapper
    def self.map(game_data, league)
      Game.new.tap do |game|
        game.id = game_data['#']
        game.date = DateTime.parse(game_data['Datum'] + ' ' + game_data['Uhrzeit'])

        place_result = game_data['Austragungsort/Ergebnis'].encode(Encoding::UTF_8)

        if %r{\d+:\d+}.match(place_result)
          game.result = place_result
        else
          game.place = place_result
        end

        game.match_day = game_data['ST']
        game.home = game_data['Mannschaft 1'].encode(Encoding::UTF_8)
        game.guest = game_data['Mannschaft 2'].encode(Encoding::UTF_8)
        game.host = game_data['Gastgeber'].encode(Encoding::UTF_8)
        game.league = league

        game.validate!
      end
    end
  end

  module Parser
    def self.parse(io, league)
      CSV.new(io,
        col_sep: ';',
        headers: true).map do |game_data|
          CsvMapper.map(game_data, league)
      end
    end
  end

  require 'icalendar'
  require 'active_support/core_ext/date/calculations'

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
