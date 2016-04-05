#RESOLUTIONS = [ { width: '1000', height: '600' },  # iPad/Desktop
#                { width:  '414', height: '699' },  # iPhone 6+
#                { width:  '320', height: '568' } ] # iPhone 5

#RESOLUTIONS = [ { width: '1280', height: '743' } ]

RESOLUTIONS = [ { width: '1274', height: '743' },
                { width: '1024', height: '768' },
                { width:  '800', height: '600' },
                { width:  '360', height: '640' } ]


desc 'List resolutions'
task :res do
  RESOLUTIONS.each do |resolution|
    puts resolution[:width] + "x" + resolution[:height]
  end
end

BROWSERS    = [ 'firefox', 'chrome', 'internet_explorer' ]
BROWSERS.each do |browser|
  desc "Run tests in #{browser} on each viewport resolution we care about"
  task browser.to_sym, :browser_version, :operating_system do |t, args|

    # Set the browser details you want
    ENV['browser'] = browser
    ENV['browser_version']  = args[:browser_version]
    ENV['platform'] = args[:operating_system]

    # Run the suite of tests for each target viewport size in a separate thread
    threads = []
    RESOLUTIONS.each do |resolution|
      threads << Thread.new do
        ENV['viewport_width']   = resolution[:width]
        ENV['viewport_height']  = resolution[:height]
        system("rspec spec/dynamic_loading_spec.rb")
      end
    end
    threads.each { |thread| thread.join }
  end
end
