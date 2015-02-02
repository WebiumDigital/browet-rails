class EntityTestCase < ActiveSupport::TestCase

  def initialize(a)
    super a
    Browet::Config.account = 'account'
    Browet::Config.key = 'key'
  end

  protected

    def json_string(name)
      IO.read File.dirname(__FILE__) + "/json/#{name}.json"
    end

    def stub_get_request(path, success_body = "", query_params = {}, success_headers = {})
      stub_request(:get, Browet::Config.api_url + "/#{path}").
        with(:query => query_params.merge({"token" => Browet::Config.key})).
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'account.browet.com', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => success_body, :headers => success_headers)

    end

    def product_list_tests(products)
      assert_kind_of Browet::ResultSet, products
      assert_equal 3, products.length 

      product1 = products[0]
      assert_instance_of Browet::Product, product1
      assert_equal 1, product1.id
      assert_equal "product description 1", product1.description
      assert_equal "product title 1", product1.title
      assert_equal "guid 1", product1.guid
      assert_equal "mpn 1", product1.mpn
      assert_equal "slug 1", product1.slug
      assert_equal "availability 1", product1.availability
      assert_equal "gtin 1", product1.gtin
      assert_equal "currency 1", product1.currency

      product2 = products[1]
      assert_instance_of Browet::Product, product2
      assert_equal 2, product2.id
      assert_equal "product description 2", product2.description
      assert_equal "product title 2", product2.title
      assert_equal "guid 2", product2.guid
      assert_equal "mpn 2", product2.mpn
      assert_equal "slug 2", product2.slug
      assert_equal "availability 2", product2.availability
      assert_equal "gtin 2", product2.gtin
      assert_equal "currency 2", product2.currency

      product3 = products[2]
      assert_instance_of Browet::Product, product3
      assert_equal 3, product3.id
      assert_equal "product description 3", product3.description
      assert_equal "product title 3", product3.title
      assert_equal "guid 3", product3.guid
      assert_equal "mpn 3", product3.mpn
      assert_equal "slug 3", product3.slug
      assert_equal "availability 3", product3.availability
      assert_equal "gtin 3", product3.gtin
      assert_equal "currency 3", product3.currency

      assert_equal 3, products.total_count
      assert_equal 1, products.pages
    end

    def product_list_paged_tests(products)
      assert_kind_of Browet::ResultSet, products
      assert_equal 1, products.length 

      product3 = products[0]
      assert_instance_of Browet::Product, product3
      assert_equal 3, product3.id
      assert_equal "product description 3", product3.description
      assert_equal "product title 3", product3.title
      assert_equal "guid 3", product3.guid
      assert_equal "mpn 3", product3.mpn
      assert_equal "slug 3", product3.slug
      assert_equal "availability 3", product3.availability
      assert_equal "gtin 3", product3.gtin
      assert_equal "currency 3", product3.currency

      assert_equal 3, products.total_count
      assert_equal 2, products.pages
    end

end
