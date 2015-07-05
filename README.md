# volleycal

Provides the schedule of the German Volleyball 1. Bundesliga. It converts [Volleyball Bundesliga](http://www.volleyball-bundesliga.de) information into the iCal format and provides it via http, so that you can subscribe to it in a calendar application and keep up to date.

# Development

There is a `Vagrantfile` for testing the docker image via docker:

    $ vagrant up

## Tests

    $ bundle exec rake

# Production Installation

volleycal is dockerized, but not published to the docker hub yet. You can easily build and run the container like this:

1. Clone the project

        $ git clone https://github.com/nerab/volleycal.git

1. Build the container

        $ sudo docker build -t nerab/volleycal .

1. Run the container and map the container's port 5000 to one that's free on the host:

        $ sudo docker run -p 49257:5000 -d nerab/volleycal

1. Configure upstart to auto-start the container after the host boots

        $ cp volleycal.conf /etc/init

1. Optionally, configure nginx to proxy from port 80 to the chosen port:

        $ cp nginx.conf /etc/nginx/sites-available/volleycal
        $ cd /etc/nginx/sites-available
        $ vi volleycal
        $ cd ../sites-enabled
        $ ln -s ../sites-available/volleycal
        $ sudo service nginx reload
