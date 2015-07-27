require 'rails_helper'
require 'collections/patient_collection'

describe PatientCollection do

  it 'generates a connection+json representation of the collection' do
    patient1 = Patient.new(id: 1, surname: 'Barack', first_name: 'Obama', birth_date: Date.new(1961, 8 , 4))
    patient2 = Patient.new(id: 2, surname: 'Hollande', first_name: 'Francois', birth_date: Date.new(1954, 8 , 12))
    patients = [patient1, patient2]
    collection = PatientCollection.new(patients)
    puts collection.to_json

    collection2 = PatientCollection.new(patients, current_page: 1, total_items: 2, total_records: 100, page_size: 2)
    puts collection2.to_json
  end
end