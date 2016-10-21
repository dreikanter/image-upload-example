class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    @image = Image.create!(form_params)
  end

  def destroy
    @image = Image.destroy(id)
  end

  private

  def form_params
    params.require(:image).permit!
  end

  def id
    params.fetch(:id)
  end
end
