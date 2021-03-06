=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end

module Viewpoint::EWS::SOAP

  # A Generic Class for SOAP returns.
  # @attr_reader [String] :message The text from the EWS element <m:ResponseCode>
  class EwsSoapResponse

    def initialize(sax_hash)
      @resp = sax_hash
    end

    def envelope
      @resp[:envelope]
    end

    def header
      envelope[:header]
    end

    def body
      envelope[:body]
    end

    def response
      body
    end

    def response_messages
      key = response.keys.first
      response[key][:response_messages]
    end

    def response_message
      key = response_messages.keys.first
      response_messages[key]
    end

    def response_class
      response_message[:response_class]
    end
    alias :status :response_class

    def response_code
      response_message[:response_code][:text]
    end
    alias :code :response_code

    def response_message_text
      guard_hash response_message, [:message_text, :text]
    end
    alias :message :response_message_text

    def success?
      response_class == "Success"
    end


    private


    # If the keys don't exist in the Hash return nil
    # @param[Hash] hsh
    # @param[Array<Symbol,String>] keys keys to follow in the array
    # @return [Object, nil]
    def guard_hash(hsh, keys)
      key = keys.shift
      return nil unless hsh.is_a?(Hash) && hsh.has_key?(key)

      if keys.empty?
        hsh[key]
      else
        guard_hash hsh[key], keys
      end
    end

  end # EwsSoapResponse

end # Viewpoint::EWS::SOAP
