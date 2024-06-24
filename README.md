# VPDChallenge

This project is a simple two page app with a few network calls and remote data manipulations, UIKit and storyboards were used to implement the user interface and apple's URLSession was used to make network calls. The project's structure is based on the MVVM architecture so a little bit of reactive programming was used by taking advantage of the didSet object observer property. Memory leaks were kept in check as there were no unnecessary object initialiation or strong reference cycles.

The project launches with the main page, the app automatically makes a network call and returns a list of repositories in an alphabetical order per list, scrolling to the very bottom of the list triggers another batch of names to be added to the existing list (Pagination) and network calls were clipped by caching data, only data that has not been fetched before gets fetched from the api, if it has been fetched before, it gets obtained from CoreData.
