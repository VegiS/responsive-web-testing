require 'selenium-webdriver'
require 'eyes_selenium'
require_relative '../lib/batch_info'

RSpec.configure do |config|

  config.before(:suite) do
    Thread.current[:batch] = Applitools::Base::BatchInfo.new('Responsive Web Batch')
    Thread.current[:batch].set_id(ENV['batch_id'])
  end

  config.before(:each) do |example|
    test_name                 = example.metadata[:full_description]

    # Set Capabilities for Selenium/Appium on Sauce Labs
    caps                      = Selenium::WebDriver::Remote::Capabilities.send(ENV['browser'])
    caps['screenResolution']  = '1280x1024'
    caps[:name]               = test_name

    case ENV['browser']
    when 'android'
      caps['appiumVersion']     = '1.5.1'
      caps['deviceName']        = 'Google Nexus 7 HD Emulator'
      caps['deviceOrientation'] = 'portrait'
      caps['browserName']       = 'Browser'
      caps['platformVersion']   = '4.4'
      caps['platformName']      = 'Android'
    when 'iphone'
      caps['appiumVersion']     = '1.5.1'
      caps['deviceName']        = 'iPhone 6'
      caps['deviceOrientation'] = 'portrait'
      caps['platformVersion']   = '9.2'
      caps['platformName']      = 'iOS'
      caps['browserName']       = 'Safari'
    else
      caps.version              = ENV['browser_version']
      caps.platform             = ENV['platform']
    end


    # Get a browser from Sauce Labs
    @browser                  = Selenium::WebDriver.for(
      :remote,
      url: "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub",
      desired_capabilities: caps)

    # Connect to Appltools for Visual Comparison
    @eyes                     = Applitools::Eyes.new
    @eyes.api_key             = ENV['APPLITOOLS_API_KEY']
    @eyes.batch               = Thread.current[:batch]
    @eyes.baseline_name       = test_name + ENV['viewport_width'] + "x" + ENV['viewport_height']
    @eyes.match_level         = Applitools::Eyes::MATCH_LEVEL[:layout2]
    case ENV['browser']
    when 'iphone', 'android'
      @driver                 = @eyes.open(
                                  app_name:       'the-internet',
                                  test_name:      test_name,
                                  driver:         @browser)
    else
      @driver                 = @eyes.open(
                                  app_name:       'the-internet',
                                  test_name:      test_name,
                                  viewport_size:  {   width: ENV['viewport_width'].to_i,
                                                     height: ENV['viewport_height'].to_i  },
                                  driver:         @browser)
    end
  end

  config.after(:each) do |example|
    begin
      @eyes.close
    ensure
      @browser.quit
    end
  end

end
