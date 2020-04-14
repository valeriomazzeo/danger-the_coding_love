# frozen_string_literal: true

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
      text, image_url = at_url(random_post_url)

      markdown("------\n#{text}\n--\n![alt text](#{image_url} \"thecodinglove.com\")")

      [text, image_url]
    end

    # Returns url to random post from thecodinglove.com
    #
    # @return [url]
    #
    def random_post_url
      require 'open-uri'
      require 'nokogiri'
      @main_page_doc = Nokogiri::HTML(URI.open('https://thecodinglove.com'))
      random_love_page_url = @main_page_doc.at_xpath(
        "//ul[@class='navbar-nav mr-auto']/li/a/@href"
      ).to_s
      random_love_page_url
    end

    # Returns text and url containing given post from thecodinglove.com url
    #
    # @return  [text, image_url]
    #
    def at_url(love_page_url)
      raise 'Empty coding love page URL' if love_page_url.empty?

      @doc = Nokogiri::HTML(URI.parse(love_page_url).open)
      @doc = @doc.at_xpath("//div[@class='blog-post content-single']")

      text = @doc.at_xpath('//h1').text
      image_url = @doc.at_xpath("//div[@class='blog-post-content']/p/img/@src").to_s
      video_gif_url = @doc.at_xpath("//div[@class='blog-post-content']/p/video//object[@type='image/gif']/@data").to_s

      return [text, video_gif_url] if image_url.empty?

      [text, image_url]
    end

    def self.instance_name
      to_s.gsub('Danger', '').danger_underscore.split('/').last
    end
  end
end
