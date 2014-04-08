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

After requiring the anki gem, simply create a new instance of `Anki::Deck`, pass in an array of hashes (either including the `card_data` option when creating the `Anki::Deck` object, or using the `Anki::Deck#card_data` method), and generate the deck by using the `Anki::Deck#generate_deck` method. It will return a string that is formatted to be ready to be saved into a file for importing into Anki.

Alternatively, you can pass an optional `file` option when generating the deck to save the string into a file directly.

```ruby
require 'anki'

cards = [{ "Front of the card" => "Back of the card" }, { "Another card" => "Another answer" }]

deck = Anki::Deck.new(card_data: cards)

# Alternatively, you can pass in the array of hashes for card data after initializing the object:
# deck.card_data = cards

deck.generate_deck
  # => "Front of the card;Back of the card\nAnother card;Another answer"

# If you want to save it into a file directly, you can pass an optional `file` option with the path where you want to save the file:
deck.generate_deck(file: "/tmp/anki_deck.txt")
```

## Contributing

1. Fork the anki gem into your own repo (https://github.com/dennmart/anki/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`) and make sure your write tests for your new feature!
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. That's it! High fives given upon request :)
