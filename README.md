# SuperStruct

Simple extensions to `Struct` to make it more compatable with `Hash` without the performance penalties of `OpenStruct`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'super_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install super_struct

## Usage

```ruby
require 'super_struct'

attributes = { name: 'John Doe' }
class Customer < SuperStruct.new(attributes)
  def has_attribute?(attribute)
    members.include?(attribute.to_sym)
  end
end

john_doe = Customer.new(attributes)
=> #<struct Customer name="John Doe">
john_doe.name
=> 'John Doe'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/super_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
