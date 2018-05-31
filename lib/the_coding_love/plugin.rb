module Danger
  # Prints markdown containing a random post from
  # [thecodinglove.com](http://thecodinglove.com)
  #
  # @example Prints markdown containing a random post
  #
  #          the_coding_love.random
  #
  # @see  valeriomazzeo/danger-the_coding_love
  # @tags thecodinglove.com, coding, love, random, gif
  #
  class DangerTheCodingLove < Plugin
    # Prints markdown containing a random post from thecodinglove.com
    #
    # @return  [text, image_url]
    #
    def random
      require 'open-uri'
      require 'nokogiri'

      @main_page_doc = Nokogiri::HTML(open("https://thecodinglove.com"))
      random_gif_page_url = @main_page_doc.at_xpath("//a[@class='nav-link']/@href").to_s
      
      @doc = Nokogiri::HTML(open(random_gif_page_url))
      @doc = @doc.at_xpath("//div[@class='blog-post']")

      text = @doc.at_xpath("//h1").text
      image_url = @doc.at_xpath("//div[@class='blog-post-content']/p/img/@src").to_s

      markdown("------\n#{text}\n--\n![alt text](#{image_url} \"thecodinglove.com\")")

      return text, image_url
    end

    def self.instance_name
      to_s.gsub("Danger", "").danger_underscore.split("/").last
    end
  end
end
