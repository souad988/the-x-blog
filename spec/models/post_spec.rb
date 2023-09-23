# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Welcome', author: User.create(name: 'Jame')) }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    puts subject.valid?
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    long_title = 'a' * 259
    subject.title = long_title
    expect(subject).to_not be_valid
  end

  it 'is valid with a comments_counter greater than or equal to 0' do
    subject.comments_counter = 10
    puts subject.valid?
    expect(subject).to be_valid
  end

  it 'is not valid with a comments_counter less than 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is valid with a likes_counter greater than or equal to 0' do
    subject.likes_counter = 5
    expect(subject).to be_valid
  end

  it 'is not valid with a likes_counter less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
end
