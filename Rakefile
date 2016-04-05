desc 'Run tests against each screen resolution we care about'
task :run do
  RESOLUTIONS = [ { width: '1280', height: '743' },
                  { width: '1024', height: '768' },
                  { width:  '800', height: '600' },
                  { width:  '360', height: '640' } ]
  threads = []
  RESOLUTIONS.each do |resolution|
    threads << Thread.new do
      ENV['viewport_width']   = resolution[:width]
      ENV['viewport_height']  = resolution[:height]
      system("rspec login_spec.rb")
    end
  end
  threads.each { |thread| thread.join }
end
