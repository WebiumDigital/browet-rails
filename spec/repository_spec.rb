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


      it "should make http request and refresh cache" do
        # cache is empty
        expect(Browet::Cache.all.length).to eq(0)
        
        # products is returned
        products = Browet::Product.list
        should_be_unpaged_set  products

        # server request was made
        expect(@stub_products).to have_been_requested

        # cache is not empty
        expect(Browet::Cache.all.length).to eq(1)

        # valid record in the cache
        cache_record = Browet::Cache.get('products')
        expect(cache_record).to be_a(Browet::Cache)
        expect(cache_record.path).to eq('products')
        expect(cache_record.json).to eq(json_string('products'))
      end

      it "should not cache product search request" do
        # cache is empty
        expect(Browet::Cache.all.length).to eq(0)
        
        # product is returned
        products = Browet::Product.find({title: 'product title 1'})
        should_be_find_set  products

        # server request was made
        expect(@stub_product_fined).to have_been_requested

        # cache is empty
        expect(Browet::Cache.all.length).to eq(0)
      end

      context "when server reply timeout" do
        it "should make http request and raise error" do
          # cache is empty
          expect(Browet::Cache.all.length).to eq(0)
          
          # stub server request timeout 
          WebMock.reset!
          WebMock.stub_request(:any, Browet::Config.api_url + "/products/product1").
            with(:query => {"token" => Browet::Config.default_token}).to_timeout

          # timeout on request
          expect { Browet::Product.get('product1') }.to raise_error(Timeout::Error)
        end
      end

    end

    context "when nonempty cache" do

      context "when nondirty cahce" do
        before(:example) do
          # fill in cache with nondirty data
          Browet::Cache.delete_all
          Browet::Config.ttl = 10
          timestamp = Time.now - (Browet::Config.ttl - 1)*Browet::Config::TTL_MULTIPLICATOR
          Browet::Cache.create(path: 'products/product1', locale: '', params: {}, 
            json:json_string('product1'), updated_at: timestamp)
        end

        it "should not make http request and return result from cache" do
          # cache is not empty
          expect(Browet::Cache.all.length).to eq(1)

          # product is returned
          product = Browet::Product.get('product1')
          should_be_product_1 product
          
          # server was not requested
          expect(@stub_product1).not_to have_been_requested
        end
      end

      context "when dirty cahce" do
        before(:example) do
          # fill in cache with dirty data
          Browet::Cache.delete_all
          Browet::Config.ttl = 10
          timestamp = Time.now - (Browet::Config.ttl + 1)*Browet::Config::TTL_MULTIPLICATOR
          Browet::Cache.create(path: 'products/product1', locale: '', params: {}, 
            json:json_string('product1'), updated_at: timestamp)
        end

        context "when success server reply" do
          it "shoud make http request and refresh cache" do
            # current request time
            now = Time.now

            # cache is not empty
            expect(Browet::Cache.all.length).to eq(1)

            # product is returned
            product = Browet::Product.get('product1')
            should_be_product_1 product

            # server was requested
            expect(@stub_product1).to have_been_requested.times(1)

            # cache was updated
            expect(Browet::Cache.all.length).to eq(1)
            cached = Browet::Cache.get('products/product1')
            expect(cached.updated_at).to be >= now
          end
        end

        context "when server reply timeout" do
          it "shoud make http request and return result from cache" do
            # cache is not empty
            expect(Browet::Cache.all.length).to eq(1)
            
            # current cache update time
            cache_updated_at = Browet::Cache.get('products/product1').updated_at

            # stub server request timeout 
            WebMock.reset!
            WebMock.stub_request(:any, Browet::Config.api_url + "/products/product1").
              with(:query => {"token" => Browet::Config.default_token}).to_timeout
  
            # product is returned
            product = Browet::Product.get('product1')
            should_be_product_1 product

            # cache was not updated
            expect(Browet::Cache.all.length).to eq(1)
            cached = Browet::Cache.get('products/product1')
            expect(cached.updated_at).to eq(cache_updated_at)
          end
        end

      end

    end

  end
end
