# coding: utf-8
module Anki
  class Deck
    attr_accessor :card_headers,:card_data

    def initialize(options = {})
      @card_headers = options.delete(:card_headers)
      @card_data = options.delete(:card_data)
    end

    def generate_deck(options = {})
      raise ArgumentError, "card_headers must be an array" if !self.card_headers.is_a?(Array)
      raise ArgumentError, "card_headers must not be empty" if self.card_headers.empty?
      raise ArgumentError, "card_data must be an array" if !self.card_data.is_a?(Array)
      raise ArgumentError, "card_data must not be empty" if self.card_data.empty?

      anki_string = ""
      anki_string << card_header_to_string()
      anki_string << self.card_data.map { |card| card_data_to_string(card) }.compact.join("\n")
      create_file(anki_string, options[:file]) if options[:file]
      anki_string
    end

    private

    def card_header_to_string()
      "#" + self.card_headers.join(";") + "\n"
    end

    def card_data_to_string(card)
      raise ArgumentError, "card must be a hash" if !card.is_a?(Hash)

      card.default = ""

      self.card_headers.map{ |header| card[header] }.join(";")
    end

    def create_file(str, file)
      File.open(file, 'w') { |f| f.write(str) }
    end
  end
end
