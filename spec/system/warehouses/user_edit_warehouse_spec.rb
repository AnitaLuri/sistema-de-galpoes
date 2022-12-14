require "rails_helper"

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    #Assert
    expect(page).to have_content('Editar Galpão')
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Área', with: '100000')
  end
  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    #Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão SP'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'CEP', with: '45000-000'
    click_on 'Atualizar Galpão'

    #Assert
    expect(page).to have_content ('Galpão atualizado com sucesso')
    expect(page).to have_content ('Nome: Galpão SP')
    expect(page).to have_content ('Endereço: Avenida do Aeroporto, 1000')
    expect(page).to have_content ('Cidade: São Paulo')
    expect(page).to have_content ('Área: 100000')
  end
  it 'e mantém os campos obrgatórios' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'test@example.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    click_on 'Atualizar Galpão'

    #Assert
    expect(page).to have_content ('Não foi possível atualizar o galpão')
  end
end