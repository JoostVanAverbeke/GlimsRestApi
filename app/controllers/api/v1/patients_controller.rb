class Api::V1::PatientsController < Api::V1::BaseController

  before_action :set_limit, :set_sort_column, :set_sort_direction

  def index
    puts "sort_column = #{@sort_column}, sort_direction = #{@sort_direction}"
    if params[:q].blank?
      @patients = Patient.order(@sort_column.to_sym => @sort_direction.to_sym)
    else
      @patients = Patient.where("surname ILIKE ?", "%#{params[:q]}%").order(@sort_column.to_sym => @sort_direction.to_sym)
    end
    @patients = (@limit) ? @patients.limit(@limit) : @patients
    respond_with @patients.to_json(only: [:surname, :first_name, :birth_date ])
  end

  def count
    respond_with Patient.count.to_json
  end

  private

  def set_limit
    @limit = params[:limit]
  end

  def set_sort_column
    @sort_column = params[:sort_column] ||= :surname
  end

  def set_sort_direction
    @sort_direction = params[:sort_direction] ||= :asc
  end
end