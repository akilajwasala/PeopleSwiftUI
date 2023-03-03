# PeopleSwiftUI
This is a sample iOS application which used SwiftUI with MVVM implementation

This app is developed to learn SwiftUI with MVVM design pattern.
Here I have used a free REST API https://reqres.in/ 

Application Includes Three main screens of 

* People - Listing people on a GridView, Supports pull to refresh, Pagination 
* Details - Get more details on a specific person 
* Create - Create a new person with their details. Please note API doesn't add to people grid view after successfully added a new user. You can enable haptic feadback for the success message of new person creation.

-> App inludes Unit test cases for almost all the logics and integrations

-> App includes UI Testing only for the People screen

Mocks have been used to replicate the API requests and responces using json files (Inside Resources Directory)

I haven't used any 3rd party libraries in this project. 
