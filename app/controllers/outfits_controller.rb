class OutfitsController < ApplicationController
  def index
    @outfits = Outfit.all
  end

  def show
    @outfit = Outfit.find(params[:id])
  end

  def new
    @outfit = Outfit.new
    4.times { @outfit.items.build }
  end

  def create
    @outfit = Outfit.new(outfit_params)
    
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

  private

  def outfit_params
    # Add items_attributes to permitted params
    params.require(:outfit).permit(
      :theme, 
      :number, 
      images: [], 
      items_attributes: [:name, :brand, :link]
    )
  end
end
