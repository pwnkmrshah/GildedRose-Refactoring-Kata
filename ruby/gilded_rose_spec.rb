require 'rspec'
require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.describe GildedRose do
  describe "#update_quality" do
    let(:aged_brie) { Item.new("Aged Brie", 5, 10) }
    let(:backstage_passes_15) { Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20) }
    let(:backstage_passes_10) { Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20) }
    let(:backstage_passes_5) { Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20) }
    let(:backstage_passes_0) { Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20) }
    let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 5, 80) }
    let(:conjured_item) { Item.new("Conjured Mana Cake", 5, 20) }
    let(:normal_item) { Item.new("Normal Item", 5, 20) }

    it "updates Aged Brie's quality correctly" do
      GildedRose.new([aged_brie]).update_quality
      expect(aged_brie.quality).to eq 11
    end

    it "ensures Aged Brie's quality does not exceed 50" do
      aged_brie_50 = Item.new("Aged Brie", 5, 50)
      GildedRose.new([aged_brie_50]).update_quality
      expect(aged_brie_50.quality).to eq 50
    end

    it "updates Backstage Passes' quality correctly when sell_in is more than 10 days" do
      GildedRose.new([backstage_passes_15]).update_quality
      expect(backstage_passes_15.quality).to eq 21
    end

    it "updates Backstage Passes' quality correctly when sell_in is 10 days" do
      GildedRose.new([backstage_passes_10]).update_quality
      expect(backstage_passes_10.quality).to eq 22
    end

    it "updates Backstage Passes' quality correctly when sell_in is 5 days" do
      GildedRose.new([backstage_passes_5]).update_quality
      expect(backstage_passes_5.quality).to eq 23
    end

    it "updates Backstage Passes' quality correctly when sell_in is 0 days" do
      GildedRose.new([backstage_passes_0]).update_quality
      expect(backstage_passes_0.quality).to eq 0
    end

    it "does not change Sulfuras' sell_in and quality" do
      GildedRose.new([sulfuras]).update_quality
      expect(sulfuras.sell_in).to eq 5
      expect(sulfuras.quality).to eq 80
    end

    it "updates Conjured item's quality correctly" do
      GildedRose.new([conjured_item]).update_quality
      expect(conjured_item.quality).to eq 18
    end

    it "ensures Conjured item's quality does not go negative" do
      conjured_item_0 = Item.new("Conjured Mana Cake", 5, 0)
      GildedRose.new([conjured_item_0]).update_quality
      expect(conjured_item_0.quality).to eq 0
    end

    it "updates Normal Item's quality correctly" do
      GildedRose.new([normal_item]).update_quality
      expect(normal_item.quality).to eq 19
    end

    it "ensures Normal Item's quality does not go negative" do
      normal_item_0 = Item.new("Normal Item", 5, 0)
      GildedRose.new([normal_item_0]).update_quality
      expect(normal_item_0.quality).to eq 0
    end

    it "updates all items' sell_in values correctly" do
      items = [aged_brie, backstage_passes_15, sulfuras, conjured_item, normal_item]
      GildedRose.new(items).update_quality
      expect(items.map(&:sell_in)).to eq [4, 14, 5, 4, 4]
    end
  end
end
