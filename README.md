# 🌱 Streak Keeper

A simple goal and habit tracking app built with Flutter.  
Streak Keeper helps users create goals, maintain daily streaks, and track their progress over time.

## 📱 Features

- Create personal goals
-  Edit existing goals
-  Delete goals
-  Track daily streaks
-  Mark goals as completed for the day
-  View progress and streak statistics
-  Local data storage using Hive
-  Clean and minimal green-themed UI

##  Screens

### My Journey
- Add and manage your goals
- Swipe actions for editing and deleting goals

### Today's Goals
- View your daily tasks
- Swipe to mark goals as completed

### Progress
- Expand goals to view:
  - Current streak
  - Highest streak
  - Today's completion status

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Hive Database**
- **Google Fonts**
- **Flutter Slidable**

## 📂 Project Structure

```text
streak_keeper/
│
├── android/
├── ios/
├── assets/
│
├── lib/
│   │
│   ├── data/
│   │   └── journey_database.dart
│   │
│   ├── pages/
│   │   ├── homepage.dart
│   │   ├── today_page.dart
│   │   ├── journey_page.dart
│   │   └── progress_page.dart
│   │
│   ├── util/
│   │   ├── dialog_box.dart
│   │   ├── journey_tile.dart
│   │   └── today_tile.dart
│   │
│   └── main.dart
│
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites

Make sure you have:

- Flutter SDK installed
- Android Studio / VS Code
- Android device or emulator

### Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/streak_keeper.git

Navigate into the project:

cd streak_keeper

Install dependencies:

flutter pub get

Run the app:

flutter run
