cmpilr
======

Simple WEB based compiler series for Coffeescript, Haml and Sass.

POST a raw source code to the cmpilr api, then compiled code is responsed. The last path of api must be equal to file extention of the posted source code.

Install & Start
======
    $ bungle install 
    $ bundle exec rackup

Usage
======
Command Line
-----
    $ curl --data-binary @targetfile.coffee http(s)://launched_url/coffee/ > targetfile.js
    $ curl --data-binary @targetfile.haml http(s)://launched_url/haml/ > targetfile.html
    $ curl --data-binary @targetfile.scss http(s)://lanched_url/scss/ > targetfile.css
Sublime Text Plugin
----
[SublimeCmpilr](https://github.com/hiroyan/SublimeCmpilr.git) is useful for this api.
