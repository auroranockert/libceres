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
  class CostIndex < Ceres::CrestObject
    crest_accessor :activity_id, name: 'activityID'
    crest_accessor :activity_name, name: 'activityName'
    crest_accessor :cost_index, name: 'costIndex'
  end

  class IndustryFacility < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :tax

    crest_accessor :facility_id, name: 'facilityID'

    # TODO: These do not have hrefs, and need some massage
    # crest_object :type, Ceres::Type
    # crest_object :owner, Ceres::Corporation
    # crest_object :region, Ceres::Region
    # crest_object :solar_system, Ceres::System, name: 'solarSystem'
  end

  class IndustrySpeciality < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :groups # TODO: Interpret this
  end

  class IndustrySystem < Ceres::CrestObject
    crest_object :solar_system, Ceres::System, name: 'solarSystem'

    crest_list :system_cost_indices, Ceres::System, name: 'systemCostIndices'
  end

  class IndustryWorker < Ceres::CrestObject
    crest_accessor :bonus # TODO: Interpret this
    crest_object :specialization, Ceres::IndustrySpeciality
  end

  class IndustryTeam < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :activity
    crest_accessor :cost_modifier, name: 'costModifier'

    crest_date :creation_time, name: 'creationTime'
    crest_date :expiry_time, name: 'expiryTime'

    crest_object :specialization, Ceres::IndustrySpeciality
    crest_object :solar_system, Ceres::System, name: 'solarSystem'

    crest_list :workers, Ceres::IndustryWorker
  end

  class Industry < Ceres::CrestObject
    crest_paginated :facilities do |industry, facilities|
      facilities.map do |facility|
        IndustryFacility.from_summary(industry.connection, facility)
      end
    end

    crest_paginated :specialities do |industry, specialities|
      specialities.map do |speciality|
        IndustrySpeciality.from_summary(industry.connection, speciality)
      end
    end
    
    crest_paginated :systems do |industry, systems|
      systems.map do |system|
        IndustrySystem.from_summary(industry.connection, system)
      end
    end
    
    crest_paginated :teams do |industry, teams|
      teams.map do |team|
        IndustryTeam.from_summary(industry.connection, team)
      end
    end
  end
end