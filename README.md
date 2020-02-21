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

#### Logging work

| cmd  | description   |
|------|---------------|
| `myworklog add "I worked hard today"` | (This will create a work log for the current date) |
| `myworklog add -d 10/10/2010 "Submitted PR to fix an issue"` | (This will create a work log for the specified date) |

#### Searching for logged work

| cmd  | description   |
|------|---------------|
| `myworkglog list` | (Prints all the work logs for the previous day) |
| `myworklog list yesterday` | (Prints all the work logs for the previous day) |
| `myworklog list -m 2` | (Prints all the work logs for Februrary) |
| `myworklog list -m 2 -y 2020` | (Prints all the work logs for Februrary on 2020) |
| `myworklog list -y 2020` | (Prints all the work logs for 2020) |
| `myworklog list_all` | (Prints all the work logs contained in the database) |


**The resulting output of the list command :**

    $ myworklog list -y 2015

    22cf704c-9b03-4f1d-a61d-29a4a52c66f4 | 10/01/2015 - First PR
    7b44fa0b-e5e7-4c54-9efe-08fbb432948c | 10/01/2015 - Onboarding tasks
    e5a36840-ba44-4bc3-943f-84f92e6dc6cf | 10/02/2015 - Presented POC


#### Deleting logged work

| cmd  | description   |
|------|---------------|
| `myworklog delete ID` | (The ID is UUID auto-generated value and can be found when you run the `list` command) |

Developing
----------

Run `install.sh` to install locally and test. 

Run `publish.sh` to publish on rubygems website.