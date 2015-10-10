# boxes

[boxes][] takes the complexity out of building custom [Vagrant][] boxes.

It's a command line tool which provides a set of templates and scripts to
combine as you need. There are also a set of pre-build boxes which are
regenerated regularly.

## Installation & Requirements

```shell
[sudo] gem install boxes
```

boxes leans on [Packer][] and [VirtualBox][], [VMware Fusion][fusion] or
[VMware Workstation][workstation] for building boxes and these will need to
available in your `$PATH`.

## Usage

boxes is driven by the `boxes` command line tool, and works with artifacts
inside it's own working directory. You need to specify a name for the build,
a template to work with and the output provider. Something like so:

```shell
boxes build --name=trusty64-empty --template=ubuntu/trusty64 --provider=vmware
```

This will build a file called `trusty64-empty.box` in the current directory.

There's lots more to `boxes` than building simple empty Vagrant boxes like
this, which can be see in the inline help.

## Contributing

1. Fork it ( https://github.com/nickcharlton/boxes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Copyright (c) 2013 Nick Charlton <nick@nickcharlton.net>

[boxes]: http://boxes.io
[Vagrant]: http://vagrantup.com
[Packer]: https://packer.io
[VirtualBox]: https://www.virtualbox.org
[fusion]: https://www.vmware.com/products/fusion/features.html
[workstation]: https://www.vmware.com/products/workstation/features.html
