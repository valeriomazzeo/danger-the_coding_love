require File.expand_path('spec_helper', __dir__)

module Danger
  describe Danger::DangerTheCodingLove do
    it 'should be a plugin' do
      expect(Danger::DangerTheCodingLove.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @the_coding_love = @dangerfile.the_coding_love
      end

      it 'prints a random post' do
        post = @the_coding_love.random

        expect(post[0]).not_to be_empty
        expect(post[1]).not_to be_empty
        expect(@dangerfile.status_report[:markdowns]).not_to be_nil
      end

      it 'prints an image post' do
        post = @the_coding_love.atUrl('https://thecodinglove.com/ai-in-cars-is-getting-better')

        expect(post[0]).not_to be_empty
        expect(post[1]).not_to be_empty
        expect(File.extname(post[1]).strip.downcase).to eq '.jpg'
        expect(@dangerfile.status_report[:markdowns]).not_to be_nil
      end

      it 'prints a gif post' do
        post = @the_coding_love.atUrl('https://thecodinglove.com/when-i-commit-push-right-after-someone-has')

        expect(post[0]).not_to be_empty
        expect(post[1]).not_to be_empty
        expect(File.extname(post[1]).strip.downcase).to eq '.gif'
        expect(@dangerfile.status_report[:markdowns]).not_to be_nil
      end
    end
  end
end
