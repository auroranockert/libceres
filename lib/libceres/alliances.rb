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
  class Alliance < Ceres::CrestObject; end
  class Corporation < Ceres::CrestObject; end
  class Character < Ceres::CrestObject; end

  class Alliance < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :short_name, name: 'shortName'

    crest_accessor :description
    crest_accessor :deleted

    crest_date :start_date, name: 'startDate'

    crest_object :creator_character, Ceres::Character, name: 'creatorCharacter'
    crest_object :creator_corporation, Ceres::Corporation, name: 'creatorCorporation'
    crest_object :executor_corporation, Ceres::Corporation, name: 'executorCorporation'

    crest_list :corporations, Ceres::Corporation
  end

  class Corporation < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :npc?, name: 'isNPC'

    crest_image :logo

    def complete?
      true # Not in API yet
    end
  end

  class Character < Ceres::CrestObject
    crest_accessor :name
    crest_accessor :npc?, name: 'isNPC'

    crest_image :portrait

    def complete?
      true # Not in API yet
    end
  end
end
