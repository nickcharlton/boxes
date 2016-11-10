# CHANGELOG

## 2.4.0 (10/11/2016)

* Add Ruby 2.3.1.
* Adds scripts for configuring MySQL and Postgres.
* Fix test issues where `fakefs` was broken.
* Unpin the project dependencies as it can be more lenient.
* Ubuntu Wily (15.10) was also affected by the network naming issue ([31][]).
* Stop removing persistent networking rules, as this breaks on systemd systems.
  ([31][]).
* Reduce the default set of packages which are installed ([32][]).

[31]: https://github.com/nickcharlton/boxes/pull/31
[32]: https://github.com/nickcharlton/boxes/pull/32

## 2.3.0 (10/06/2016)

* Add support for Ubuntu Xenial (16.04) ([28][]).
* Remove Ubuntu Vivid (15.04) ([29][]).
* Add `libffi-dev` for Ansible.
* Fixes an issue with Xenial where the network is lost after building.
* Update the Ubuntu Trusty (14.04) ISO image.
* Update the Debian Jessie ISO.

[29]: https://github.com/nickcharlton/boxes/pull/29
[28]: https://github.com/nickcharlton/boxes/pull/28

## 2.2.0 (10/05/2016)

* Update the Trusty ISO image to a working kernel.
* Update the Jessie ISO image.
* Allow fetching the Chef deb insecurely (this breaks on Debian).
* Add the `ca-certificates` package to the Debian preseed.
* Fixes reasonably consistent shutdown failures.
* Remove ruby from the default packages in `postinstall.sh`.

## 2.1.1 (02/03/2016)

* Fixes broken Jessie ISO urls.

## 2.1.0 (15/02/2016)

* Adds support for Debian Jessie (@kirjatoukka).
* Adds support for Ubuntu Vivid (15.04) and Wily (15.10).
* Updates the Debian Wheezy URL to a valid mirror ([24][]).
* Reverts the switch to `open-vm-tools`, which was breaking certain kernel
  support.
* Updates the version of `ruby-install` used in `scripts/ruby.sh`.
* Removes Ruby 2.1.5, 2.2.0 and 2.2.1.
* Adds Ruby 2.2.3, 2.2.3 and 2.3.0.

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
[24]: https://github.com/nickcharlton/boxes/issues/24
[25]: https://github.com/nickcharlton/boxes/issues/25
