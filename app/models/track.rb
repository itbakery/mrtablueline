class Track
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :project
  field :atmonth, type: String
  field :projection, type: BigDecimal
  field :actual, type: BigDecimal
  field :reportnote, type: String

  def self.chart_data
    @tracks = Track.all.to_a
    @tracks.map do |t|
      {
        atmonth: t[:atmonth],
        projection: t[:projection] || 0,
        actual: t[:actual] || 0
      }
    end
  end

end
