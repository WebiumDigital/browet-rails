require 'active_record'

module Browet

  ##
  # Cache for saving http requests and replies
  #
  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'

    ##
    # Returns cahced request
    #
    def self.get(path, search_query = '', include_expired = false)
      if include_expired
        where('path=? AND params=? AND locale=?', 
          path, search_query, Config.get_tokenized_locale).first
      else
        where('path=? AND params=? AND locale=? AND updated_at >= ?', 
          path, search_query, Config.get_tokenized_locale, expired_time).first
      end
    end

    ##
    # Saves request to cache table
    #
    def self.set(path, search_query, json)
      record = where('path=? AND params=? AND locale=?', 
        path, search_query, Config.get_tokenized_locale).first
      if record.nil?
        record = create!(path: path, params: search_query, 
          json: json, locale: Config.get_tokenized_locale)
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
        db_time = Cache.connection.select_value(sql).to_time
        db_time - Config.ttl*Config::TTL_MULTIPLICATOR
      end

  end

end
