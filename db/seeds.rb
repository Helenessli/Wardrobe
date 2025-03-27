Outfit.destroy_all

outfits_data = [
  { number: 1, theme: "summer", brand: "Lewkin", images: ["1.png"] },
  { number: 2, theme: "streetwear", brand: "Lewkin", images: ["2.png"] },
  { number: 3, theme: "streetwear", brand: "Lewkin", images: ["3.png"] },
  { number: 4, theme: "summer", brand: "Lewkin", images: ["4.png", "15.png"] }  # This outfit will have two images
]

outfits_data.each do |outfit_data|
  
  outfit = Outfit.create!(
    theme: outfit_data[:theme],
    brand: outfit_data[:brand]
  )
  
  # Attach images
  outfit_data[:images].each do |image_name|
    begin
      image_path = Rails.root.join('db', 'seed_images', image_name)
      
      if File.exist?(image_path)
        outfit.images.attach(
          io: File.open(image_path),
          filename: image_name,
          content_type: 'image/png'
        )
        puts "Successfully attached image #{image_name}"
      else
        puts "Warning: Image #{image_name} not found in seed_images directory"
      end
    rescue => e
      puts "Error attaching image #{image_name}: #{e.message}"
    end
  end
end
