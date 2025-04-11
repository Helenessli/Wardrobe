require "test_helper"

class OutfitTest < ActiveSupport::TestCase
  test "should create outfit with valid attributes" do
    outfit = Outfit.new(theme: "summer", number: 1)
    assert outfit.valid?
  end

  test "should not create outfit without number" do
    outfit = Outfit.new(theme: "summer")
    assert_not outfit.valid?
  end

  test "should create outfit with items" do
    outfit = Outfit.new(
      theme: "summer",
      number: 1,
      items_attributes: [
        { name: "Summer Top", brand: "Lewkin" },
        { name: "Summer Skirt", brand: "Lewkin" }
      ]
    )
    assert outfit.valid?
    assert_equal 2, outfit.items.size
  end
end
