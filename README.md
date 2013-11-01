RSqoot
======

A Ruby Wrapper For Sqoot API V2

Wrapper for [Sqoot](http://www.sqoot.com) [API V2](http://docs.sqoot.com/v2/overview.html).

To get the list of available parameters kindly check out [API V2](http://docs.sqoot.com/v2/overview.html)

## Installation

Add this line to your application's Gemfile:

    gem 'rsqoot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rsqoot

## Usage

#### General configuration options

    public_api_key        # YOUR PUBLIC API KEY
    private_api_key       # YOUR PRIVATE API KEY
    base_api_url          # 'https://api.sqoot.com' by default
    authentication_method # :header by default
    read_timeout          # 20 by default

There’s a handy generator that generates the default configuration file into config/initializers directory. Run the following generator command, then edit the generated file.

    rails g rsqoot:config

You can also change your configuration in your instance, such as below:

    sqoot ||= RSqoot::Client.new(public_api_key: "YOUR PUBLIC API KEY")

#### Basic Usages

    sqoot ||= RSqoot::Client.new

    sqoot.deals
    #=> returns a list of deals

    sqoot.deals(location: 'Chicago')

    sqoot.deals(location: 'Chicago', per_page: 10)

    sqoot.deals(location: 'Chicago', per_page: 10, categories: 'health-beauty', page: 2)

    sqoot.deals(price_at_least: 10, order: :commission_desc)

    sqoot.impression(1555288, geometry: '250x250C')
    # => return deal_id 1555288's image url which size is 250x250

    sqoot.deal(1555288).url
    # => return a click url which will redirect to another url

    sqoot.providers
    # => returns a list of providers

    sqoot.commissions
    # => returns current month commissions

    sqoot.commissions(to: '2012-01-01', from: '2012-01-20')
    # => returns commissions using date_range :to & :from

    sqoot.clicks
    # => returns real-time clicks from the event request limit of 1000

    sqoot.clicks(to: '2012-01-01', from: '2012-01-20')
    # => returns clicks using date_range :to & :from

#### Auto Cache

Please notice that each query with above methods will cache the result except for sqoot.clicks

If you want to fetch the newest records each time, you can do as below:

    sqoot.deals(location: 'Chicago', time: Time.now)

By this, it will update the cache by each query.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
