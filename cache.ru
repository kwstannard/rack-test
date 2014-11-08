class Cache < Struct.new(:app)
  def call(env)
    path = env.fetch("PATH_INFO")
    if resp = cache[path]
      puts 'using cache'
      resp
    else
      puts 'not using cache'
      cache[path] = app.call(env)
    end
  end

  def cache
    @cache ||= {}
  end
end

use Cache
run Proc.new{|env| sleep 5; ['200', {'Content-Type' => 'text/html'}, ["so slow"]]}
