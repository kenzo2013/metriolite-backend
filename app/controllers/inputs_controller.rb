class InputsController < ApplicationController
  def index

  end

  def create
    @input = Input.create!(
      date: params[:date],
      value: params[:value],
      note: params[:note]
    )

    render :show
  end
end
