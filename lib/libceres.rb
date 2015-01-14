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

require 'addressable/uri'

require 'faraday'
require 'faraday_middleware'

module Ceres
  def self.tranquility
    Ceres::Root.from_url('http://public-crest.eveonline.com')
  end

  def self.singularity
    Ceres::Root.from_url('http://public-crest-sisi.testeveonline.com')
  end
end

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}")

require 'libceres/crest_object'

require 'libceres/root'
require 'libceres/items'
require 'libceres/market'
require 'libceres/map'
require 'libceres/alliances'
require 'libceres/tournaments'
require 'libceres/incursions'
require 'libceres/wars'
require 'libceres/industry'
