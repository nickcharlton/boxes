# boxes

A collection of templates for generating some Vagrant base boxes. The idea is that 
it should be easy to automate rebuilding these (in all of the formats you need) to
keep the boxes you use with Vagrant updated.

## Requirements

* ruby / rake
* Packer >= v0.3.4

You will also need VirtualBox and/or VMware Fusion/Workstation compatible with 
Packer.

## Usage

This uses [rake][] and [embedded Ruby templates][erb] to assemble the templates
Packer expects and help with automation. This allows us to programatically create
many templates with small alterations (e.g.: with or without Chef), without defining
lots of Packer source templates.

```bash
$ rake -T
rake default    # Build all of the boxes in all configurations.
rake clean      # Tidy up.

rake build:precise64-standard-virtualbox
rake build:precise64-chef-virtualbox
rake build:wheezy64-standard-virtualbox
rake build:wheezy64-chef-virtualbox
```

## Credits

Copyright (c) 2013 Nick Charlton. MIT licensed.

This is inspired by the [GDS's boxes repo][gds], and would have been impossible
without some of the scripts which accompany [VeeWee][].

[gds]: https://github.com/alphagov/boxes
[post]: http://nickcharlton.net/posts/vagrant-boxes-with-packer.html
[VeeWee]: https://github.com/jedi4ever/veewee
[rake]: http://rake.rubyforge.org
[erb]: http://ruby-doc.org/stdlib-2.0.0/libdoc/erb/rdoc/ERB.html

