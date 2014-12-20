require "spec_helper"

RSpec.describe Anki::Deck do
  describe "#generate_deck" do
    subject { Anki::Deck.new }
    let(:cards) { [{ "a" => "b" }, { "c" => "d" }] }

    it "raises an ArgumentError if card_data is not an array" do
      subject.card_data = "I'm card_data!"

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if card_data is an empty array" do
      subject.card_data = []

      expect {
        subject.generate_deck
      }.to raise_error(ArgumentError)
    end

    it "returns a string with the card_data hashes, separating key and value with a semicolon and adding line breaks" do
      subject.card_data = cards
      expect(subject.generate_deck).to eq("a;b\nc;d")
    end

    it "saves to a file if the file option is passed" do
      subject.card_data = cards
      subject.generate_deck(file: "/tmp/anki_deck.txt")
      expect(File.exist?("/tmp/anki_deck.txt")).to be_truthy
    end

    it "returns a string including tags if the value of each card data is a hash" do
      subject.card_data = [{ "a" => { "value" => "b", "tags" => ["level1"] } },
                           { "c" => { "value" => "d", "tags" => ["level1", "level2"] } }]

      expect(subject.generate_deck).to match /a;b;level1/
      expect(subject.generate_deck).to match /c;d;level1 level2/
    end
  end
end
