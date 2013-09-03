module ESPN
  class Client

    # Public: The mapping to the ATHLETES API of the ESPN developer API.
    #
    # Examples
    #
    #   class Client
    #     include ESPN::Client::Athletes
    #   end
    module Athletes

      # Public: Get a specific athlete from the ESPN API.
      #
      # id      - An id of an athlete.
      # sport   - A Symbol or String of the sport (optional).
      # league  - A Symbol or String of the league. If a league is passed, but
      #           not a sport, an attempt will be made to map the league to a
      #           sport (required).
      # opts    - Hash options used to refine the selection. If sport and/or
      #           league are passed in, they will override the mapped values
      #           You can find a full list of options on the ESPN developer API
      #           website (default: {}).
      #
      # Returns a Hashie::Mash.
      def athlete(id, *args)
        # Build fragments and options
        opts = extract_options_with_defaults!(args)
        opts[:sport], opts[:league] = extract_sport_and_league(args, opts)

        if blank?(opts[:league])
          raise ArgumentError, 'You must provide a valid league.'
        end

        # Build URL
        pattern = "sports/:sport/:league/athletes/#{id}"
        url = build_url(pattern, opts)

        puts url

        # Make request
        get(url, opts).sports.first.leagues.first.athletes.first
      end

      # Public: Get athlete stats and information from the ESPN API.
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
      def athletes(*args)
        # Build fragments and options
        opts = extract_options_with_defaults!(args)
        opts[:sport], opts[:league] = extract_sport_and_league(args, opts)

        if blank?(opts[:league])
          raise ArgumentError, 'You must provide a valid league.'
        end

        # Build URL
        pattern = "sports/:sport/:league/athletes"
        url = build_url(pattern, opts)

        # Make request
        get(url, opts).sports.first.leagues.first.athletes
      end

    end
  end
end
