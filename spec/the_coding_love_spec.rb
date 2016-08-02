require File.expand_path('../spec_helper', __FILE__)

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

      it "prints a random post" do
        post = @the_coding_love.random

        expect(post[0]).not_to be_nil
        expect(post[1]).not_to be_nil
        expect(@dangerfile.status_report[:markdowns]).not_to be_nil
      end
    end
  end
end
