class Form
  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: String
  field :name, type: String
  field :tags, type: Array

  has_many :inputs, dependent: :destroy
  validates_presence_of :key, :name, :tags
  validates_uniqueness_of :key, :name, :tags
  validate :validate_input_params

  def validate_input_params
    return unless tags
    tags.each do |tag|
      tag = tag.transform_keys(&:to_sym)
      if !tag.has_key?(:date)
        errors.add(:tags, "date must be present in tags")
      end
      if !tag.has_key?(:value)
        errors.add(:tags, "value must be present in tags")
      end
    end


  end
end
