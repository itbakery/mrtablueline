module Mrta::GraphsHelper
    def tracks_chart_data
        @tracks = @project.tracks.map do | track |
            {
                atmonth: track.atmonth,
                projection: track.projection,
                actual: track.actual
            }
        end
    end
end
