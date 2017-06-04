require "nokogiri"
require "open-uri"

class Parse
  LANGUAGES = %w(Ruby Swift JavaScript Java)
  SOURCES = { "Ruby" => "https://github.com/github/rubocop-github/blob/master/STYLEGUIDE.md" }

  attr_reader :language, :rules

  def initialize(language="Ruby")
    @language = language
    @rules = []
    read_source
  end

  def read_source
    if LANGUAGES.include?(language)
      source = SOURCES.values_at(language).sample
      puts source
      scan(open(source).read)
    else
      puts "Unfortunately, we do not have any rules for #{language}.\nYou can get a rule for #{LANGUAGES.join(", ")}."
    end
  end

  def scan(tips)
    tips = tips.scan(%r{<p>(.*)</p>}).flatten

    tips.each { |tip| rules << tip.gsub(/<[^>]*>/, "") }
    puts rules.sample
  end
end

Parse.new
