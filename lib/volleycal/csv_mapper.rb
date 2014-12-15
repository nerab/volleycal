module Volleycal
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
end
