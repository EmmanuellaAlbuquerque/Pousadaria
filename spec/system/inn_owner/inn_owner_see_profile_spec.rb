require 'rails_helper'

describe 'Inn owner see profile page' do
  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                  document: '53783222001', email: 'joao@email.com', password: '123456')

    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner

    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content 'Detalhes do Perfil do Dono da Pousada'
    expect(page).to have_content 'Nome Completo: Joao Almeida'
    expect(page).to have_content 'Seu E-mail: joao@email.com'
    expect(page).to have_content 'CPF: 53783222001'
  end
end