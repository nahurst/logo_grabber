require 'open-uri'
require 'nokogiri'
require 'css_parser'

class LogoGrabber
  def self.grab(url, options={}, callback=nil)
    @url = url
    doc = Nokogiri::HTML(open(@url))
    grab_from_doc(doc, options, callback)
  end

  def self.grab_from_doc(doc, options={}, callback=nil)
    @url ||= "http://example.com"
    images = doc.css('img').select { |img| contains_logo?(img) }
    images.map! { |img| make_absolute(@url, img[:src]) }

    sheets = doc.css('link[type="text/css"]').map {|sheet| sheet[:href]}
    parser = CssParser::Parser.new
    background_urls = Array.new
    sheets.each do |sheet|
      parser.load_uri!(sheet)
      parser.each_selector do |selector, declarations, specificity|
        if declarations.include?("background-image: url") || declarations.include?("background: url")
          background_urls << declarations.scan(/url\(['"]?([^\)'"]*)[\)'"]/)
        end
      end
      background_urls = background_urls.select {|url| contains_logo?(url) }
      background_urls.map! {|url| make_absolute(sheet, url) }
      images.concat(background_urls)
    end

    if options[:single]
      [images.first]
    else
      images
    end
  end

  private

  def self.tag_contains_logo?(img)
    [img[:src], img[:alt], img[:title]].select do |attr|
      contains_logo?(attr)
    end.count > 0
  end

  def self.contains_logo?(str)
    str && str.to_s.downcase.include?('logo')
  end

  def self.make_absolute(base, path)
    path.include?('//') ? path : URI.join(base.to_s, path.to_s).to_s
  end

end