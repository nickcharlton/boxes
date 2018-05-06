# CHANGELOG

## 3.3.1 (27/04/2018)

* Refresh Ubuntu Xenial ISO image. ([55])
* Refresh Debian Stretch ISO image. ([54])

[54]: https://github.com/nickcharlton/boxes/pull/54
[55]: https://github.com/nickcharlton/boxes/pull/55

## 3.3.0 (27/04/2018)

* Revoke Ubuntu Bionic (18.04) support ([53]).

_**Note:** Ubuntu 18.04 changes the way some networking is configured and so
doesn't correctly boot up._

## 3.2.0 (27/04/2018)

* Ubuntu Bionic (18.04) support ([53]).

[53]: https://github.com/nickcharlton/boxes/pull/53

## 3.1.0 (08/04/2018)

* Switch to use the Boxes Metadata API for Chef ([52]).
* Fix Puppet deb installation ([51])

[51]: https://github.com/nickcharlton/boxes/pull/51
[52]: https://github.com/nickcharlton/boxes/pull/52

## 3.0.0 (05/02/2018)

* Update scripts/ruby.sh to follow ruby-lang.org current Rubies ([48]).
* Fix a bug with Shell Path Expansion ([44]).
* Add acceptance testing using RSpec ([43], [48], [49]).
* Remove Cucumber ([42]).
* Update Ubuntu Xenial to 16.04.3 ([40]).
* Update Ubuntu Trusty to 14.04.5 ([39]).
* Update Debian Stretch to 9.3.0 ([38]).
* Add support for Debian Stretch (9.1).
* Drop support for Ubuntu Wily 15.10.
* Switch to a working mirror for Debian Jessie.

[38]: https://github.com/nickcharlton/boxes/pull/38
[40]: https://github.com/nickcharlton/boxes/pull/40
[42]: https://github.com/nickcharlton/boxes/pull/42
[43]: https://github.com/nickcharlton/boxes/pull/43
[44]: https://github.com/nickcharlton/boxes/pull/44
[48]: https://github.com/nickcharlton/boxes/pull/48
[49]: https://github.com/nickcharlton/boxes/pull/49

## 2.5.0 (20/01/2017)

* Add Ruby 2.3.3.
* Removes Rubies 2.2.2, 2.3.0.
* Add Ruby 2.4.0.

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
