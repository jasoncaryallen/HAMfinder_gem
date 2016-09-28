# HAMfinder   [![Build Status](https://travis-ci.org/jasonallenphotography/HAMfinder_gem.svg?branch=master)](https://travis-ci.org/jasonallenphotography/HAMfinder_gem)  [![codecov](https://codecov.io/gh/jasonallenphotography/HAMfinder_gem/branch/master/graph/badge.svg)](https://codecov.io/gh/jasonallenphotography/HAMfinder_gem)  [![Gem Version](https://badge.fury.io/rb/hamfinder.svg)](https://badge.fury.io/rb/hamfinder) [![Dependency Status](https://gemnasium.com/badges/github.com/jasonallenphotography/HAMfinder_gem.svg)](https://gemnasium.com/github.com/jasonallenphotography/HAMfinder_gem)



HAMfinder is a Ruby gem built to make developing Ruby on Rails-based amateur radio programs easier to develop.

Querying [Repeaterbook.com's](http://www.repeaterbook.com) data using application-defined criteria, this gem returns a collection of repeaters matching the criteria in JSON format - conveniently named sequentially, sorted by ascending proximity! For example, here is a record for a 2 meter band repeater near me in Washington, DC:

```ruby
{"1" =>
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

Now you can use your HAMFinder's query method to retrieve data according to your provided parameters.

```ruby
@results = Hamfinder::Parser.query( zip:"11232", radius:5, band:"2m" )
```

The `.query()` method accepts the following options:
* zip
* radius
* band


The `zip` parameter must be a valid 5 digit US postal zip code passed as a string (i.e. `zip:"22181"`).

The `radius` parameter (in miles) must be an integer greater than 0 and less than or equal to 200 (i.e. `radius:50`). If no radius is entered as a parameter the default is a radius of 10 miles, roughly the maximum distance a low powered handheld radio can reach on 2m band.

The `band` parameter specifies the frequency band you wish to query, and must be passed as a string. `band` accepts the following values, or defaults to `2m`:
* `"10m"`
* `"6m"`
* `"2m"`
* `"1.25m"`
* `"70cm"`
* `"33cm"` 
* `"23cm"`  

Examples of output:
```ruby
#10m band repeaters within 5 miles of 20009, Washington DC
puts Hamfinder::Parser.query( zip:"20009", band:"10m", radius:5 )
=> ["NO REPEATERS FOUND WITHIN 5 MILES of 38.9191485, -77.0362967."]

#2m band repeaters within 2 miles of 20009, Washington DC
puts Hamfinder::Parser.query( zip:"20009", radius:2 )
=> { "1" =>{:frequency=>"145.1100", :offset=>"-0.6MHz", :tone=>"CC1", :call=>"K4DCA", 
          :location=>"Washington", :state=>"DC", :usage=>"OPEN",
          :voip=>"", :distance=>"0.8", :direction=>"S"},
     "2" =>{:frequency=>"145.1900", :offset=>"-0.6MHz", :tone=>"151.4", :call=>"W3DOS", 
          :location=>"Washington,HarryS.TrumanBuilding", :state=>"DC", :usage=>"OPEN", 
          :voip=>"", :distance=>"1.7", :direction=>"S"}, 
     "3" =>{:frequency=>"147.3600", :offset=>"+0.6MHz", :tone=>"", :call=>"W3AGB",
          :location=>"Washington", :state=>"DC", :usage=>"OPEN",
          :voip=>"", :distance=>"1.7", :direction=>"S"},
     "4" =>{:frequency=>"145.4300", :offset=>"-0.6MHz", :tone=>"114.8", :call=>"K3MRC", 
          :location=>"Washington,D.C.", :state=>"DC", :usage=>"OPEN", 
          :voip=>"", :distance=>"1.7", :direction=>"S"} }

#2m band repeaters within a default 10 miles of 20009, Washington DC     
puts Hamfinder::Parser.query( zip:"20009" )
=> { "1" =>{:frequency=>"147.3150", :offset=>"+0.6MHz", :tone=>"107.2", :call=>"W4HFH", 
             ...
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jasonallenphotography/HAMfinder_gem. This project is intended to be a welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

