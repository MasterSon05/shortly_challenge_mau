# mau_shortly_challange
The main.dart file contains the basic application launch codes, which are then directed to the home_page.dart file. The home_page.dart file contains widgets and various actions for the screen. With the api_client.dart file under the Data folder, we connect to the Api and access the data.

I created the HomePage class as StatefulWidget to control the "states". I added a Scaffold widget to the widget tree and split the app into two parts:
Part 1st shows the display => first screen and links.
The 2nd part contains the part where we will log in to send the link to the API.

When a link is entered to the TextField, a connection is established with the api using the "http" package.
Information from the API is shifted to a list.
  later, when an element is created in this list, the information is displayed in the card widget on the screen.
The shortened link can be copied quickly with the help of the button.
The desired element can be deleted with the help of the delete button.

I did not use any "state management" system as the application is small in size and easy to manage.
## Getting Started
