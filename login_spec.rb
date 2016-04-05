require_relative 'spec_helper'

describe 'Login' do

  it 'succeeded' do
    @driver.get 'http://the-internet.herokuapp.com/login'
    @eyes.check_window('Login Page')
    @driver.find_element(id: 'username').send_keys('tomsmith')
    @driver.find_element(id: 'password').send_keys('SuperSecretPassword!')
    @driver.find_element(id: 'login').submit
    @eyes.check_window('Logged In')
  end

end
