class ApiController < ApplicationController
  def addUser
    if(params.has_key?(:email))
      @user = User.new()
      @user.email = params[:email]
      if @user.save!
        json_response({ message: 'User successfully created' }, :created)
      else
        logger.debug "Errors #{@user.errors}"
        json_response({ error: 'Error saving user' }, :unprocessable_entity)
      end
    else
      json_response({ error: 'Missing email parameter'}, :bad_request)
    end
  end

  def addFriend
    @result = checkTwoEmailsParams params
    if @result[:success]
      if @result[:emails][0] != @result[:emails][1]
        createFriendsRelationship @result[:emails][0].id, @result[:emails][1].id
        json_response({ success: true })
      else
        json_response({ error: "User cannot be friends with himself"}, :bad_request)
      end
    else
      json_response({ error: @result[:error]}, @result[:status])
    end
  end

  def getFriends
    if(params.has_key?(:email))
      @user = User.find_by_email! params[:email]
      @friends = Relationship.get_friends_emails @user.id
      json_response({ success: true, friends: @friends.map{ |e| e.email }, count: @friends.length }, :ok)
    else
      json_response({ error: 'Missing email parameter'}, :bad_request)
    end
  end

  def getCommonFriends
    @result = checkTwoEmailsParams params
    if @result[:success]
      if @result[:emails][0] != @result[:emails][1]
        ids = @result[:emails].map{ |e| e.id }
        @friends = Relationship.get_common_friends_emails ids
        json_response({ success: true, friends: @friends.map{ |e| e.email }, count: @friends.length }, :ok)
      else
        json_response({ error: "Cannot select the same user to compare"}, :bad_request)
      end
    else
      json_response({ error: @result[:error]}, @result[:status])
    end
  end

  def subsribe
    @result = checkRequestorTargetParams params
    if @result[:success]
      if @result[:requestorUser] != @result[:targetUser]
        createSubscribeRelationship @result[:requestorUser].id, @result[:targetUser].id
        json_response({ success: true })
      else
        json_response({ error: "Cannot select the same user to subscribe"}, :bad_request)
      end
    else
      json_response({ error: @result[:error]}, @result[:status])
    end
  end

  def block
    @result = checkRequestorTargetParams params
    if @result[:success]
      if @result[:requestorUser] != @result[:targetUser]
        createBlockRelationship @result[:requestorUser].id, @result[:targetUser].id
        json_response({ success: true })
      else
        json_response({ error: "Cannot select the same user to block"}, :bad_request)
      end
    else
      json_response({ error: @result[:error]}, @result[:status])
    end
  end

  def getUsersForUpdate
  end

  def createFriendsRelationship user1, user2
    rel1 = Relationship.find_or_create_by!(user_id: user1, target_user_id: user2)
    rel1.friends = true;
    rel1.subscribe = true;
    rel1.save!
    rel2 = Relationship.find_or_create_by!(user_id: user2, target_user_id: user1)
    rel2.friends = true;
    rel2.subscribe = true;
    rel2.save!
  end

  def createSubscribeRelationship user1, user2
    rel = Relationship.find_or_create_by!(user_id: user1, target_user_id: user2)
    if not rel.subscribe
      rel.subscribe = true
      rel.save!
    end
  end

  def createBlockRelationship user1, user2
    rel = Relationship.find_or_create_by!(user_id: user1, target_user_id: user2)
    if not rel.block
      rel.block = true
      rel.save!
    end
  end

  def checkTwoEmailsParams params
    if params.has_key?(:friends)
      if params[:friends].kind_of?(Array) && params[:friends].length == 2
        @userEmail1 = params[:friends][0]
        @userEmail2 = params[:friends][1]

        @user1 = User.find_by_email @userEmail1
        @user2 = User.find_by_email @userEmail2

        if @user1 && @user2
          { success: true, emails: [ @user1, @user2 ]}
        else
          if @user1.nil?
            { success: false, error:"Unable to find user: #{@userEmail1}", status: :bad_request }
          else
            { success: false, error:"Unable to find user: #{@userEmail2}", status: :bad_request }
          end
        end
      else
        { success: false, error:'friends needs to be an array with length = 2', status: :bad_request }
      end
    else
      { success: false, error:'Missing friends parameter', status: :bad_request }
    end
  end

  def checkRequestorTargetParams params
    if params.has_key?(:requestor) && params.has_key?(:target)
      @requestor = params[:requestor]
      @target = params[:target]

      @requestorUser = User.find_by_email @requestor
      @targetUser = User.find_by_email @target

      if @requestorUser && @targetUser
        { success: true, requestorUser: @requestorUser, targetUser: @targetUser }
      else
        if @requestorUser.nil?
          { success: false, error:"Unable to find user: #{@requestor}", status: :bad_request }
        else
          { success: false, error:"Unable to find user: #{@target}", status: :bad_request }
        end
      end
    else
      { success: false, error:'Missing requestor or target', status: :bad_request }
    end
  end
end
