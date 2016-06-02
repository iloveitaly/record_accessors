# RecordAccessors

This incredibly simple gem solves this specific issue:

* http://stackoverflow.com/questions/1676200/listing-the-accessors-in-a-ruby-class
* http://stackoverflow.com/questions/2487333/fastest-one-liner-way-to-list-attr-accessors-in-ruby

It is useful for processing JSON payloads with PORO subclassing `ActiveModelSerializers::Model`, or any scenario where you need to track and query against the fields defined on a ruby class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'record_accessors'
```

## Usage

```ruby
class ShipmentSerializer < ActiveModelSerializers::Model
  include RecordAccessors

  attr_accessor :id, :order_id

  def initialize(payload = {})
    initialize_from_attributes(payload)

    super(hash_from_attributes)
  end
end

payload = {
  id: 123,
  order_id: 'R123',
  other_field: 'this will be excluded from the serialized shipment'
}

shipment = ShipmentSerializer.new(payload)

render json: shipment
```

## [License](LICENSE)
