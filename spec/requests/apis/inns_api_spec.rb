require 'rails_helper'

describe 'Inns API' do
  context 'GET /api/v1/inns/search' do
    it 'lists details of a specific inn based on registration_number' do

      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                   document: '53783222001', email: 'joao@email.com', password: '123456')

      inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                            address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

                            
      inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

      get '/api/v1/inns/search?rn=30638898000199'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json = JSON.parse(response.body)
      expect(json['name']).to eq 'Pousada do Almeidinha'
      expect(json['registration_number']).to eq '30638898000199'
      expect(json['description']).to eq 'Um bom lugar'
      expect(json['full_address']).to eq 'Rua X, 100 - Centro - Manaus/AM'
      expect(json['qty_inn_rooms']).to eq 2
    end

    it 'fails if the inn registration number is not found' do
      get '/api/v1/inns/search?rn=30638898000199'

      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      json = JSON.parse(response.body)
      expect(json['status']).to eq 'Pousada não encontrada!'
    end
  end
end