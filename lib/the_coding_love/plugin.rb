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
    # @return  [void]
    #
    def random
        @doc = Nokogiri::HTML(open("http://thecodinglove.com/random"))
        @doc = @doc.at_xpath("//div[@id='post1']")

        text = @doc.at_xpath("//div/h3").text
        image_url = @doc.at_xpath("//div[@class='bodytype']/p/img/@src").to_s

        markdown("------\n#{text}\n--\n![alt text](#{image_url} \"thecodinglove.com\")")
    end

    def self.instance_name
        to_s.gsub("Danger", "").danger_underscore.split("/").last
    end
  end
end
