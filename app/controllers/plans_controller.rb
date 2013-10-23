class PlansController < ApplicationController
  def index
    if params[:zip_code] && zip
      @plans = filtered_plans
      if @plans
        @levels = levels_for(@plans)
      end
    end
  end

  private

  def zip
    @zip ||= Zip.where(code: params[:zip_code]).first
  end

  def filtered_plans
    plans = Plan.where(fips: zip.fips)
    plans.where(level: params[:level]) if params[:level]
    plans
  end

  def levels_for(plans)
    plans.map {|p| [p.level_name, p.level] }.
          uniq.
          sort { |l| l.last }.
          reverse!
  end
end
