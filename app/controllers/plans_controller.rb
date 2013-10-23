class PlansController < ApplicationController
  def index
    if params[:zip_code]
      @plans = filtered_plans
      if @plans
        @levels = @plans.map {|p| [p.level, p.level_name] }.uniq.sort {|l| l.first }
      end
    end
  end

  private

  def filtered_plans
    plans = Plan.where(fips: Zip.where(code: params[:zip_code]).first.fips)
    plans.where(level: params[:level]) if params[:level]
    plans
  end
end
