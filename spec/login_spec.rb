require_relative 'spec_helper'
require_relative '../page/login'

describe 'Login' do

  before(:each) do
    @login = Login.new(@driver, @eyes)
  end

  it 'with valid credentials' do
    @login.with('tomsmith', 'SuperSecretPassword!')
  end

  it 'with invalid credentials' do
    @login.with('tomsmith', 'bad password')
  end

end
