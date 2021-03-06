class Signup
  
  # http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :person
  attr_reader :plan

  attribute :p_plan_name, String
  attribute :p_postcode, String

  attribute :p_name_0, String
  attribute :p_email_0, String
  attribute :p_mobile_0, String

  # validates :email, presence: true
  # … more validations …

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

private

  def persist!
    @plan = Plan.create!(name: p_plan_name, postcode: p_postcode)

    # create person if they choose to give detail otherwise use this anon approach
    @anon = Person.new(name: 'anon', email: '', mobile: '')
    @plan.people << @anon
    # @plan.people.create!(name: p_name_0, email: p_email_0, mobile: p_mobile_0)

  end
end