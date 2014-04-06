# coding: utf-8
module Anki
  class Deck
    attr_accessor :card_data

    def initialize(options = {})
      @card_data = options.delete(:card_data)
    end

    def generate_deck
      raise ArgumentError, "You need card data." if self.card_data.nil? || self.card_data.empty?
      raise ArgumentError, "card_data should be an array of hashes" unless self.card_data.is_a?(Array)

      self.card_data.map { |card| "#{card.keys.first};#{card.values.first}" }.compact.join("\n")
    end
  end
end
