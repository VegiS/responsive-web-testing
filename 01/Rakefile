require 'securerandom'

BROWSERS    = [ 'firefox',
                'chrome',
                'internet_explorer' ]

RESOLUTIONS = [ { width: '1274', height: '743' },
                { width: '1024', height: '768' },
                { width:  '800', height: '600' },
                { width:  '360', height: '640' } ]

BROWSERS.each do |browser|
  desc "Run tests in #{browser} on each viewport resolution we care about"
  task browser.to_sym, :browser_version, :operating_system do |t, args|

    ENV['batch_id']         = SecureRandom.uuid
    ENV['browser']          = browser
    ENV['browser_version']  = args[:browser_version]
    ENV['platform']         = args[:operating_system]

    threads = []
      RESOLUTIONS.each do |resolution|
        threads << Thread.new do
          ENV['viewport_width']   = resolution[:width]
          ENV['viewport_height']  = resolution[:height]
          system("bundle exec rspec")
        end
      end
    threads.each { |thread| thread.join }

  end
end

desc 'List resolutions'
task :resolution do
  RESOLUTIONS.each do |resolution|
    puts resolution[:width] + "x" + resolution[:height]
  end
end
