class OutfitsController < ApplicationController
  def index
    @outfits = if params[:query].present?
      Outfit.joins(:items)
            .where("lower(items.brand) LIKE ? OR lower(items.name) LIKE ?", 
                  "%#{params[:query].downcase}%",
                  "%#{params[:query].downcase}%")
            .distinct
    elsif params[:theme].present?
      Outfit.where("lower(theme) = ?", params[:theme].downcase)
    else
      Outfit.all
    end
  end

  def show
    @outfit = Outfit.find(params[:id])
  end

  def new
    @outfit = Outfit.new
    @outfit.items.build  # Just build one item initially
  end

  def create
    @outfit = Outfit.new(outfit_params)
    @outfit.number = next_outfit_number
    
    if @outfit.save
      redirect_to @outfit
    end
  end

  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.images.purge
    @outfit.destroy
    redirect_to outfits_path, notice: 'Outfit was successfully deleted.'
  end

  def delete_image
    @outfit = Outfit.find(params[:id])
    image = @outfit.images.find(params[:image_id])
    image.purge
    redirect_to edit_outfit_path(@outfit), notice: 'Photo was successfully removed.'
  end

  def update
    @outfit = Outfit.find(params[:id])
    
    # Delete existing images and attach new ones if present
    if params[:outfit][:images].present?
      @outfit.images.purge
      @outfit.images.attach(params[:outfit][:images])
    end
    
    if @outfit.update(outfit_params.except(:images))
      redirect_to @outfit, notice: 'Outfit was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @outfit = Outfit.find(params[:id])
  end

  private

  def next_outfit_number
    (Outfit.maximum(:number) || 0) + 1
  end

  def outfit_params
    params.require(:outfit).permit(
      :theme,
      images: [],
      items_attributes: [:id, :name, :brand, :link]
    ).tap do |whitelisted|
      if whitelisted[:items_attributes]
        whitelisted[:items_attributes].reject! { |_, attrs| attrs[:name].blank? }
      end
    end
  end
end
