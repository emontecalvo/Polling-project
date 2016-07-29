class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result = {}
    answer_choice_arr = self.answer_choices
    answer_choice_arr.each do |answer_choice|
      result[answer_choice.text] = answer_choice.responses.count
    end
    result
  end

  def results_with_includes
    result = {}
    answer_choice_arr = self.answer_choices.includes(:responses)
    answer_choice_arr.each do |answer_choice|
      result[answer_choice.text] = answer_choice.responses.length
    end
    result
  end

  def results_with_sql

    # result = {}
    # answer_choice_arr = self.answer_choices.includes(:responses)
    # answer_choice_arr.each do |answer_choice|
    #   result[answer_choice.text] = answer_choice.responses.length
    # end
    # result
    results_hash = {}
    results_arr = AnswerChoice.find_by_sql([<<-SQL, id: self.id])
      SELECT
        answer_choices.text, COUNT(responses.answer_choice_id) AS count
      FROM
        answer_choices
      LEFT JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        answer_choices.question_id = :id
      GROUP BY
        answer_choices.id
    SQL

    results_arr.each do |answer|
      results_hash[answer.text] = answer.count
    end

    results_hash
  end

end
