module ESPN
  class Client

    # Public: The mapping to the STANDINGS API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Standings
    #   end
    module Standings

      # Public: Get the latest league and divisional standings from ESPN.
      #
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #
      # Returns an Array of Hashie::Mash.
      def standings(*args)
        arguments = ESPN::Arguments.new(args, {}, [:league])
        pattern = 'sports/:sport/:league/standings'
        get(pattern, arguments.options).sports.first.leagues.first.groups
      end

    end
  end
end
