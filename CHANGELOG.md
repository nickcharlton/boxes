# CHANGELOG

## 2.0.2 (08/11/2015)

* Switches to `open-vm-tools` for VMWare ([20][]).
* Increases the SSH timeout to 15m. ([25][]).

## 2.0.1 (18/10/2015)

* Fixes a launch exception relating to configuration.
* Adds support for Travis CI.
* Correctly sets configured environment variables should be set before running.
* Does a better job of handling errors when running builds.

## 2.0.0 (10/10/2015)

* Conversion to being a command line tool distributed through Ruby Gems.
* Basic test coverage using Specs and Feature tests.
* Maintains an environment for running builds.
* Parses, validates and combines arguments.
* Allows the building of all of the previous styles of boxes.

[20]: https://github.com/nickcharlton/boxes/issues/20
[25]: https://github.com/nickcharlton/boxes/issues/25
