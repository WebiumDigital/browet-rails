require "spec_helper"

RSpec.describe Browet::Repository do
  include EntityHelpers

  context "when correct config" do
    before(:example) do
      config_init true
      product_init
    end

    context "when empty cache" do
      before(:example) do
        Browet::Cache.delete_all
      end

      it "shoud make http request and refresh cache" do
        expect(Browet::Cache.all.length).to eq(0)
        
        product = Browet::Product.get(1)
        expect(@stub_product1).to have_been_requested
        should_be_product_1 product

        expect(Browet::Cache.all.length).to eq(1)
        cache_record = Browet::Cache.get('products/1')
        expect(cache_record).to be_a(Browet::Cache)
        expect(cache_record.path).to eq('products/1')
        expect(cache_record.params).to eq({})
        expect(cache_record.json).to eq(json_string('product1'))
      end

      context "when server reply timeout" do
        it "shoud make http request and return result from cache" do
          expect(Browet::Cache.all.length).to eq(0)
          WebMock.reset!
          WebMock.stub_request(:any, Browet::Config.api_url + "/products/1").
            with(:query => {"token" => Browet::Config.key}).to_timeout
          expect { Browet::Product.get(1) }.to raise_error(Timeout::Error)
        end
      end
    end

    context "when nonempty cache" do

      context "when nondirty cahce" do
        before(:example) do
          Browet::Cache.delete_all
          Browet::Cache.create(path: 'products/1', params: {}, json:json_string('product1'), updated_at: Time.now - 3600) # fill in cache
        end

        it "should not make http request and return result from cache" do
          expect(Browet::Cache.all.length).to eq(1)
          product = Browet::Product.get(1)
          expect(@stub_product1).not_to have_been_requested
          should_be_product_1 product
        end
      end

      context "when dirty cahce" do
        before(:example) do
          Browet::Cache.delete_all
          Browet::Cache.create(path: 'products/1', params: {}, json:json_string('product1'), updated_at: Time.now - 10*3600) # fill in cache
        end

        context "when success server reply" do
          it "shoud make http request and refresh cache" do
            now = Time.now
            expect(Browet::Cache.all.length).to eq(1)
            product = Browet::Product.get(1)
            expect(@stub_product1).to have_been_requested.times(1)
            should_be_product_1 product
            expect(Browet::Cache.all.length).to eq(1)
            cached = Browet::Cache.get('products/1')
            expect(cached.updated_at).to be >= now
          end
        end

        context "when server reply timeout" do
          it "shoud make http request and return result from cache" do
            expect(Browet::Cache.all.length).to eq(1)
            cache_updated_at = Browet::Cache.get('products/1').updated_at
            WebMock.reset!
            WebMock.stub_request(:any, Browet::Config.api_url + "/products/1").
              with(:query => {"token" => Browet::Config.key}).to_timeout
            product = Browet::Product.get(1)
            should_be_product_1 product
            expect(Browet::Cache.all.length).to eq(1)
            cached = Browet::Cache.get('products/1')
            expect(cached.updated_at).to eq(cache_updated_at)
          end
        end

      end

    end

  end
end
