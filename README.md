# InstagramApiExample
Using Instagram API example

Config:
- In LoginViewController set  TYPE_OF_AUTO to be "SIGNED" or "UNSIGNED" and set  INSTAGRAM_CLIENT_ID
* For UNSIGNED: Set also INSTAGRAM_CLIENTSERCRET

The app:
Login view:
1. Loading label while app is loading
2. Instagram login screen
3. Refresh button (clear customer log-in in case of error)

Media view:
1. Search user media: Show all media for current user
2. Search media by location: Find user location and find medias from that location
3. Search media by tag: Find tags of search text and find medias from that tag
4. When view load, user media is shown (default)
5. Each media includes:
- image with 1:1 ration that will fit the screen width, above the image is the user name and below the image is the # of likes and like/unlike button

Design and assumptions:
1. Used Auto layout, the app will work on all devices (iPhone / iPad) portrait and landscape with the same look and feel
2. Used table view controller with custom cell to present the media
3. Database not used
4. All the text on screens is localized
5. Media by location: The app will request user permission when the view loads and use the user location to find media in that area, the app get all location ids for user location, I used only the first location Id to get the medias.
6. Search media by text: The search starts when used click on the "Done" button, the search return all tags relevant for the search, I used the first tag to get the medias, The user can close the keyboard by clicking on the keyboards "done" button, or the "hide keyboard" button, also if the user click on the other "user media" or "Location media" buttons the keyboard disappears
7. Like and unlike button: Send POST / DELETE request to change the media "like/ unlike" value. I don't wait for the server response and update the "like/unlike" button in the table, I don't update the number of likes.
8. Login refresh button, in case log-in failed, clicking on the refresh button will clear user log-in data and will reload the Instagram log-in view
