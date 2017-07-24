Rails.application.routes.draw do
  post 'api/addUser'

  post 'api/addFriend'

  post 'api/getFriends'

  post 'api/getCommonFriends'

  post 'api/subscribe'

  post 'api/block'

  post 'api/getUsersForUpdate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
