class DynamicLoading

  START_BUTTON  = { css: '#start button'  }
  LOADING_BAR   = { id: 'loading'         }
  FINISH_TEXT   = { id: 'finish'          }

  def initialize(driver, eyes)
    @driver = driver
    @eyes = eyes
  end

  def load_example(example_number)
    @driver.get("http://the-internet.herokuapp.com/dynamic_loading/#{example_number}")
    @eyes.check_window('Page loaded')
    @driver.find_element(START_BUTTON).click
    sleep 0.500
    @eyes.check_window('Loading bar appears')
    wait = Selenium::WebDriver::Wait.new(timeout: 5)
    wait.until { @driver.find_element(FINISH_TEXT).displayed? }
    @eyes.check_window('Finish text appears')
  end

end
