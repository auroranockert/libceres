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
  class Type < Ceres::CrestObject; end
  class Group < Ceres::CrestObject; end
  class Category < Ceres::CrestObject; end

  class Type
    crest_accessor :name
    crest_accessor :description
  end

  class Group
    crest_accessor :name
    crest_accessor :description

    crest_accessor :published?, name: 'published'

    crest_object :category, Ceres::Category

    crest_list :types, Ceres::Type
  end

  class Category
    crest_accessor :name

    crest_accessor :published?, name: 'published'

    crest_object :groups, Ceres::Group
  end
end