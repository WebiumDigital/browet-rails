require "spec_helper"

RSpec.describe Browet::Repository do
  include EntityHelpers

  context "when correct config" do
    before(:context) do
      config_init
      Browet::Cache.establish_connection(
        :adapter  => "postgresql",
        :host     => "localhost",
        :username => "browet",
        :password => "browet",
        :database => "browet"
      )
    end

    context "when empty cache" do
      # before(:context) do
      #   @cache = mock(Browet::Cache)
      #   @cahce.stub!(:get).with("product").and_return(nil)
      # end

      it "shoud make http request and refresh cache" do
        cache = Browet::Cache
        expect(cache.all.length).to eq(0)
      end
    end

    context "when nonempty cache" do

      context "when nondirty cahce" do
        it "should not make http request and return result from cache" do
        end
      end

      context "when dirty cahce" do

        context "when success server reply" do
          it "shoud make http request and refresh cache" do
          end
        end

        context "when server reply timeout" do
          it "shoud make http request and return result from cache" do
          end
        end

      end

    end

  end
end
