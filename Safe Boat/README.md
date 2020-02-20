# Safe Boat

iOS Nanodegree Final Project

An app that allows you to determine the course of the ship and avoid shipwreck.
(This project is not intended for real life use!)

![Screenshot](https://user-images.githubusercontent.com/8853297/74906408-0623ed00-53c2-11ea-998d-9ee94a28aac1.png)

When you first run the application, the information screen is displayed.
A form is also displayed that requires the API key that will be used to authenticate the API calls.

The API calls are limited so by default the app uses the last downloaded data until you click the "refresh" button. You can also enable "online mode" if you want the data to be refreshed every 2 minutes.

It is possible to enable the GPS location. By default, manual mode is enabled, it can be used on the simulator that way. In manual mode you can move the map manually and you can use the sliders on the bottom to set the heading and the speed.

If a possible collision is detected, an alarm is displayed.

The collision is calculated using a very basic algorithm. The purpose of the project is to display the iOS developer skills, not the mathematic skills.
The algorithm calculates the estimated path within the next hour and draws a line of this path. If the line of our ship intersects the line of another ship, then we are in collision course.

This project uses the Alamofire library for the network calls.


# Requirements

Xcode 10.3

Swift 5

Alamofire 5
