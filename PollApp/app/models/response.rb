class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_answer
  validate :author_not_answered

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  # has_one :poll,
  #   through: :question,
  #   source: :poll


  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_answer
    if respondent_already_answered?
      self.errors[:respondent] << "Has already answered this question"
    end
  end

  def author_not_answered
    if self.question.poll.author_id == self.user_id
      self.errors[:author] << "Cannot answer own poll."
    end
  end

end
