class PlansController < ApplicationController
  def index
    if params[:zip_code]
      @plans = filtered_plans
    end
  end

  private

  def filtered_plans
    plans = Plans.where(fips: Zip.where(code: params[:zip_code]).first)
    plans.where(plan_type: params[:plan_type]) if params[:plan_type]
  end
end
