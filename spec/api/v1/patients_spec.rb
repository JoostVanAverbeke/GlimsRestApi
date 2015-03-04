require "rails_helper"

xdescribe 'api/v1/patients', :type => :api do
  let(:user) { create_user! }
  let(:token) { user.authentication_token }
  context 'requests patients' do
    before do
      Patient.destroy_all
      patient_bart_simpson = FactoryGirl.create(:bart_simpson_contact, user: user)
      patient_bart_simpson2 = FactoryGirl.create(:bart_simpson_contact, user: user)
      patient_homer_simpson = FactoryGirl.create(:homer_simpson_contact, user: user)
      @patient_marge_bouvier = FactoryGirl.create(:marge_bouvier_as_spock_patient_contact, user: user)
      patient_marge_bouvier2 = FactoryGirl.create(:marge_bouvier_as_spock_patient_contact, user: user)
    end

    let(:url) { '/api/v1/patients' }

    it 'json query without name query parameter' do
      get "#{url}.json", :token => token
      patients_json = Patient.all.order_by_surname.to_json(:only => [:id], :methods => [:externalize, :referral_count])
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(patients_json)
      patients = JSON.parse(last_response.body)
      expect(patients.length).to eq(5)
    end

    it 'json query with name query parameter' do
      search_criteria = 'Simps/B'
      get "#{url}.json", :token => token, :q => search_criteria
      patients_json = Patient.find_by_name(search_criteria).to_json(:only => [:id], :methods => [:externalize, :referral_count])
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(patients_json)
      patients = JSON.parse(last_response.body)
      expect(patients.length).to eq(2)
    end

    it 'json query with name query parameter taking into account a specified limit' do
      search_criteria = 'Simps/B'
      get "#{url}.json", :token => token, :q => search_criteria, :limit => 1
      patients_json = Patient.find_by_name(search_criteria, 1).to_json(:only => [:id], :methods => [:externalize, :referral_count])
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(patients_json)
      patients = JSON.parse(last_response.body)
      expect(patients.length).to eq(1)
    end

    it 'json query with name query parameter for a specified dentist' do
      spock_dentist =  @patient_marge_bouvier.contactable.personable.dentist
      expect(spock_dentist).not_to be_nil
      get "#{url}.json", :token => token, :dentist_id => spock_dentist.id
#      patients_json = Patient.find_by_name(search_criteria).to_json(:only => [:id], :methods => [:externalize])
      expect(last_response.status).to eq(200)
#      expect(last_response.body).to eq(patients_json)
      patients = JSON.parse(last_response.body)
      expect(patients.length).to eq(1)
    end
  end
  
  
end