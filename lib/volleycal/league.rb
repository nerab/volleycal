module Volleycal
  class League < Struct.new(:id, :title)
    alias :to_s :title
  end
end
