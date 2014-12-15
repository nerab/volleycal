# -*- encoding: utf-8 -*-
require 'open-uri'

module Volleycal
  UnknownLeague = Class.new(StandardError) do
    def initialize(id)
      super("No known league with id '#{id}'")
    end
  end

  class League < Struct.new(:id, :title)
    class << self
      BY_ID = {
        8750636 => '1. Bundesliga Frauen',
        8750469 => '1. Bundesliga Männer',
        8750274 => '2. Bundesliga Nord Frauen',
        8750113 => '2. Bundesliga Süd Frauen',
        8749913 => '2. Bundesliga Nord Männer',
        8749734 => '2. Bundesliga Süd Männer',
      }

      def lookup(id)
        title = BY_ID[id]
        raise UnknownLeague.new(id) unless title

        League.new(id, title)
      end

      def all
        BY_ID.map{|id, title| League.new(id, title)}
      end
    end

    def to_s
      "#{title} (#{id})"
    end

    def games
      io = open("http://www.volleyball-bundesliga.de/servlet/league/PlayingScheduleCsvExport?leagueId=#{id}")
      Parser.parse(io, self)
    end
  end
end
