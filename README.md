# boxes

A collection of templates and a makefile for generating some simple Vagrant base
boxes. The idea is that it should be easy to automate rebuilding these (in all of
the formats you need) to keep the underlying box updated.

[This project was the outcome of a post I wrote about building Vagrant boxes][post].

## Requirements

* make
* Packer >= v0.3.4
* Vagrant >= v1.2.3
* Vagrant VMware provider (if you intend to use VMware boxes).

You will also need VirtualBox or VMware Fusion/Workstation.

## Usage

## Credits

Copyright (c) 2013 Nick Charlton. MIT licensed.

This is inspired by the [GDS's boxes repo][gds].

[gds]: https://github.com/alphagov/boxes
[post]: http://nickcharlton.net/posts/vagrant-boxes-with-packer.html

