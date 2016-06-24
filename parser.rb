require 'open-uri'
require 'nokogiri'

class Parse
  def init
    url = 'https://github.com/bbatsov/ruby-style-guide/blob/master/README.md'
    html = open(url)
    @doc = html.read
    scan
  end
  def scan
    @tips = Array.new
    @trics = Array.new
    @tips = @doc.scan(%r{<p>(.*)})
    @tips.each do |tip|
      parse(tip) if tip.first.include?('<')
    end
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
      @trics << str.to_s.slice(1..(str.length - 2)) if str.length > 2
    end
  end

  def print
    random = Random.new
    puts @trics.slice( random.rand(0..@trics.length - 1) )
  end
end

parse = Parse.new
parse.init
