module Browet
  class Base
    include Her::Model
    use_api Browet::Api.default_api

    def self.new_object_from_request
      ->(parsed_data, response) {
        if response.success?
          new(parse(parsed_data[:data]).merge :_metadata => parsed_data[:metadata], :_errors => parsed_data[:errors])
        else
          nil
        end
      }
    end
  end
end