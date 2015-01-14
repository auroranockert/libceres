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
  class WarParty < Corporation
    crest_accessor :isk_killed, name: 'iskKilled'
    crest_accessor :ships_killed, name: 'shipsKilled'
  end

  class War < Ceres::CrestObject
    crest_accessor :mutual?, name: 'mutual'
    crest_accessor :ally_count, name: 'allyCount'
    crest_accessor :open_for_allies?, name: 'openForAllies'

    crest_date :time_declared, name: 'timeDeclared'
    crest_date :time_started, name: 'timeStarted'
    crest_date :time_finished, name: 'timeFinished'
    
    crest_object :aggressor, Ceres::WarParty
    crest_object :defender, Ceres::WarParty
  end
end
