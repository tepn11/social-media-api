# API Documentation

**Add User**
----
  Add a single user.

* **URL**

  /api/addUser

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `email=[string]`
  
  **Example:**

  ```json
    {
      "email": "User1@example.com"
    }
  ```


* **Success Response:**

  * **Code:** 201 <br />
    **Content:** `{ "message": "User successfully created" }`
 
* **Error Response:**

  * **Code:** 422 <br />
    **Content:** `{ "error": "Validation failed: Email has already been taken" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing email parameter" }`


**Add Friend**
----
  Add a friend relationship between two users.

* **URL**

  /api/addFriend

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `friends=[array]`

  **Example:**

  ```json
    {
      "friends":
        [
          "user1@example.com",
          "user2@example.com"
        ]
    }
  ```

* **Success Response:**

* **Code:** 200 <br />
  **Content:** `{ "success": true }`
 
* **Error Response:**

  * **Code:** 400 <br />
    **Content:** `{ "error": "Unable to find user: user@email.com" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "User cannot be friends with himself" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing friends parameter" }`
    
  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "friends needs to be an array with length = 2" }`


**Get Friends**
----
  Returns the emails or the friends of a user.

* **URL**

  /api/getFriends

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `email=[string]`
  
  **Example:**

  ```json
    {
      "email": "User1@example.com"
    }
  ```


* **Success Response:**

  * **Code:** 200 <br />
    **Content:** 
    `{
      "success": true,
      "friends": [
        "User2@example.com"
      ],
      "count": 1
    }`
 
* **Error Response:**

  * **Code:** 404 <br />
    **Content:** `{ "error": "Couldn't find User" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing email parameter" }`


**Get common friends**
----
  Return the emails of the common friends between two users.

* **URL**

  /api/getCommonFriends

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `friends=[array]`

  **Example:**

  ```json
    {
      "friends":
        [
          "user1@example.com",
          "user2@example.com"
        ]
    }
  ```

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{
      "success": true,
      "friends": [
        "user3@example.com"
      ],
      "count": 1
    }`
 
* **Error Response:**

  * **Code:** 400 <br />
    **Content:** `{ "error": "Unable to find user: user@email.com" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Cannot select the same user to compare" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing friends parameter" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "friends needs to be an array with length = 2" }`


**Subscribe**
----
  Subscribe to a user to get updates.

* **URL**

  /api/subscribe

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `requestor=[string]`<br />
   `target=[string]`

  **Example:**

  ```json
    {
      "requestor": "user@example.com",
      "target": "user2@example.com"
    }
  ```

* **Success Response:**

* **Code:** 200 <br />
  **Content:** `{ "success": true }`
 
* **Error Response:**

  * **Code:** 400 <br />
    **Content:** `{ "error": "Unable to find user: user@email.com" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Cannot select the same user to subscribe" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing requestor or target" }`


**Block**
----
  Block a user from getting updates or adding as friends. Blocking a target user will prevent the user from recieving updates from the requestor, if they are friends or will not be able to add the requestor as friend.

* **URL**

  /api/block

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `requestor=[string]`<br />
   `target=[string]`

  **Example:**

  ```json
    {
      "requestor": "user@example.com",
      "target": "user2@example.com"
    }
  ```

* **Success Response:**

* **Code:** 200 <br />
  **Content:** `{ "success": true }`
 
* **Error Response:**

  * **Code:** 400 <br />
    **Content:** `{ "error": "Unable to find user: user@email.com" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Cannot select the same user to block" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing requestor or target" }`


**Get Users for Update**
----
  Return a list of emails from users who will recieve updates from a user. Users who will recieve updates are friends of the user who did not block the user and users who were @mentioned in the text.

* **URL**

  /api/block

* **Method:**

  `POST`
  
*  **URL Params**
  None

* **Data Params**

   **Required:**
 
   `sender=[string]`<br />
   `text=[string]`

  **Example:**

  ```json
    {
      "sender":"user@example.com",
      "text":"hello @user2@email.com and john@example.com"
    }
  ```

* **Success Response:**

* **Code:** 200 <br />
  **Content:** `{
      "success": true,
      "recipients": [
        "user1@example.com",
        "user2@example.com"
      ]
    }`
 
* **Error Response:**

  * **Code:** 404 <br />
    **Content:** `{ "error": "Couldn't find User" }`

  OR
  * **Code:** 400 <br />
    **Content:** `{ "error": "Missing sender or text" }`