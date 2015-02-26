require 'active_job'
require "browet/cache"

module Browet

  ##
  # HTTP requester with ability of backgroud cache updating
  #
  class Requester < ActiveJob::Base
    
    ##
    # Returns 
    #   json string if update_cahche = false
    #   Cache object if update_cahche = true
    def perform(path, params, update_cahche = true)
      json = get_server_reply path, params
      update_cahche ? Cache.set(path, params, json) : json
    end

    protected

      ##
      # Returns http reply body
      #
      def get_server_reply(path, params)
          uri = URI("#{Config.api_url}/#{path}")
          locale = Config.get_tokenized_locale 
          token = locale.blank? ?
            Config.default_token :
            Config.localized_tokens[locale]
          uri.query = URI.encode_www_form params.merge({token: token})
          res = Net::HTTP.get_response(uri)
          raise HttpError, res.code unless res.is_a? Net::HTTPSuccess
          res.body
      end

  end
end
