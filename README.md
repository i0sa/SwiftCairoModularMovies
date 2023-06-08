
# SwiftCairoModularMovies

SwiftCairoModularMovies is a modular iOS project, feature-modularized, introducing two features, and aiming to raise million of dollars of fund and scale to up to 10 engineers

This is a session introduced in Swift Cairo meetup in 7th on June 2023, sponsored by Careem Egypt

<a href="README Files/SwiftCairoSlides.pdf">find the slides here</a>

-------------

<img src = "README Files/Screenshot_1.png" width = 380> <img src = "README Files/Screenshot_2.png" width = 380>

# Architecture Diagram
<img src = "README Files/Diagram_1.png" width = 850>
<img src = "README Files/Diagram_2.png" width = 850>

# Modules

**ConsumerNetworking**: This module is responsible for handling all networking requests in the application. It provides a generic networking interface to make API requests using the NetworkingType protocol.

**SwiftCairoCommon**: Domain/Common module for sharing commong interfaces/entities with other modules 

**SwiftCairoDesignSystem**: The SwiftCairoDesignSystem module is a collection of reusable components, styles, and design patterns for your application. It helps maintain a consistent visual language across the app while making it easier for developers to create and update UI elements.

**SwiftCairoCache**: The SwiftCairoCache module is a caching solution designed to make it easy for developers to store and retrieve data in a consistent and organized manner. The primary goal of the module is to provide a simple, efficient, and flexible caching mechanism for various data types in your application.

**MoviesListFeature**: This is a feature module, it is responsible for fetching and displaying a list of movies. It utilizes the ConsumerNetworking module to make API requests and fetch data, this feature is build with VIP architecture, it also utilizes SwiftCairoDesignSystem for design system components usage, as well as SwiftCairoCommon for consuming use cases and entities, it also utilizes SwiftCairoCache module for caching movies.

# DependencyContainer
As a main app, that is scalable in terms of accepting different features, each feature requires depencencies such as networking, caching, toggles, and so on, this is a container for dependencies

# Usage
### Introducing new feature
To introduce a new feature
- Create podspec of feature and add it to podfile
- Create public configure function that takes `dependencies: DependencyContainerType` parameter
- Make sure your configurator is conforming to `SwiftCairoFeature` protocol to provide necessary feature configurations

### Consume feature
To consume a feature, this should be done from the main app and not from inside dependencies
- Make sure that feature is re-configuring SwiftCairoFeature dependency using CacheProxy module, and re-wrap the dependencies, for example:
```
        let cacheDependency = CacheProxy(feature: moviesListFeature)
        let dependencies = DependencyContainer(cache: cacheDependency)
````

// -- NOTE: TODO: We are considering in the future to auto-handle configurating of features through app middleware 

