# Fake store - A Mobile E-commerce App

A modern, feature-rich e-commerce mobile application built with Flutter, using the Fake Store API for product data.

## About The Project

This project is a fully functional mobile storefront application designed to showcase core e-commerce functionalities. It provides users with a seamless shopping experience, from logging in and browsing products to managing a shopping cart and a personal wishlist. The app is built with Flutter for cross-platform performance and uses the popular Fake Store API for dynamic product data.

Key features include secure user login, an infinitely scrolling product feed, detailed product views, cart management, and a persistent wishlist stored locally on the device.

## Features

- **User Authentication**: Secure login using the Fake Store API with robust field validation and a show/hide password toggle.

- **Dynamic Product Listing**: Browse products fetched from the API, displayed with images, prices, and ratings. Implements lazy loading for a smooth, infinite scrolling experience.

- **Detailed Product Views**: Tap any product to see its full description, category, and more detailed information.

- **Cart Management**: Easily add or remove items from the shopping cart and see the total price update in real-time.

- **Persistent Wishlist**: Save favorite products to a wishlist that persists between app sessions using local storage (`shared_preferences`).

## Tech Stack & Key Packages

- **Framework**: [Flutter 3.35.3](https://flutter.dev/)

- **Language**: [Dart 3.9.2](https://dart.dev/)

- **API**: [Fake Store API](https://fakestoreapi.com/)

- **Networking**: retrofit

- **Local Storage**: shared_preferences for persisting the wishlist

- **State Management**: BLoC, equatable
- **Routing**: go_router

# How It Works: Code Architecture
This project is built using a modern feature-first, layered architecture. This design separates the application into independent features (like `auth`, `cart`, `home`) and further divides each feature into distinct layers (`data` and `presentation`). This approach makes the codebase organized, scalable, and easy to manage.

For state management, the project uses Cubit, a lightweight and predictable state management solution from the `bloc` library.

## 1. Directory Breakdown

### Here is a look at the key directories and their roles:
- `/lib/main.dart`: The entry point of the application. This file is responsible for initializing core services (like dependency injection), setting up the root widget, and starting the app.

- `/lib/core`: This directory holds all the shared code and services that are used across multiple features.

    - `di/`: Stands for Dependency Injection. This folder likely contains the setup for a service locator (like `get_it`) to register and provide dependencies (e.g., repositories, API clients) throughout the app. This avoids the need for hard-coding dependencies and makes testing easier.

    - `navigation/`: Manages the application's routing logic. It probably contains a router class `go_router` that defines all the available navigation paths.

- `/lib/features`: This is the heart of the application, where each business feature lives in its own isolated folder. Let's look at the structure inside the cart feature as an example:

    - `/data`: This layer is responsible for all data handling.

        - `datasource/`: Contains the logic for fetching raw data from its source, whether it's a remote API or local storage.

        - `repository/`: Acts as a mediator between the data sources and the rest of the app. It abstracts the data's origin, meaning the UI doesn't know or care if the data is coming from an API or a local database.

- `/presentation` Layer: This layer contains everything related to the UI and user interaction.

    - `cubit/`: Holds the business logic and state for the feature. The `CartCubit` would manage the list of cart items, calculate the total price, and provide methods to add or remove items.

    - `screens/`: Contains the main screen widgets for the feature, like a `CartScreen` that displays the items.

    - `widgets/`: Holds smaller, reusable widgets specific to this feature, such as a `CartItemCard` or a `TotalPriceDisplay`.

## 2. Feature Walkthrough: Viewing the Cart

### To see how these parts work together, let's trace the flow of data when a user opens their shopping cart:

1. Navigation: The user taps a cart icon, which uses the router from `/core/navigation` to navigate to the CartScreen.

2. UI Initialization: The CartScreen (`/features/cart/presentation/screens/`) is created. In its initial state, it requests the cart data from the CartCubit.

3. State Management: The CartCubit (`/features/cart/presentation/cubit/`) is responsible for fetching the cart items. It calls a method on the CartRepository.

4. Data Layer (Repository): The CartRepository (`/features/cart/data/repository/`) gets the request. Its job is to provide the cart data. It calls the appropriate method in its CartDatasource.

5. Data Layer (Datasource): The CartDatasource (`/features/cart/data/datasource/`) contains the actual logic to retrieve the data (e.g., from local storage or an API). It fetches the raw data and returns it to the repository.

6. Data Flow Back: The repository processes the raw data (perhaps converting it into models) and returns it to the `CartCubit`.

7. State Update: The `CartCubit` receives the list of cart items and emits a new state containing this data.

8. UI Rebuild: The `CartScreen`, which is listening to the `CartCubit`, receives the new state and rebuilds itself to display the cart items to the user.