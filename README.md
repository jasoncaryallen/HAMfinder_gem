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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jasonallenphotography/HAMfinder_gem. This project is intended to be a welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

