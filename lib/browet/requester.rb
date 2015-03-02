require 'active_job'
require "browet/cache"

module Browet

  ##
  # HTTP requester with ability of backgroud cache updating
  #
  class Requester < ActiveJob::Base
    
    ##
    # Returns 
    #   json string if update_cache = false
    #   Cache object if update_cache = true
    def perform(path, search_query = '', update_cache = true)
      json = get_server_reply path, search_query
      update_cache ? Cache.set(path, search_query, json) : json
    end

    protected

      ##
      # Returns http reply body
      #
      def get_server_reply(path, search_query = '')
          uri = URI("#{Config.api_url}/#{path}")
          locale = Config.get_tokenized_locale 
          token = locale.blank? ?
            Config.default_token :
            Config.localized_tokens[locale]
          params = search_query.blank? ? {} : {search_query: search_query}
          uri.query = URI.encode_www_form params.merge({token: token})
          res = Net::HTTP.get_response(uri)
          raise HttpError, res.code unless res.is_a? Net::HTTPSuccess
          res.body
      end

  end
end
