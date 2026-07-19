# FittPulse - Premium Fitness Tracker

A beautifully designed, premium cross-platform fitness tracking application built with Flutter, Firebase, and Gemini AI. FittPulse features a stunning dark-mode-first glassmorphism UI designed for a modern user experience.

## ✨ Features

*   **Premium UI/UX**: Sleek dark theme with glassmorphic cards, smooth page transitions, micro-animations, and dynamic progress rings.
*   **Gemini AI Coach**: Get personalized workout plans, diet advice, and fitness tips from the built-in generative AI coach.
*   **Complete Firebase Integration**: 
    *   **Authentication**: Secure Google Sign-In and Email/Password login.
    *   **Cloud Firestore**: Real-time synchronization of your daily stats, hydration goals, calorie tracking, and favorite workouts.
*   **Activity Tracking**: Visualize your workout progress, calories burned, active minutes, and heart rate with interactive `fl_chart` graphs.
*   **Meal & Water Logging**: Easily track your breakfast, lunch, dinner, and daily hydration goals. 
*   **Smart Filtering**: Chip-based UI to easily filter workouts by type (Cardio, Strength, Yoga, etc.).
*   **Cross-Platform**: Fully functional on Android, iOS, and Web.

## 🛠 Tech Stack

*   **Frontend**: Flutter (Dart), Provider (State Management)
*   **Backend**: Firebase Authentication & Cloud Firestore
*   **AI Engine**: Google Gemini API (`google_generative_ai`)
*   **Key Packages**: `fl_chart`, `flutter_dotenv`, `google_fonts`, `firebase_core`

## 🚀 Getting Started

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

3.  **Environment Variables (`.env`):**
    Create a `.env` file in the root directory and add your Gemini API key:
    ```env
    GEMINI_API_KEY=your_gemini_api_key_here
    ```

4.  **Firebase Configuration:**
    Ensure you have generated your `firebase_options.dart` file using the FlutterFire CLI if you are connecting to your own backend:
    ```bash
    flutterfire configure
    ```

5.  **Run the app:**
    ```bash
    flutter run
    ```
