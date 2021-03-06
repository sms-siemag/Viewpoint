module Viewpoint::EWS::SOAP

  # Exchange User Configuration operations as listed in the EWS Documentation.
  # @see http://msdn.microsoft.com/en-us/library/bb409286.aspx
  module ExchangeUserConfiguration
    include Viewpoint::EWS::SOAP

    # The GetUserConfiguration operation gets a user configuration object from
    # a folder.
    # @see http://msdn.microsoft.com/en-us/library/aa563465.aspx
    # @param [Hash] opts
    # @option opts [Hash] :user_config_name
    # @option opts [String] :user_config_props
    def get_user_configuration(opts)
      opts = opts.clone
      [:user_config_name, :user_config_props].each do |k|
        validate_param(opts, k, true)
      end
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild.GetUserConfiguration {|x|
          x.parent.default_namespace = @default_ns
          builder.user_configuration_name!(opts[:user_config_name])
          builder.user_configuration_properties!(opts[:user_config_props])
        }
        end
      end
      do_soap_request(req, response_class: EwsSoapAvailabilityResponse)
    end

    def update_user_configuration(opts)
      opts = opts.clone
      validate_param(opts, :user_config_name, true)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild[NS_EWS_MESSAGES].UpdateUserConfiguration {|x|
          builder.user_configuration!(opts)
        }
        end
      end
      do_soap_request(req, response_class: EwsSoapResponse)
    end

    def create_user_configuration(opts)
      opts = opts.clone
      validate_param(opts, :user_config_name, true)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild[NS_EWS_MESSAGES].CreateUserConfiguration {|x|
          builder.user_configuration!(opts)
        }
        end
      end
      do_soap_request(req, response_class: EwsSoapResponse)
    end

    def delete_user_configuration(opts)
      opts = opts.clone
      validate_param(opts, :user_config_name, true)
      req = build_soap! do |type, builder|
        if(type == :header)
        else
        builder.nbuild[NS_EWS_MESSAGES].DeleteUserConfiguration {|x|
          builder.user_configuration_name!(opts[:user_config_name])
        }
        end
      end
      do_soap_request(req, response_class: EwsSoapResponse)
    end

  end #ExchangeUserConfiguration
end
