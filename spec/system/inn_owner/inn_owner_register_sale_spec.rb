require 'rails_helper'

describe 'Inn owner register sale' do
  it 'and see register page' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
    document: '53783222001', email: 'joao@email.com', password: '123456')
    
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)
    
    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Criar Promoção'

    expect(page).to have_field('Nome')
    expect(page).to have_field('Data de início')
    expect(page).to have_field('Data de fim')
    expect(page).to have_field('Valor do desconto (em %)')
  end

  it 'successfylly' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
    document: '53783222001', email: 'joao@email.com', password: '123456')
    
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    varanda = inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
    inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)
    
    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Criar Promoção'
    fill_in 'Nome', with: 'Promoção de Feriado'
    fill_in 'Data de início', with: 2.days.from_now
    fill_in 'Data de fim', with: 1.week.from_now
    fill_in 'Valor do desconto (em %)', with: 20
    select varanda.name, from: 'Quarto'
    
    click_on 'Criar Promoção'

    expect(page).to have_content 'Promoções'
    expect(page).to have_content 'Promoção de Feriado'
    expect(page).to have_content "Data de início #{2.days.from_now}"
    expect(page).to have_content "Data de fim #{1.week.from_now}"
    expect(page).to have_content "Valor do desconto (em %): 20"
    expect(page).to have_content "Quarto: Quarto com Varanda"
  end
end