require 'rails_helper'
require 'patient_collection'

describe PatientCollection do

  it 'generates a collection+json representation of the collection' do
    patient1 = Patient.new(id: 1, surname: 'Barack', first_name: 'Obama', birth_date: Date.new(1961, 8 , 4))
    patient2 = Patient.new(id: 2, surname: 'Hollande', first_name: 'Francois', birth_date: Date.new(1954, 8 , 12))
    patients = [patient1, patient2]
    collection = PatientCollection.new(patients, current_page: 1, total_items: 2, total_records: 1000, page_size: 10)
    puts collection.to_json

  end
end