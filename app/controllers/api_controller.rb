class ApiController < ApplicationController
  def addUser
    @user = User.new()
    if(params.has_key?(:email))
      @user.email = params[:email]
      if @user.save!
        json_response({ message: 'User successfully created' }, :created)
      else
        logger.debug "Errors #{@user.errors}"
        json_response({ error: 'Error saving user' }, :unprocessable_entity)
      end
    else
      json_response({ error: 'Missing friends object'}, :bad_request)
    end
  end

  def addFriend
    if(params.has_key?(:friends))
      if params[:friends].kind_of?(Array) && params[:friends].length == 2
        @userEmail1 = params[:friends][0]
        @userEmail2 = params[:friends][1]

        @user1 = User.find_by_email @userEmail1
        @user2 = User.find_by_email @userEmail2

        if @user1 && @user2
          if @user1 != @user2
            createFriendsRelationship @user1.id, @user2.id
            json_response({ success: true })
          else
            json_response({ error: "User cannot be friends with himself"}, :bad_request)
          end
        else
          if @user1.nil?
            json_response({ error: "Unable to find user: #{@userEmail1}"}, :bad_request)
          else
            json_response({ error: "Unable to find user: #{@userEmail2}"}, :bad_request)
          end
        end
      else
        json_response({ error: 'friends needs to be an array with length = 2'}, :bad_request)
      end
    else
      json_response({ error:'Missing friends parameter'}, :bad_request )
    end
  end

  def getFriends
  end

  def getCommonFriends
  end

  def subsribe
  end

  def block
  end

  def getUsersForUpdate
  end

  def createFriendsRelationship user1, user2
    Relationship.find_or_create_by!(user_id: user1, target_user_id: user2, friends: true, block: false)
    Relationship.find_or_create_by!(user_id: user2, target_user_id: user1, friends: true, block: false)
  end
end
