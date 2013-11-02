# Model JSON

This extension allows you to define JSON hashes for ActiveRecord models allowing
you to easily convert your models into JSON for API or Javascript consumption.

## Installation

As normal, just pop the following into your `Gemfile` and restart your webserver.

```ruby
gem 'nifty-model-json', '~> 1.0.0', :require => 'nifty/model_json'
```

## Configiruation

To configure your models, just use the `json` method as shown in the example below.

```ruby
class Person < ActiveRecord::Base
  
  # Some relationships to demonstrate how things work through relationships.
  belongs_to :parent
  has_many :children, :class_name => 'Parent', :foreign_key => 'parent_id'
  
  # Return the user's full name
  def full_name
    "#{first_name} #{last_name}"
  end
  
  # Define multiple attributes to expose. These can either be attributes or
  # methods on the model.
  json :first_name, :last_name, :full_name
  
  # Specify a different name for a method or attribute
  json :age_in_years, :as => :age
  
  # Specify attributes within a group
  json :address_line1, :group => :address, :as => :line1
  json :address_line2, :group => :address, :as => :line2
  
  # Use `with_options` to avoid repeating yourself
  with_options :group => :address do |p|
    p.json :address_line3, :as => :line3
    p.json :address_line4, :as => :line4
    p.json :address_line5, :as => :line5
  end
  
  # Specify conditionals based on the contents of the model
  json :eye_colour, :if => proc { |person| person.age >= 18 }
  
  # Specify conditions based on the values passed when the JSON has
  # is generated
  json :ssn, :if => proc { |person, opts| opts[:user].is_admin? }
  
  # As well as attributes and methods, you can specify relationships. 
  # In the case of belongs_to relationships a hash will be and for 
  # has_many you will have an array of hashes.
  json :parent
  json :children
  
end
```

## Calling

In order to access the JSON, you can use the following methods on the
model itself.

```ruby
person = Person.first
person.to_nifty_json_hash       #=> Returns the full hash as a Ruby hash
person.to_nifty_json            #=> Returns the JSON string for the hash
```

You can pass a hash to both these methods which will be passed to any :if
condition which you may have specified. 