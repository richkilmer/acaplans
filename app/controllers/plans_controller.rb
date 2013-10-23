class PlansController < ApplicationController
  def index
    if params[:zip_code]
      @plans = filtered_plans
    end
  end

  private

  def filtered_plans
    plans = Plan.where(fips: Zip.where(code: params[:zip_code]).first)
    plans.where(level: params[:level]) if params[:level]
  end
end
