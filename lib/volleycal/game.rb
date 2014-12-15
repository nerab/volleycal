module Volleycal
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
end
