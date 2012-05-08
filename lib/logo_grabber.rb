require 'open-uri'
require 'nokogiri'

class LogoGrabber
  def self.grab(url, options={}, callback=nil)
    @url = url.gsub('\/$', '')
    doc = Nokogiri::HTML(open(@url))
    parse(doc, options, callback)
  end


  def self.grab_from_doc(doc, options={}, callback=nil)
    @url ||= "" # for testing purposes and in case you're reading the doc from the file system (keeps things relative)
    images = doc.css('img').select { |img| contains_logo?(img) }
    images.map! { |img| make_absolute(img[:src]) }

    if options[:single]
      [images.first]
    else
      images
    end
  end

  private

  def self.contains_logo?(img)
    [img[:src], img[:alt], img[:title]].select do |attr|
      attr && attr.include?('logo')
    end.count > 0
  end

  def self.make_absolute(src)
    unless src.include?('//')
      # possibly add check for leading '/' on src if it causes problems'
      return @url + src
    end
    src
  end

end