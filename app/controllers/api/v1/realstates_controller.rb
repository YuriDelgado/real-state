class Api::V1::RealstatesController < ApplicationController
  before_action :set_realstate, only: %I[show update destroy]

  def index
    @realstates = Realstate.all
  end

  def create
    @realstate = Realstate.new(realstate_params)

    render json: { errors: @realstate.errors }, status: :unprocessable_entity \
      unless @realstate.save
  end

  def show
  end

  def update
    render json: { errors: @realstate.errors }, status: :unprocessable_entity \
      unless @realstate.update(realstate_params)
  end

  def destroy
    render json: { errors: @realstate.errors }, status: :unprocessable_entity \
      unless @realstate.destroy
  end

  private

  def set_realstate
    @realstate = Realstate.find(params[:id])
  end

  def realstate_params
    params.require(:real_state).permit(%I[id name category street external_number internal_number neighborhood city country rooms bathrooms comments])
  end
end
