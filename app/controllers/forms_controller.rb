class FormsController < ApplicationController

  before_action :set_form, only: [:show, :update, :destroy]

  def show

  end

  def create
    params[:tags] = eval(params[:tags])
    @form = Form.new(form_params)
    if @form.save
      @form.tags.each do |tag|
        @form.inputs.create(date: tag[:date], value: tag[:value], note: tag[:note])
      end
      render :show
    else
      @error = { message: "Validation failed", errors: @form.errors.full_messages }
      render :error, status: 400
    end
  end

  def update
    params[:tags] = eval(params[:tags])
    if @form.update(form_params)
      @form.tags.each do |tag|
        @form.inputs.update(date: tag[:date], value: tag[:value], note: tag[:note])
      end
      render :show
    else
      @error = { message: "Validation failed", errors: @form.errors.full_messages }
      render :error, status: 400
    end
  end

  def destroy
    if @form.destroy
      @notice = { message: "Form was destroyed successfully" }
      render :notice
    end
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def form_params
    params.permit(:key, :name, tags: [:date, :value, :note])
  end

end
