# MAYaml for Getmail

[![Gem Version](https://badge.fury.io/rb/mayaml-getmail.svg)](http://badge.fury.io/rb/mayaml-getmail)
[![Code Climate](https://codeclimate.com/github/skopciewski/mayaml-getmail/badges/gpa.svg)](https://codeclimate.com/github/skopciewski/mayaml-getmail)

This is the getmail configs generator which gets the accounts settigns from yaml file. See [Mayaml][mayaml_url]

## Installation

Add this line to your application's Gemfile:

    gem 'mayaml-getmail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mayaml-getmail

## Usage

If ruby bin dir is in your PATH, just call `mayaml-getmail <path_to_the_yaml_file> [<dir_for_storing_configs>]` 
to list generated configs or store them in `<dir_for_storing_configs>`.


## Versioning

See [semver.org][semver]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[semver]: http://semver.org/
[mayaml_url]: https://github.com/skopciewski/mayaml
