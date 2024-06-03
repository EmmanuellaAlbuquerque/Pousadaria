require 'rails_helper'

describe 'Inns API' do
  context 'GET /api/v1/inn/1' do
    it 'lists details of a specific inn' do

      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                   document: '53783222001', email: 'joao@email.com', password: '123456')

      inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                            address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

      get '/api/v1/inn/1'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json = JSON.parse(response.body)
      expect(json['name']).to eq 'Pousada do Almeidinha'
      expect(json['registration_number']).to eq '30638898000199'
      expect(json['description']).to eq '30638898000199'
      expect(json['full_address']).to eq 'Rua X'
      expect(json['qty_inn']).to eq 1
    end
  end
end