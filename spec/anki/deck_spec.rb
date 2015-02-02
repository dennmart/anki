require "spec_helper"

RSpec.describe Anki::Deck do
  describe "#generate_deck" do
    subject { Anki::Deck.new }
    let(:headers) { ["front", "back"] }
    let(:cards) {
      [
        { "front" => "a", "back" => "b" },
        { "front" => "c", "back" => "d" }
      ]
    }

    it "raises an ArgumentError if card_header is not an array" do
      subject.card_headers = "I'm card_header!"

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError, "card_headers must be an array")
    end

    it "raises an ArgumentError if card_header is an empty array" do
      subject.card_headers = []

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError, "card_headers must not be empty")
    end

    it "raises an ArgumentError if card_data is not a array" do
      subject.card_headers = headers
      subject.card_data = "I'm card_data!"

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError, "card_data must be an array")
    end

    it "raises an ArgumentError if card_data is an empty array" do
      subject.card_headers = headers
      subject.card_data = []

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError, "card_data must not be empty")
    end

    it "raise an ArgumentError if card values are not hashes" do
      subject.card_headers = headers
      subject.card_data = [ "I'm card data!" ]

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError, "card must be a hash")
    end

    it "returns a string with the card_headers comment, card_data values separated with a semicolon and new cards by line breaks" do
      subject.card_headers = headers
      subject.card_data = cards
      expect(subject.generate_deck).to eq("#front;back\na;b\nc;d")
    end

    it "saves to a file if the file option is passed" do
      subject.card_headers = headers
      subject.card_data = cards
      subject.generate_deck(file: "/tmp/anki_deck.txt")
      expect(File.exist?("/tmp/anki_deck.txt")).to be_truthy
    end

  end
end
