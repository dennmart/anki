# coding: utf-8
module Anki
  class Deck
    attr_accessor :card_data

    def initialize(options = {})
      @card_data = options.delete(:card_data)
    end

    def generate_deck(options = {})
      raise ArgumentError, "card_data should be an array of hashes" if !self.card_data.is_a?(Array)
      raise ArgumentError, "You need card data." if self.card_data.empty?

      anki_string = self.card_data.map { |card| "#{card.keys.first};#{card.values.first}" }.compact.join("\n")
      create_file(anki_string, options[:file]) if options[:file]
      anki_string
    end

    private

    def create_file(str, file)
      File.open(file, 'w') { |f| f.write(str) }
    end
  end
end
