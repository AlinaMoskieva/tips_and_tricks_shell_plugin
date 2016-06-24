require 'open-uri'

class Parse
  def init
    url = Array.new
    #url.push('https://github.com/styleguide/ruby/documentation')
    #url.push('https://github.com/styleguide/ruby/exceptions')
    #url.push('https://github.com/styleguide/ruby/collections')
    #url.push('https://github.com/styleguide/ruby/coding-style')
    #url.push('https://github.com/styleguide/ruby/classes')
    #url.push('https://github.com/styleguide/ruby/hashes')
    #url.push('https://github.com/styleguide/ruby/keyword-arguments')
    url.push('https://github.com/styleguide/ruby/naming')
    url.push('https://github.com/styleguide/ruby/percent-literals')
    url.push('https://github.com/styleguide/ruby/regular-expressions')
    url.push('https://github.com/styleguide/ruby/requires')
    url.push('https://github.com/styleguide/ruby/strings')
    url.push('https://github.com/styleguide/ruby/syntax')
    random = Random.new
    html = open(url.slice(random.rand(0..url.length - 1)))
    @doc = html.read
    scan
  end
  def scan
    @tips = Array.new
    @trics = Array.new
    @tips = @doc.scan(%r{<p>(.*)})
   # puts @tips
    @tips.each do |tip|
      parse(tip) if tip.first.include?('<')
    end
    #puts @trics
    #puts @trics.length
    print
  end

  def parse(tip)
    index1 = tip.length.to_i - tip.reverse.index('>').to_i
    index2 = tip.length.to_i - tip.reverse.index('<').to_i - 2
    index2 = 0 if index2 < 0

    str = tip.slice(0..index2).to_s
    str.concat(tip.slice(index1..tip.length).to_s)
    if str.include?('<')
      @tip = str
      parse(@tip)
    else
      str.to_s.delete! ']'
      str.to_s.delete! '['
      str.delete! '\r'
      @trics << str.to_s.slice(1..(str.length - 2)) if str.length > 2 &&
          str.slice((str.length - 2).to_i ).eql?('.')
    end
  end

  def print
    random = Random.new
    puts @trics.slice( random.rand(0..@trics.length - 1) )
  end
end

parse = Parse.new
parse.init






