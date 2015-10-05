# Optioneer [![Gem Version](https://badge.fury.io/rb/optioneer.svg)](http://badge.fury.io/rb/optioneer)[![Build Status](https://travis-ci.org/seapagan/optioneer.svg)](https://travis-ci.org/seapagan/optioneer)

[![Dependency Status](https://gemnasium.com/seapagan/optioneer.svg)](https://gemnasium.com/seapagan/optioneer)
[![Coverage Status](https://coveralls.io/repos/seapagan/optioneer/badge.svg?branch=master&service=github)](https://coveralls.io/github/seapagan/optioneer?branch=master)
[![Code Climate](https://codeclimate.com/github/seapagan/optioneer/badges/gpa.svg)](https://codeclimate.com/github/seapagan/optioneer)
[![Inline docs](http://inch-ci.org/github/seapagan/optioneer.svg?branch=master)](http://inch-ci.org/github/seapagan/optioneer)
[![PullReview stats](https://www.pullreview.com/github/seapagan/optioneer/badges/master.svg?)](https://www.pullreview.com/github/seapagan/optioneer/reviews/master)

A Ruby Gem to parse Command Line options. Yes, another one!

__Note : There is no actual usable functionality in this Gem yet, it is still in the preliminary design stages.__

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'optioneer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install optioneer

## Usage

TODO: Write usage instructions here

## To Do

Thoughts in no particular order.

-

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests (or simply `rake`). You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Violations
of this scheme should be reported as bugs. Specifically, if a minor or patch
version is released that breaks backward compatibility, that version should be
immediately yanked and/or a new version should be immediately released that
restores compatibility. Breaking changes to the public API will only be
introduced with new major versions. As a result of this policy, you can (and
should) specify a dependency on this gem using the [Pessimistic Version
Constraint][pvc] with two digits of precision. For example:

    spec.add_dependency 'optioneer', '~> 1.0'

Of course, currently we have not even reached version 1, so leave off the version requirement completely. Expect any and all of the API and interface to change!

[semver]: http://semver.org/
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
