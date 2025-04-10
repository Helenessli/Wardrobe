OutfitItem.destroy_all
Outfit.destroy_all     
Item.destroy_all

outfits_data = [
  { number: 1, theme: "summer", images: ["1.png"] },
  { number: 2, theme: "streetwear", images: ["2.png"] },
  { number: 3, theme: "streetwear", images: ["3.png"] },
  { number: 4, theme: "summer", images: ["4.png", "13.png", "14.png", "15.png", "16.png"] },
  { number: 5, theme: "party_and_event", images: ["5.png"] },
  { number: 6, theme: "summer", images: ["6.png"] },
  { number: 7, theme: "streetwear", images: ["7.png"] },
  { number: 8, theme: "party_and_event", images: ["8.png"] },
  { number: 9, theme: "party_and_event", images: ["9.png"] },
  { number: 10, theme: "party_and_event", images: ["10.png"] },
  { number: 11, theme: "party_and_event", images: ["11.png", "12.png"] },
]

outfits_data.each do |outfit_data|
  
  outfit = Outfit.create!(
    theme: outfit_data[:theme],
    number: outfit_data[:number]
  )
  
  outfit_data[:images].each do |image_name|
    begin
      image_path = Rails.root.join('db', 'seed_images', image_name)
      
      if File.exist?(image_path)
        outfit.images.attach(
          io: File.open(image_path),
          filename: image_name,
          content_type: 'image/png'
        )
      end
    end
  end
end

items_data = [
  { number: 1, brand: "Lewkin", name: "Layered Long-Sleeve Crop Tank Top", link: "https://ca.lewkin.com/collections/bestsellers/products/layered-long-sleeve-crop-tank-top-set-cm513" },
  { number: 2, brand: "Lewkin", name: "Lace Shirred Handkerchief Mini Skirt", link: "https://ca.lewkin.com/products/lace-shirred-handkerchief-mini-skirt-cm513" },
  { number: 3, brand: "Lewkin", name: "dress test", link: "https://ca.lewkin.com/products/lace-shirred-handkerchief-mini-skirt-cm513" },
  { number: 4, brand: "Lewkin", name: "dress test 2", link: "https://ca.lewkin.com/products/lace-shirred-handkerchief-mini-skirt-cm513" },
]

items_data.each do |item_data|
  Item.create!(item_data)
end

# Define associations in an array: [outfit_number, [item_numbers]]
outfit_item_associations = [
  [4, [1, 2]],  # Outfit 4 gets items 1 and 2
  [1, [3]],     # Outfit 1 gets item 3
  [2, [4]]      # Outfit 2 gets item 4
]

outfit_item_associations.each do |outfit_number, item_numbers|
  outfit = Outfit.find_by(number: outfit_number)
  item_numbers.each do |item_number|
    OutfitItem.create!(
      outfit: outfit,
      item: Item.find_by(number: item_number)
    )
  end
end
