# volleycal

Provides the schedule of the German Volleyball 1. Bundesliga. It converts [Volleyball Bundesliga](http://www.volleyball-bundesliga.de) information into the iCal format and provides it via http, so that you can subscribe to it in a calendar application and keep up to date.

# Development

There is a `Vagrantfile` for testing the docker image via docker:

    $ vagrant up

## Tests

    $ bundle exec rake

# Production Installation

Volleycal can be dockerized, but not published to the docker hub yet. You can easily build an image and run a container from it like this:

## Instantiate the image

1. Build the image from the git repo and tag it as `nerab/volleycal`

        $ sudo docker build -t nerab/volleycal https://github.com/nerab/volleycal.git

1. Create the container and map the container's inner port 5000 to the outer one (choose a free one on the host machine):

        $ sudo docker run -p 49257:5000 --detach=true --name volleycal nerab/volleycal

1. Test that the application is working correctly:

        $ curl localhost:49257
        BEGIN:VCALENDAR
        VERSION:2.0
        ...

## Auto-start the container when the host starts

1. Configure upstart to start the container after the host boots:

        $ cp volleycal.conf /etc/init

Test by starting and stopping the container manually:

        # start
        $ initctl start volleycal

        # stop
        $ sudo docker stop volleycal

## Proxy

Optionally, an HTTP proxy like nginx can be configured to proxy the host's port 80 to the outer port of the container:

        $ cp nginx.conf /etc/nginx/sites-available/volleycal
        $ cd /etc/nginx/sites-available
        $ vi volleycal
        $ cd ../sites-enabled
        $ ln -s ../sites-available/volleycal
        $ sudo service nginx reload
