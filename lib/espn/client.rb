require 'espn/connection'
require 'espn/request'

require 'espn/client/athletes'
require 'espn/client/audio'
require 'espn/client/headlines'
require 'espn/client/medals'
require 'espn/client/notes'
require 'espn/client/now'
require 'espn/client/scores'
require 'espn/client/sports'
require 'espn/client/standings'
require 'espn/client/teams'

module ESPN

  class Client

    # Public: An attr_accessor for each configuration option.
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    # Public: Initialize a new Client. To see all options that can be
    # configured, look at the Configuration module, specifically
    # VALID_OPTIONS_KEYS.
    #
    # opts  - A Hash of configuration options.
    def initialize(opts={})
      options = ESPN.options.merge(opts)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Public: Get the base URL for accessing the ESPN API.
    #
    # Returns a String.
    def api_url
      "http://api.espn.com/v1/"
    end

    # Public: Determine if the ESPN::Client has been authenticated. At this
    # point, we are just checking to see if an :api_key has been set.
    #
    # Returns a Boolean.
    def authed?
      !api_key.nil?
    end

    include ESPN::Connection
    include ESPN::Request
    include ESPN::Client::Athletes
    include ESPN::Client::Audio
    include ESPN::Client::Headlines
    include ESPN::Client::Medals
    include ESPN::Client::Notes
    include ESPN::Client::Now
    include ESPN::Client::Scores
    include ESPN::Client::Sports
    include ESPN::Client::Standings
    include ESPN::Client::Teams

  end

end
