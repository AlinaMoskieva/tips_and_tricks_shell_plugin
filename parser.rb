require 'open-uri'
require 'nokogiri'

class Parse
  def init
    puts "hello"
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
    puts @trics
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
      @trics << str.to_s if str.length > 7
    end
  end
end

parse = Parse.new
parse.init
