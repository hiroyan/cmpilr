cmpilr
======

Simple web based compiler series for Coffeescript, Haml and Sass.


POST raw source code, then response compiled code. The last path of launched server url must be equal to file extention of posted source code.

Install & Start
======
    $ bungle install 
    $ bundle exec rackup

Usage
======
Command Line
======
    $ curl --data-binary @targetfile.coffee http(s)://launched_url/coffee/ > targetfile.js
    $ curl --data-binary @targetfile.haml http(s)://launched_url/haml/ > targetfile.html
    $ curl --data-binary @targetfile.scss http(s)://lanched_url/scss/ > targetfile.css