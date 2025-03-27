class OutfitsController < ApplicationController
  def index
    @outfits = Outfit.all
  end

  def show
    @outfit = Outfit.find(params[:id])
  end

  def new
    @outfit = Outfit.new
  end

  def create
    @outfit = Outfit.new(outfit_params)
    
    if @outfit.save
      redirect_to @outfit, notice: 'Outfit was successfully created.'
    end
  end

  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.image.purge # removes the attached image from storage
    @outfit.destroy
    redirect_to outfits_path, notice: 'Outfit was successfully deleted.'
  end

  private

  def outfit_params
    params.require(:outfit).permit(:theme, :brand, images: [])
  end
end
