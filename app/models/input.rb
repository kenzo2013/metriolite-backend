class Input
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :value, type: Float
  field :note, type: String
  field :form_id, type: Integer

  belongs_to :form

  validates_presence_of :date, :value, :form_id
end
