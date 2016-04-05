require 'selenium-webdriver'
require 'eyes_selenium'

ENV['browser']          ||= 'internet_explorer'
ENV['browser_version']  ||= '9'
ENV['platform']         ||= 'Windows 7'
ENV['viewport_width']   ||= '1024'
ENV['viewport_height']  ||= '768'

RSpec.configure do |config|

  config.before(:each) do |example|
    caps                      = Selenium::WebDriver::Remote::Capabilities.send(
                                  ENV['browser'])
    caps.version              = ENV['browser_version']
    caps.platform             = ENV['platform']
    caps[:name]               = example.metadata[:full_description]
    caps['screen-resolution'] = '1280x1024'
    @browser                  = Selenium::WebDriver.for(
      :remote,
      url: "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub",
      desired_capabilities: caps)
    @eyes                     = Applitools::Eyes.new
    @eyes.api_key             = ENV['APPLITOOLS_API_KEY']
    @driver                   = @eyes.open(
      app_name:       'the-internet',
      test_name:      example.metadata[:full_description],
      viewport_size:  { width: ENV['viewport_width'].to_i,
                        height: ENV['viewport_height'].to_i },
      driver:         @browser)
  end

  config.after(:each) do
    @eyes.close
    @browser.quit
  end

end
