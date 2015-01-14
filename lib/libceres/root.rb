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

module Ceres
  class Root < Ceres::CrestObject
    def initialize(url, connection)
      @url, @connection, @data = url, connection, {}
    end

    def self.from_url(url)
      connection = Faraday.new(url) do |conn|
        conn.response :json, :content_type => /\bjson$/

        conn.adapter Faraday.default_adapter
      end

      Root.new(url, connection)
    end

    def url
      Addressable::URI.parse(@url)
    end

    crest_accessor :motd do |root, motd|
      motd.map do |k, value|
        { k => root.connection.get(value['href']).body }
      end.reduce(&:merge)
    end

    crest_paginated :item_groups, name: 'itemGroups' do |root, groups|
      groups.map do |group|
        Group.from_summary(root.connection, group)
      end
    end

    crest_paginated :alliances do |root, alliances|
      alliances.map do |alliance|
        Alliance.from_summary(root.connection, alliance['href'])
      end
    end

    crest_paginated :item_types, name: 'itemTypes' do |root, types|
      types.map do |type|
        Type.from_summary(root.connection, type)
      end
    end

    # Market Prices

    crest_paginated :item_categories, name: 'itemCategories' do |root, categories|
      categories.map do |category|
        Category.from_summary(root.connection, category)
      end
    end

    crest_paginated :regions do |root, regions|
      regions.map do |region|
        Region.from_summary(root.connection, region)
      end
    end

    crest_paginated :market_groups, name: 'marketGroups' do |root, market_groups|
      market_groups.map do |market_group|
        MarketGroup.from_summary(root.connection, market_group)
      end
    end

    crest_paginated :tournaments do |root, tournaments|
      tournaments.map do |tournament|
        Tournament.from_summary(root.connection, tournament['href'])
      end
    end

    crest_accessor :server_version, name: 'serverVersion'

    crest_paginated :wars do |root, wars|
      wars.map do |war|
        War.from_summary(root.connection, war)
      end
    end

    crest_paginated :incursions do |root, incursions|
      incursions.map do |incursion|
        Incursion.from_summary(root.connection, incursion)
      end
    end

    crest_accessor :service_status, name: 'serviceStatus'
    crest_accessor :user_counts, name: 'userCounts'

    # Industry

    crest_paginated :market_types, name: 'marketTypes' do |root, market_types|
      market_types.map do |market_type|
        MarketType.from_summary(root.connection, market_type)
      end
    end

    crest_accessor :server_name, name: 'serverName'
  end
end
