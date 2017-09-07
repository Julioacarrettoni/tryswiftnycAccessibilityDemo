# Try! Swift NYC Accessibility
The idea of this project is to ilustrate how little effort it takes to turn a unusable app (from the point of a VoiceOver user) into something that can bring value to them.
This is the demo app I showed on [Try! Swift NYC 2017](https://www.tryswift.co/events/2017/nyc/), and [here](https://speakerdeck.com/dev_jac/accessibility-everyone-is-your-user) you can find the companion slides to that talk. (Soon I'll be adding the link to the video) 

The app itself is to help you track how many pizza slices you have left on your fridge and when you run out it offers to buy another pizza.

# Branches
This repository has 2 branches **master** and **accesibility-tweaks**

The **master** branch has no consideration regarding accesibility, you can run the project and turn on VoiceOver to find out the places where the user is not getting all the required information or to find out thr places where the apps beomes unusable, for example the _Place Order_ and _Cancel Order_ buttons.

You will find a Pull Request from the **accesibility-tweaks** branch, that PR contains all the required fixes to turn this app from useless to a decent. You can inspect the PR and notice that very little work is required (the Storyboard diff looks like big but is not) and then you can build from this branch and check the difference when running the app with VoiceOver on.


