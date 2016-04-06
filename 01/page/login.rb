class Login

  INPUT_USERNAME = { id: 'username' }
  INPUT_PASSWORD = { id: 'password' }
  SUBMIT_BUTTON  = { css: 'button'  }

  def initialize(driver, eyes)
    @driver = driver
    @eyes = eyes
    @driver.get 'http://the-internet.herokuapp.com/login'
    @eyes.check_window('Login Page')
  end

  def with(username, password)
    @driver.find_element(INPUT_USERNAME).send_keys(username)
    @driver.find_element(INPUT_PASSWORD).send_keys(password)
    @driver.find_element(SUBMIT_BUTTON).click
    @eyes.check_window('Logged In')
  end

end
