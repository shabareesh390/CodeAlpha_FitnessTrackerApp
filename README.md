# Daily Fitness Tracker App

A beautifully designed, cross-platform fitness tracking application built with Flutter and Firebase. 

## Features

*   **Authentication**: Secure Google Sign-In and Email/Password login powered by Firebase Authentication.
*   **Activity Tracking**: Visualize your workout progress, calories burned, and active minutes.
*   **Interactive Charts**: Beautiful, responsive charts built using the `fl_chart` package.
*   **Smart Filtering**: Chip-based UI to easily filter workouts by type (Cardio, Strength, Yoga, etc.) and difficulty level.
*   **Cross-Platform**: Fully functional on Android, iOS, and Web.
*   **Modern UI**: Sleek dark/light theme accents, smooth animations, and a highly polished user experience.

## Tech Stack

*   **Frontend**: Flutter (Dart)
*   **Backend**: Firebase Authentication & Cloud Firestore
*   **Dependencies**: `firebase_core`, `firebase_auth`, `cloud_firestore`, `google_sign_in`, `fl_chart`, `google_fonts`

## Getting Started

### Prerequisites
*   Flutter SDK (v3.0.0 or higher)
*   Dart SDK

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/shabareesh390/CodeAlpha_FitnessTrackerApp.git
    cd CodeAlpha_FitnessTrackerApp
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration (Optional but Recommended):**
    If you are running your own backend, make sure to generate your `firebase_options.dart` file using the FlutterFire CLI:
    ```bash
    flutterfire configure
    ```
    *Note: If testing Google Sign-in on Web, ensure you launch with a fixed port that is authorized in your Google Cloud Console (e.g., `flutter run -d chrome --web-port 5000`).*

4.  **Run the app:**
    ```bash
    flutter run
    ```
