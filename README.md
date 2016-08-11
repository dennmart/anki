# Anki

Generate decks ready to be imported into [Anki](http://ankisrs.net/)! The anki gem will take an array of hashes and convert them into a string which can then be saved to a file that is ready to be imported into your Anki decks.

## Installation

Add this line to your application's Gemfile:

    gem 'anki'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anki

## Usage

### Generating a string for cards

After requiring the anki gem, create a new instance of `Anki::Deck`, pass in the headers (as an array of strings) and the card data (as an array of hashes), and generate the deck by using the `Anki::Deck#generate_deck` method. The generated deck is a string in the Anki separator format ready to be saved into a file for importing into Anki.

The Anki::Deck can be created either by including the `card_headers` and `card_data` option when creating the `Anki::Deck` object, or by using the `Anki::Deck#card_heaers` and `Anki::Deck#card_data` methods.

The card data can contain any keys and values. When the Anki::Deck is generated only the keys that match the card headers will be used as output, this may result in a completely empty card so make sure you check your headers and card data appropriately.


```ruby
require 'anki'

headers = [ "front", "back" ]
cards = [
          { "front" => "Front of the card", "back" => "Back of the card" },
          { "front" => "Another card", "back" => "Another answer", "unused header" => "This will be ignored and not be in the deck" }
        ]

deck = Anki::Deck.new(card_headers: headers, card_data: cards)

# Alternatively, you can pass in the array of hashes for card data
# after initializing the object:
deck.card_headers = headers
deck.card_data = cards

deck.generate_deck
  # => "#front;back\nFront of the card;Back of the card\nAnother card;Another answer"
```

### Generating a file

Alternatively, you can pass an optional `file` option when generating the deck to save the string into a file directly.

```ruby
# If you want to save it into a file directly, you can pass an optional `file` option
# with the path where you want to save the file:
deck.generate_deck(file: "/tmp/anki_deck.txt")
```

### Including card tags

Tags are nothing special. Any field can be used as the Tag. When you are importing to Anki set the Field mapping to "Map to Tags" by clicking on the Change button for the field that contains your tags.

```ruby
require 'anki'

headers = [ "front", "back", "Tags" ]
cards = [
          { "front" => "Front of the card", "back" => "Back of the card", "Tags" => "one_tag" },
          { "front" => "Another card", "back" => "Another answer", "Tags" => "multiple tags are separated by spaces" }
        ]
deck = Anki::Deck.new(card_headers: headers, card_data: cards)
deck.generate_deck
  # => "#front;back;Tags\nFront of the card;Back of the card;one_tag\nAnother card;Another answer;multiple tags are separated by spaces"
```

### Custom field separators

By default, fields are separated by semicolons when generating a deck. If you want to use a custom field separator, you can add an optional `field_separator` option when generating the deck.

```ruby
require 'anki'

headers = [ "front", "back", "Tags" ]
cards = [
          { "front" => "Front of the card", "back" => "Back of the card", "Tags" => "one_tag" },
          { "front" => "Another card", "back" => "Another answer", "Tags" => "multiple tags are separated by spaces" }
        ]
deck = Anki::Deck.new(card_headers: headers, card_data: cards, field_separator: "|")
deck.generate_deck
  # => "#front|back|Tags\nFront of the card|Back of the card|one_tag\nAnother card|Another answer|multiple tags are separated by spaces"
```

## Contributing

1. Fork the anki gem into your own repo (https://github.com/dennmart/anki/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`) and make sure your write tests for your new feature!
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. That's it! High fives given upon request :)
