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
end
