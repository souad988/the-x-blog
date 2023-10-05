# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :delete, Post, author_id: user.id
      can :delete, Comment, author_id: user.id
    end
  end
end
