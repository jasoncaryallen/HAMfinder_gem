# HAMfinder

HAMfinder is a Ruby gem built to make developing Sinatra, Rails, and Ruby-based amateur radio programs easier to develop.

Querying [Repeaterbook.com's](http://www.repeaterbook.com) data using application-defined criteria, this gem returns a collection of repeaters matching the criteria as JSON objects - conveniently named by their callsigns! For example, here is a record for a 2 meter band repeater near me in Washington, DC:

```ruby
{:K4DCA=>
  {:frequency=>"145.1100",
   :offset=>"-0.6MHz",
   :tone=>"CC1",
   :call=>"K4DCA",
   :location=>"Washington",
   :state=>"DC",
   :usage=>"OPEN",
   :voip=>"",
   :distance=>"0.8",
   :direction=>"S"}}
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hamfinder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hamfinder

## Usage

COMING SOON! Check back after Wednesday, 14 September, 2016.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hamfinder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

