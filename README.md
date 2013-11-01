# boxes

A collection of templates for generating some Vagrant base boxes. The idea is that 
it should be easy to automate rebuilding these (in all of the formats you need) to
keep the boxes you use with Vagrant updated.

## Requirements

* ruby / rake
* Packer >= v0.3.4

You will also need VirtualBox and/or VMware Fusion/Workstation compatible with 
Packer (and, in the case of VMware Fusion, ensured that the virtual machine tools
are downloaded and available).

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
<snip>
```

`standard` aims to follow the pattern followed by the default Vagrantboxes (both
Puppet and Chef), using the recommended installation method for each.

With a reasonably fast internet connection and SSD, the time taken to build each
both is approximately 15-20 minutes. (Or about 2 hours for a complete set per 
distro.)

## Credits

Copyright (c) 2013 Nick Charlton. MIT licensed.

This is inspired by the [GDS's boxes repo][gds], and would have been impossible
without some of the scripts which accompany [VeeWee][].

[gds]: https://github.com/alphagov/boxes
[VeeWee]: https://github.com/jedi4ever/veewee
[rake]: http://rake.rubyforge.org
[erb]: http://ruby-doc.org/stdlib-2.0.0/libdoc/erb/rdoc/ERB.html

