require 'collection-json'

class PatientCollection
  def initialize(patients, page_info = {})
    @patients = patients
    @page_info = page_info
  end

  def to_json
    collection = CollectionJSON.generate_for('/patients/') do |builder|
        builder.set_version('1.0')
        builder.set_page_info(@page_info) unless @page_info.empty?
        @patients.each do |patient|
          builder.add_item("/patients/#{patient.id}") do |item|
            item.add_data "surname", value: patient.surname
            item.add_data "first-name", value: patient.first_name
            item.add_data "birth-date", value: patient.birth_date
          end
        end
        builder.add_query("/patients/search", "search", prompt: "Search") do |query|
          query.add_data "search"
        end
        builder.set_template do |template|
          template.add_data "surname", prompt: "Surname"
          template.add_data "first-name", prompt: "First name"
          template.add_data "birth-date", prompt: "Birth date"
        end
    end
    collection.to_json
  end

end