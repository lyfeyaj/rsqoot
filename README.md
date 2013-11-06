RSqoot
======

A Ruby Wrapper for [Sqoot](http://www.sqoot.com) [API V2](http://docs.sqoot.com/v2/overview.html). With Auto-caching for all APIS, and Auto-increment for deals.

To get the list of available parameters kindly check out [API V2](http://docs.sqoot.com/v2/overview.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rsqoot'
```

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
    expired_in            # 1.hour by default

There’s a handy generator that generates the default configuration file into config/initializers directory. Run the following generator command, then edit the generated file.

    rails g rsqoot:config

Then, you should be able to use `SqootClient` to search deals. For example:

```ruby
SqootClient.deals(query: 'Home')
```

You can also change your configuration in your own instance, such as below:

```ruby
sqoot ||= RSqoot::Client.new(public_api_key: "YOUR PUBLIC API KEY", private_api_key: 'YOUR PRIVATE API KEY')
```

#### Basic Usages

```ruby
sqoot ||= RSqoot::Client.new

sqoot.deals
#=> returns a list of deals

sqoot.deals(query: 'travel')

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

sqoot.providers(query: 'Groupon')

sqoot.categories
# => returns a list of categories

sqoot.categories(query: 'home')
sqoot.categories(query: 'home&health')
sqoot.categories(query: 'home,health')

sqoot.commissions
# => returns current month commissions

sqoot.commissions(to: '2012-01-01', from: '2012-01-20')
# => returns commissions using date_range :to & :from

sqoot.clicks
# => returns real-time clicks from the event request limit of 1000

sqoot.clicks(to: '2012-01-01', from: '2012-01-20')
# => returns clicks using date_range :to & :from
```

#### Auto Cache

Please notice that each query with above methods will automaticlly cache the result

If you want to fetch the newest records each time, you can do as below:

```ruby
sqoot.deals(location: 'Chicago', expired_in: 1.second)
```

By this, it will update the cache by each query.

#### Auto increment for deals

```ruby
sqoot.total_sqoot_deals(query: 'Home', page: 2, category_slugs: 'US')
# For this method, it will cache all the pages for current query options, the more you query the more it will store until reach the end.

# For example:
sqoot.total_sqoot_deals(query: 'Home', page: 1, per_page: 20, category_slugs: 'US').count
# => 20 records
sqoot.total_sqoot_deals(query: 'Home', page: 2, per_page: 20, category_slugs: 'US').count
# => 40 records

# But once you change your query options, it will re-cache the records.
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
