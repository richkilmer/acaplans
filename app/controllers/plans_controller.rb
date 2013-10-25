class PlansController < ApplicationController

  before_filter :zip

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
    plans = plans_for_zip
    plans = plans.where(level: level) if level
    plans
  end

  def levels_for(plans)
    plans_for_zip.map {|p| [p.level_name, p.level] }.
          uniq.
          sort { |a, b| a.last <=> b.last }.
          unshift ["All Plans", '-1']
  end

  def level
    @level ||= begin
      params[:level] == "-1" ? nil : params[:level]
    end
  end

  def plans_for_zip
    Plan.where(fips: Zip.where(code: params[:zip_code]).first.fips)
  end
end
