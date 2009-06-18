# == Schema Information
# Schema version: 20090618134932
#
# Table name: timeline_event
#
#  id                     :integer         not null, primary key
#  event_type             :string(255)
#  subject_type           :string(255)
#  actor_type             :string(255)
#  secondary_subject_type :string(255)
#  subject_id             :integer
#  actor_id               :integer
#  secondary_subject_id   :integer
#  created_at             :datetime
#  updated_at             :datetime
#

# It's important that the secondary_subject always is set to Package,
# and actor always set to User.
class TimelineEvent < ActiveRecord::Base
  default_scope :order => "created_at DESC"
  named_scope :recent, :limit => 25, :include => [:actor, :subject]
  named_scope :recent_for_user, lambda { |u| {
      :limit => 10, :conditions => { :actor_id => u.id },
      :include => [:actor, :subject] }
  }

  belongs_to :actor,              :polymorphic => true
  belongs_to :subject,            :polymorphic => true
  belongs_to :secondary_subject,  :polymorphic => true
end
