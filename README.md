# Flutter Data Analysis App

![Flutter](https://img.shields.io/badge/Flutter-3.13-blue)
![Firebase](https://img.shields.io/badge/Firebase-Analytics-orange)
![Build Status](https://github.com/jamesbeech123/actions/workflows/flutter.yml/badge.svg)
![License](https://img.shields.io/badge/license-MIT-green)

A **Flutter-based mobile app** for task management, fully integrated with **Firebase Analytics**, with future plans to incorporate **Python-based data analysis** for actionable insights.

## Features

- Add, edit, and delete tasks via an intuitive interface.  
- Automatically log analytics events for every task action: `task_added`, `task_updated`, `task_deleted`.  
- Fully responsive design for Android and iOS.  
- Firebase integration for real-time analytics and potential cloud features.  
- Upcoming: Python analysis to generate insights from user behavior.

## Screenshots

![Task Page](screenshots/task_page.png)


## Getting Started

### Prerequisites

- Flutter SDK >= 3.0  
- Dart >= 3.0  
- Firebase project ([create one here](https://console.firebase.google.com/))  

### Setup

1. Clone the repository:

```bash
git clone https://github.com/jamesbeech123/flutter-data-analysis.git
cd flutter-data-analysis
```


2. Install the dependencies:

```bash
flutter pub get
```

3. Configure Firebase:
- Use the FlutterFire CLI to generate firebase_options.dart

```bash
flutterfire configure
```
- Ensure firebase_options.dart is located in lib/

4. Run the app:

```bash
flutter run
```
## Analytics

The app logs user interactions to Firebase Analytics:

task_added — when a new task is added

task_updated — when an existing task is edited

task_deleted — when a task is deleted

These events will help generate insights in the upcoming Python data analysis module.

## Future Work

- Integrate Python scripts for analyzing user task patterns

- Generate visual reports of task trends

- Provide predictive suggestions based on user behavior

## Tech Stack

Flutter & Dart

Firebase Analytics

Python (planned for data analysis)


