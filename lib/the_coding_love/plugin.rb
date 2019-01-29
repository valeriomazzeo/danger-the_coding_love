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

      @main_page_doc = Nokogiri::HTML(open('https://thecodinglove.com'))
      random_love_page_url = @main_page_doc.at_xpath("//a[@class='nav-link']/@href").to_s

      text, image_url = atUrl(random_love_page_url)

      markdown("------\n#{text}\n--\n![alt text](#{image_url} \"thecodinglove.com\")")

      [text, image_url]
    end

    # Returns text and url containing given post from thecodinglove.com url
    #
    # @return  [text, image_url]
    #
    def atUrl(love_page_url)
      @doc = Nokogiri::HTML(open(love_page_url))
      @doc = @doc.at_xpath("//div[@class='blog-post']")

      text = @doc.at_xpath('//h1').text
      image_url = @doc.at_xpath("//div[@class='blog-post-content']/p/img/@src").to_s
      video_gif_url = @doc.at_xpath("//div[@class='blog-post-content']/p/video//object[@type='image/gif']/@data").to_s

      if image_url.empty?
        return [text, video_gif_url]
      else
        return [text, image_url]
      end
    end

    def self.instance_name
      to_s.gsub('Danger', '').danger_underscore.split('/').last
    end
  end
end
