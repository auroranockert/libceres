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
  class Tournament < Ceres::CrestObject; end
  class TournamentTeam < Ceres::CrestObject; end

  class TournamentSeries < Ceres::CrestObject
    # Parse all of this
  end

  class TournamentMatch < Ceres::CrestObject
    crest_object :winner, Ceres::TournamentTeam

    crest_object :red_team, Ceres::TournamentTeam, name: 'redTeam'
    crest_object :blue_team, Ceres::TournamentTeam, name: 'blueTeam'

    crest_object :series, Ceres::TournamentSeries
    crest_object :tournament, Ceres::Tournament

    crest_accessor :finalized?, name: 'finalized'
    crest_accessor :in_progress?, name: 'inProgress'
    
    crest_accessor :score do |_, score|
      { red: score['redTeam'], blue: score['blueTeam'] }
    end

    # TODO: bans - Understand format
  end

  class TournamentStatistics < TournamentTeam
    crest_list :matches, Ceres::TournamentMatch
  end

  class TournamentBanFrequency < Ceres::CrestObject
    crest_accessor :number_of_bans, name: 'numBans'

    crest_object :ship_type, Ceres::Type, name: 'shipType'
  end

  class TournamentTeam
    crest_accessor :name

    crest_object :captain, Ceres::Character
    crest_list :pilots, Ceres::Character

    crest_accessor :isk_killed, name: 'iskKilled'
    crest_accessor :ships_killed, name: 'shipsKilled'

    crest_list :ban_frequency, Ceres::TournamentBanFrequency, name: 'banFrequency'
    crest_list :ban_frequency_against, Ceres::TournamentBanFrequency, name: 'banFrequencyAgainst'

    crest_object :team_statistics, Ceres::TournamentStatistics, name: 'teamStats'

    # TODO: members - No idea what this really is supposed to be
  end

  class Tournament
    crest_accessor :name
    crest_accessor :type

    crest_date :membership_cutoff, name: 'membershipCutoff'

    crest_object :series, Ceres::TournamentSeries
    crest_list :entries, Ceres::TournamentTeam
  end
end
