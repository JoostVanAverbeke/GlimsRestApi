require 'api_response'

class Api::V1::PatientsController < Api::V1::BaseController

  before_action :set_limit, :set_sort_column, :set_sort_direction, :set_page

  def index
    puts "sort_column = #{@sort_column}, sort_direction = #{@sort_direction}"
    puts "page = #{@page}"
    if params[:query].blank?
      patients = Patient.order(@sort_column.to_sym => @sort_direction.to_sym)
    else
      patients = Patient.where("surname ILIKE ?", "%#{params[:query]}%").order(@sort_column.to_sym => @sort_direction.to_sym)
    end
    patients = patients.page(@page.to_i).per_page(@limit.to_i)
    the_response = ApiResponse.new(total_entries: patients.total_entries, data: patients)
# NEW    patient_collection = PatientCollection.new(patients, current_page: @page_to_i, total_items: patients.total_entries,
#                                               page_size: @limit.to_i)
# NEW respond_with patient_collection.to_json
    respond_with the_response.to_json
#    respond_with patients.to_json(only: [:surname, :first_name, :birth_date ])
  end

  def count
    respond_with Patient.count.to_json
  end

  private

  def set_limit
    @limit = params[:limit] || "10"
  end

  def set_sort_column
    @sort_column = params[:sort_column] ||= :surname
  end

  def set_sort_direction
    @sort_direction = params[:sort_direction] ||= :asc
  end

  def set_page
    @page = params[:page] ||= "1"
  end
end