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
  class Region < Ceres::CrestObject; end
  class Constellation < Ceres::CrestObject; end
  class System < Ceres::CrestObject; end
  class Planet < Ceres::CrestObject; end

  class Region
    crest_accessor :name

    crest_list :constellations, Ceres::Constellation
  end

  class Constellation
    crest_object :region, Ceres::Region

    crest_accessor :name
    crest_position :position

    crest_list :systems, Ceres::System
  end

  class System < Ceres::CrestObject
    crest_object :constellation, Ceres::Region

    crest_accessor :name

    crest_accessor :security_class, name: 'securityClass'
    crest_accessor :security_status, name: 'securityStatus'
    crest_position :position

    crest_list :planets, Ceres::Planet
  end

  class Planet < Ceres::CrestObject
    crest_object :system, Ceres::System

    crest_accessor :name
    crest_position :position

    crest_object :type, Ceres::Type
  end
end
