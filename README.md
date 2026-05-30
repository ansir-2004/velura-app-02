# Velura App

Velura is a luxury fashion shopping app built with Flutter and Firebase. It lets users browse products by category, search items, view product details, manage a cart and wishlist, and place orders through a clean mobile shopping flow.

## Project Details

- **App name:** Velura
- **Platform:** Flutter
- **Backend:** Firebase Authentication and Cloud Firestore
- **State management:** Provider
- **Routing:** Flutter named routes
- **Theme:** Custom luxury dark UI

## Features

- Splash screen and onboarding flow
- Login and registration screens
- Firebase authentication setup
- Product listing from Firestore
- Category filtering
- Search by product name or category
- Product details page
- Wishlist support
- Cart management with quantity updates
- Checkout screen
- Place order flow
- Order history UI
- Profile screen

## Tech Stack

- Flutter
- Dart
- Firebase Core
- Firebase Authentication
- Cloud Firestore
- Provider
- GoRouter dependency included in the project
- Cached Network Image dependency included in the project

## Folder Structure

```text
lib/
  core/
  models/
  providers/
  screens/
  services/
  utils/
  widgets/
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Firebase project connected to the app
- Android Studio, VS Code, or Xcode depending on your target platform

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

## Firebase Setup

This project uses Firebase initialization through `lib/firebase_options.dart`.

Make sure:

1. Your Firebase project is created.
2. Authentication is enabled in Firebase.
3. Cloud Firestore is enabled.
4. The generated `firebase_options.dart` matches your Firebase project.

## Firestore Data

The app reads products from the `products` collection in Firestore.

Expected fields:

- `name`
- `category`
- `description`
- `imageUrl`
- `price`
- `oldPrice`
- `rating`
- `sizes`

## Product Images

The app supports both:

- Firebase or external image URLs
- Local asset images in `assets/images/...`

## Notes

- Prices are formatted in the UI using a shared helper.
- Cart and wishlist data are managed locally through Provider.
- The UI is styled for a premium fashion shopping experience.

## Screens

- Splash
- Get Started
- Login
- Register
- Home
- Product List
- Product Details
- Cart
- Checkout
- Place Order
- Order History
- Profile

## License

This project is created for personal or educational use unless you add a separate license file.
