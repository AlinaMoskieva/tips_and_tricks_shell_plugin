require 'open-uri'

class Parse
  def select_language(lang)
    @language = lang
    init
    start(@language)
  end

  def init
    @url = Hash.new
    @languages = Array.new
    @languages.push('Ruby')
    @languages.push('Swift')
    @languages.push('JavaScript')
    @languages.push('Java')
    @languages.push('Git')

    @url.store('https://github.com/styleguide/ruby/exceptions', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/collections', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/coding-style', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/classes', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/hashes', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/keyword-arguments', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/naming', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/percent-literals', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/regular-expressions', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/requires', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/strings', 'Ruby')
    @url.store('https://github.com/styleguide/ruby/syntax', 'Ruby')
    @url.store('https://github.com/raywenderlich/swift-style-guide','Swift')
    @url.store('https://github.com/airbnb/javascript', 'JavaScript')
    @url.store('https://github.com/twitter/commons/blob/master/src/java/com/twitter/common/styleguide.md', 'Java')
    @url.store('https://github.com/agis-/git-style-guide', 'Git')
  end

  def start(language)
    @current_language = @language.slice(0..((@language.length)-1))

    if @languages.include?(@current_language)
      random = Random.new
      array = Array.new
      hash = @url.select {|k,v| v == @current_language }
      array =  hash.keys
      html = open(array.slice(rand(0..((array.length) - 1).to_i)))
      @doc = html.read
      scan
    else
      handler
    end
  end

  def handler
    puts "#{@language} is wrong."
    puts "Maybe you  are mean?"
    count = 0
    @languages.each do |lan|
      if lan.index(@current_language.slice(0)) == 0
        puts lan
        count += 1
      end
    end
   puts @languages if count == 0
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
parse.select_language('Ruby')
