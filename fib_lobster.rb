class FibLobster < Struct.new(:app)
  def call(env)
    status, headers, lobster = app.call(env)

    goal_fib = env.fetch('PATH_INFO').gsub('/','').to_i
    fibs = []

    (0..goal_fib).each do |current_fib|
      if [0,1].include? current_fib
        fibs.push 1
      else
        fibs.push fibs[current_fib - 1] + fibs[current_fib - 2]
      end
      current_fib += 1
    end

    fib_lobster = [].tap {|fib_lobster|
      lobster.each {|p| fib_lobster.push p.gsub(/\S/, fibs.last.to_s) }
    }

    headers["Content-Length"] = fib_lobster.map(&:length).inject(&:+).to_s
    [status, headers, fib_lobster]
  end
end

