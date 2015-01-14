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
  class MarketGroup < Ceres::CrestObject; end

  class MarketPrice < Ceres::CrestObject
    crest_accessor :adjusted_price, name: 'adjustedPrice'
    crest_accessor :average_price, name: 'averagePrice'

    crest_object :type, Ceres::Type
  end

  class MarketType < Ceres::CrestObject
    crest_object :type, Ceres::Type
    crest_object :market_group, Ceres::MarketGroup, name: 'marketGroup'
  end

  class MarketGroup
    crest_accessor :name
    crest_accessor :description

    crest_paginated :types, name: 'types' do |group, market_types|
      market_types.map do |market_type|
        MarketType.from_summary(group.connection, market_type)
      end
    end
  end
end