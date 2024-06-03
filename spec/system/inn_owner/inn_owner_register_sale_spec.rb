require 'rails_helper'

describe 'Inn owner register sale' do
  it 'from the dashboard' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
    document: '53783222001', email: 'joao@email.com', password: '123456')

    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Promoção'
    
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Data de Início'
    expect(page).to have_field 'Data de Fim'
    expect(page).to have_field 'Quarto'
    expect(page).to have_field 'Valor do desconto (em %)'
  end

  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
    document: '53783222001', email: 'joao@email.com', password: '123456')

    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
    address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Cadastrar Promoção'
    fill_in 'Nome', with: 'Promoção de Primavera'
    fill_in 'Data de Início', with: 1.day.from_now
    fill_in 'Data de Fim', with: 1.week.from_now
    select 'Quarto Térreo', from: 'Quarto'
    fill_in 'Valor do desconto (em %)', with: 50
    click_on 'Criar Promoção'

    within('section#sales') do
      expect(page).to have_content 'Promoções'
      expect(page).to have_content 'Promoção de Primavera'
      expect(page).to have_content "Válida de: #{I18n.l(1.day.from_now.to_date)} á #{I18n.l(1.day.from_now.to_date)}"
      expect(page).to have_content "Quarto: Quarto Térreo"
      expect(page).to have_content "Valor do desconto (em %): 50%"
    end
  end
end