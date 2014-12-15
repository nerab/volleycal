require 'csv'

module Volleycal
  module Parser
    def self.parse(io, league)
      CSV.new(io,
        col_sep: ';',
        headers: true).map do |game_data|
          CsvMapper.map(game_data, league)
      end
    end
  end
end
