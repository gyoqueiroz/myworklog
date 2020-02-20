# myworklog

[![Gem Version](https://img.shields.io/gem/v/myworklog?style=plastic)][gem]

[gem]: https://rubygems.org/gems/myworklog

Simple Ruby CLI for logging day-to-day work

Installation
------------

`gem install myworklog`

Running
-------

Open a terminal and type `myworklog` it will print all the available options.

Please notice that the PStore database is created in your home folder, under `.myworklog` directory.

`myworklog help` displays all the options

Using
-----

- Logging work

`myworklog add "I worked hard today"` (This will create a work log for the current date)

`myworklog add -d 10/10/2010 "Submitted PR to fix an issue"` (This will create a work log for the specified date)

- Searching for logged work

`myworkglog list` (Prints all the work logs for the current date)

`myworklog list yesterday` (Prints all the work logs for the previous day)

`myworklog list -m 2` (Prints all the work logs for Februrary)

`myworklog list -m 2 -y 2020` (Prints all the work logs for Februrary on 2020)

`myworklog list -y 2020` (Prints all the work logs for 2020)

`myworklog list_all` (Prints all the work logs contained in the database)

- Deleting logged work

`myworklog delete ID` (The ID is UUID auto-generated value and can be found when you run the `list` command)

Developing
----------

Run `install.sh` to install locally and test. 

Run `publish.sh` to publish on rubygems website.