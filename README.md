# Student Profile App (Flutter)

## Abstract

The Student Profile App is a cross-platform mobile application developed using **Flutter** to provide an efficient and user-friendly solution for managing student information. The application enables students to create, update, and maintain their personal, academic, and professional profiles in a centralized and secure environment. It includes features such as profile management, academic details, attendance, skills, certifications, achievements, and document uploads.

The app uses Flutter's modern UI framework to deliver a responsive and consistent user experience on both Android and iOS devices from a single codebase. A backend database, such as Firebase or another cloud service, can securely store student data and provide real-time synchronization and authentication. Faculty and administrators can access authorized student information, verify records, and monitor academic progress through role-based access control.

## Experiments 1–10

### Experiment 1 — Dart Basics
Variables, data types, arithmetic operations, string interpolation and conditional statements.

**Output:**

![Experiment 1 Output](outputs/exp1_output.svg)

### Experiment 2 — Flutter Widgets and Layouts
Uses Flutter widgets with **Row**, **Column** and **Stack** to build a student profile interface.

**Output:**

![Experiment 2 Output](outputs/exp2_output.svg)

### Experiment 3 — Responsive UI
Uses **MediaQuery** and tablet/desktop breakpoints to adapt the profile layout to different screen sizes.

**Output:**

![Experiment 3 Output](outputs/exp3_output.svg)

### Experiment 4 — Navigation and Named Routes
Uses **Navigator.pushNamed()**, named route constants and multiple screens for profile navigation.

**Output:**

![Experiment 4 Output](outputs/exp4_output.svg)

### Experiment 5 — Stateful & Stateless Widgets + State Management
Demonstrates **StatelessWidget**, **StatefulWidget**, **setState()**, and **Provider** using ChangeNotifier and notifyListeners() for counter state management.

**Output:**

![Experiment 5 Output](outputs/exp5_output.svg)

### Experiment 6 — Custom Widgets and Themes
Creates reusable custom widgets for profile UI elements and applies styling through **ThemeData**, custom text styles, card styles and reusable button styling.

**Output:**

![Experiment 6 Output](outputs/exp6_output.svg)

### Experiment 7 — Forms, Validation and Error Handling
Designs a student registration form with multiple input fields and implements form validation, field-level error messages and submission error handling using **Form**, **GlobalKey<FormState>**, **TextFormField** and **SnackBar**.

**Output:**

![Experiment 7 Output](outputs/exp7_output.svg)

### Experiment 8 — Animations
Uses Flutter's animation framework with **AnimationController**, **FadeTransition** and **SlideTransition**. The animation can be replayed using a button.

**Output:**

![Experiment 8 Output](outputs/exp8_output.svg)

### Experiment 9 — REST API Integration
Fetches album data from the public **JSONPlaceholder REST API** using an HTTP GET request. It parses JSON into Dart objects and displays the records with **FutureBuilder**, loading and error states, and a refresh/retry action.

**Output:**

![Experiment 9 Output](outputs/exp9_output.svg)

**Dependency:** Run `flutter pub add http` in a Flutter project before running this experiment.

### Experiment 10 — Testing and Debugging in Flutter
Writes widget tests for reusable UI components and student-form validation, and demonstrates Flutter debugging tools including Flutter Inspector, DevTools, IDE breakpoints, console logging, and common verification commands. Automated UI tests are maintained in `test/exp10_testing_debugging_test.dart`.

**Output:**

![Experiment 10 Output](outputs/exp10_output.svg)

**Run the example:** `flutter run -t experiments/10_testing_debugging.dart` (or open the file in your Flutter project and run it as the entry point).

## Experiment Files

```text
experiments/
├── 01_dart_basics.dart
├── 02_widgets_layouts.dart
├── 03_responsive_ui.dart
├── 04_navigation_named_routes.dart
├── 05_setstate_counter.dart
├── 05_state_management.dart
├── 06_custom_widgets_themes.dart
├── 07_forms_validation.dart
├── 08_animations.dart
├── 09_rest_api.dart
├── 10_testing_debugging.dart
└── counter_provider.dart
```

## Automated UI Tests

Run the widget tests with:

```bash
flutter test
flutter analyze
```

The Experiment 10 tests verify the reusable profile header, student-form validation messages, and navigation to the testing/debugging screen. GitHub Actions runs dependency resolution, static analysis, and widget tests on pushes to `main`, pull requests, and manual workflow dispatches.


## Run the Student Profile App as a Website (Flutter Web)

The default app screen is a responsive student dashboard with Overview, Education, Skills, Projects, Achievements, Contact, and the Experiment 1–10 learning lab.

### Requirements
- Flutter SDK (stable channel)
- Chrome browser
- VS Code or another editor (optional)

### Run locally
From the repository root:

```bash
flutter doctor
flutter pub get
flutter devices
flutter run -d chrome
```

If Chrome is not listed, enable web support and retry:

```bash
flutter config --enable-web
flutter devices
flutter run -d chrome
```

To build a deployable website bundle:

```bash
flutter build web --release
```

The generated website files are placed in `build/web/`. Deploy that folder to a static hosting service.

### Personalise before publishing
- Update the student name, education and profile details in `StudentDashboard` in `lib/main.dart`.
- Replace the Email, GitHub and LinkedIn button SnackBar callbacks with your actual contact links.
- Add real demo/repository URLs to the project cards.
- Review achievements and only publish details you want to share publicly.

### Verify the project

```bash
flutter analyze
flutter test
```
