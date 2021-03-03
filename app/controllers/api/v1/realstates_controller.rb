class Api::V1::RealstatesController < ApplicationController
  before_action :set_realstate, only: %I[show update destroy]

  def index
    @realstates = Realstate.all
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_realstate
    @realstate = Realstate.find(params[:id])
  end
end
