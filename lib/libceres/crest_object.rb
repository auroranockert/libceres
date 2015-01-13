# Copyright 2015 Jens Nockert
#
# Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
# the European Commission - subsequent versions of the EUPL (the "Licence"); You
# may not use this work except in compliance with the Licence. You may obtain a
# copy of the Licence at: https://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# Licence for the specific language governing permissions and limitations under
# the Licence.

require 'date'

module Ceres
  class CrestObject
    attr_reader :connection, :data

    class << self
      def crest_accessor(method_name, options = {}, &block)
        name = options[:name] || method_name.to_s

        self.instance_eval do
          define_method method_name do
            self.reify! unless @data[name]

            value = @data[name]

            block ? block.call(self, value) : value
          end
        end
      end

      def crest_object(method_name, klass, options = {})
        self.crest_accessor(method_name, options) do |parent, object|
          klass.from_summary(parent.connection, object)
        end
      end

      def crest_list(method_name, klass, options = {})
        self.crest_accessor(method_name, options) do |parent, objects|
          objects.map do |object|
            klass.from_summary(parent.connection, object)
          end
        end
      end

      def crest_paginated(method_name, options = {}, &block)
        name = options[:name] || method_name.to_s

        self.instance_eval do
          define_method method_name do
            self.reify! unless @data[name]

            values, current_path = [], @data[name]['href']

            puts "#{current_path.inspect}"

            while current_path
              current = self.connection.get(current_path).body

              values.concat(current['items'])

              if next_reference = current['next']
                current_path = next_reference['href']
              else
                return block.call(self, values)
              end
            end
          end
        end
      end

      def crest_date(method_name, options = {})
        self.crest_accessor(method_name, options) do |_, date|
          Date.parse(date)
        end
      end

      def crest_image(method_name, options = {})
        self.crest_accessor(method_name, options) do |_, image|
          image
        end
      end

      def crest_position(method_name, options = {})
        self.crest_accessor(method_name, options) do |_, position|
          [position['x'], position['y'], position['z']]
        end
      end

      def from_summary(connection, summary)
        self.new(connection, summary)
      end

      def from_data(connection, url, data)
        self.new(connection, data.merge('href' => url, :complete => true))
      end
    end

    def initialize(connection, data)
      @connection, @data = connection, data
    end

    def id
      @data['id'] || self.url.path.split('/').last
    end

    def url
      Addressable::URI.parse(@data['href'])
    end

    def reify!
      return if self.complete?

      @data.merge!(self.connection.get(self.url).body)

      @data[:complete] = true
    end

    def complete?
      @data[:complete] == true || !@url
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id} @id=#{self.id}>"
    end
  end
end
