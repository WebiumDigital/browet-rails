require "spec_helper"

RSpec.describe Browet::Group do
  include EntityHelpers

  context "when invalid config" do
    it "raise empty account error" do
      Browet::Config.account = ''
      Browet::Config.key = ''
      expect { Browet::Group.list }.to raise_error(Browet::ConfigError)
    end

    it "raise empty key error" do
      Browet::Config.account = 'account'
      Browet::Config.key = ''
      expect { Browet::Group.list }.to raise_error(Browet::ConfigError)
    end
  end

  context "when correct config" do
    before(:context) do
      config_init
    end

    it "has correct url" do
      expect(Browet::Config.api_url).to eq('http://account.browet.com/api/v1')
    end
  end

  context "when invalid account" do
    before(:context) do
      config_init
      init_invalid_account
    end

    it "raise http error" do
      expect { Browet::Group.list }.to raise_error(Browet::HttpError)
    end
  end
end
