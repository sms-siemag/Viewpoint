=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2015 Tatiana Kudiyarova <tatiana.kudiyarova@gmail.com>

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

module Viewpoint::EWS::Types
  # The Notification element contains information about the subscription and the events that have occurred.
  # https://msdn.microsoft.com/EN-US/library/office/aa565349(v=exchg.150).aspx
  class Notification
    include Viewpoint::EWS
    include Viewpoint::EWS::Types

    NOTIFICATION_KEY_PATHS = {
      subscription_id: [:elems, 0, :subscription_id, :text],
      events: [:elems]
    }

    NOTIFICATION_KEY_TYPES = {
      events: :build_events
    }

    NOTIFICATION_KEY_ALIAS = {}

    # @param [SOAP::ExchangeWebService] ews the EWS reference
    # @param [Hash] notification the EWS parsed response document
    def initialize(ews, notification)
      super(ews, notification)
    end

    private

    def build_events elems
      return [] if elems.nil?
      events = elems.reject {|h| h[:subscription_id]}

      events.collect do |e|
        key = e.keys.first
        class_by_name(key).new(self, e[key])
      end
    end

    def key_paths
      @key_paths ||= NOTIFICATION_KEY_PATHS
    end

    def key_types
      @key_types ||= NOTIFICATION_KEY_TYPES
    end

    def key_alias
      @key_alias ||= NOTIFICATION_KEY_ALIAS
    end

  end
end
