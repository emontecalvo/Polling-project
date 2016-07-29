# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

user1 = User.create!(:user_name => "Davin")
user2 = User.create!(:user_name => "Emily")
user3 = User.create!(:user_name => "Kevin Bacon")

poll1 = Poll.create!(:title => "New poll about weather", :author_id => user1.id)
poll2 = Poll.create!(:title => "Who likes sql?", :author_id => user2.id)

question1 = Question.create!(:text => "Weather q:How old are you?", :poll_id => poll1.id)
question2 = Question.create!(:text => "Weather q: Do you like foggy weather?", :poll_id => poll1.id)
question3 = Question.create!(:text => "SQL q: Are you a programmer?", :poll_id => poll2.id)
question4 = Question.create!(:text => "SQL q: Do you love SQL?", :poll_id => poll2.id)

answer1 = AnswerChoice.create!(:text => "Weather a: Over fifty", :question_id => question1.id)
answer2 = AnswerChoice.create!(:text => "Weather a: Under fifty", :question_id => question1.id)
answer3 = AnswerChoice.create!(:text => "Weather a: I love foggy weather.", :question_id => question2.id)
answer4 = AnswerChoice.create!(:text => "Weather a:Foggy weather is the worst!", :question_id => question2.id)
answer5 = AnswerChoice.create!(:text => "SQL a: Yes", :question_id => question3.id)
answer6 = AnswerChoice.create!(:text => "SQL a: No", :question_id => question3.id)
answer7 = AnswerChoice.create!(:text => "SQL a: I love SQL!", :question_id => question4.id)
answer8 = AnswerChoice.create!(:text => "SQL a: i love SQL even more!", :question_id => question4.id)

response1 = Response.create!(:user_id => user1.id, :answer_choice_id => answer5.id)
response2 = Response.create!(:user_id => user1.id, :answer_choice_id => answer8.id)
response3 = Response.create!(:user_id => user2.id, :answer_choice_id => answer2.id)
response4 = Response.create!(:user_id => user2.id, :answer_choice_id => answer3.id)
response3 = Response.create!(:user_id => user3.id, :answer_choice_id => answer1.id)
response4 = Response.create!(:user_id => user3.id, :answer_choice_id => answer4.id)
