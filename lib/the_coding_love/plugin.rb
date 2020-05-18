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
      rnd_url = 'https://thecodinglove.com/random'
      text, image_url = at_url(rnd_url)

      markdown(
        "------\n"\
        "#{text}\n"\
        "--\n"\
        "![Funny image](#{image_url})\n"\
        "--\n"\
        "*Source: [The Coding Love](#{rnd_url})*"
      )
      [text, image_url]
    end

    # Returns text and url containing given post from thecodinglove.com url
    #
    # @return  [text, image_url]
    #
    def at_url(love_page_url)
      require 'open-uri'
      require 'nokogiri'

      raise 'Empty coding love page URL' if love_page_url.empty?

      @doc = Nokogiri::HTML(URI.parse(love_page_url).open)
      @article = @doc.at_xpath("//article[@class='blog-post content-single']")

      text = @article.at_xpath('//h1').text
      image_url = @article.at_xpath("//div[@class='blog-post-content']/p/img/@data-src").to_s
      video_gif_url = @article.at_xpath("//div[@class='blog-post-content']/p/video//object[@type='image/gif']/@data").to_s

      return [text, video_gif_url] if image_url.empty?

      [text, image_url]
    end

    def self.instance_name
      to_s.gsub('Danger', '').danger_underscore.split('/').last
    end
  end
end
