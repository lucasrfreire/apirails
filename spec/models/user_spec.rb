require 'rails_helper'

RSpec.describe User, type: :model do
  # Instaciando o usuario quando for solicitado... método Build é do FactoryGirl
  let(:user) { build(:user) }

  # É Esperado que ... método do Shoulda Matchers para fazer a validação rápida do campo
  it { is_expected.to validate_presence_of(:email)}
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it { is_expected.to validate_confirmation_of(:password)}
  it { is_expected.to allow_value("lucas@lucas.com.br").for(:email)}
  
end
