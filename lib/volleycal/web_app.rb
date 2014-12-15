module Volleycal
  class WebApp
    def call(env)
      id = 8750636

      [ 200,
        {
          'Content-Type'  => 'text/calendar; charset=utf-8',
#          'Last-Modified' => channel.episodes.first.enclosure.date.rfc2822
        },
        [Calendar.new(League.lookup(id).games).to_ical]
      ]
    end
  end
end
