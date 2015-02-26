module Browet

  ##
  # Cache for saving http requests and replies
  #
  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'
    serialize :params, JSON

    ##
    # Returns cahced request
    #
    def self.get(path, params = {}, include_expired = false)
      if include_expired
        where('path=? AND params=? AND locale=?', 
          path, params.to_json, Browet::Config.get_tokenized_locale).first
      else
        where('path=? AND params=? AND locale=? AND updated_at >= ?', 
          path, params.to_json, Browet::Config.get_tokenized_locale, expired_time).first
      end
    end

    ##
    # Saves request to cache table
    #
    def self.set(path, params, json)
      record = where('path=? AND params=? AND locale=?', 
        path, params.to_json, Browet::Config.get_tokenized_locale).first
      if record.nil?
        record = create!(path: path, params: params, 
          json: json, locale: Browet::Config.get_tokenized_locale)
      else
        record.update!(updated_at: Time.now)
      end
      record
    end

    protected
      
      ##
      # Caclulates cache expiration time
      #
      def self.expired_time
        # get DB time
        sql = "SELECT CURRENT_TIMESTAMP"
        db_time = Browet::Cache.connection.select_value(sql).to_time
        db_time - Browet::Config.ttl*Browet::Config::TTL_MULTIPLICATOR
      end

  end

end
