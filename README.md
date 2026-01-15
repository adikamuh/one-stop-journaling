# One Stop Journaling

## About

one_stop_journaling is a Flutter app for creating, organizing, and reviewing personal journal entries in one place. It focuses on a clean UI, local persistence, and calendar-based navigation to help users build consistent journaling habits.

**Features:**

- **Create & Edit Entries:** Add rich text entries with timestamps.
- **Calendar View:** Browse entries by date with an integrated calendar.
- **Local Persistence:** Fast local storage for offline access.
- **Lightweight State Management:** Uses `bloc` and `flutter_bloc` for predictable state flow.

**Project Structure (overview):**

- **`lib/`**: Main application code.
  - **`core/`**: Dependency injection, shared services, and utilities.
  - **`features/`**: Feature modules (e.g., `home`, `journal`, `settings`).
  - **`main.dart`**: App entrypoint.
- **`assets/`**: Images, icons, and other static assets.

**Requirements:**
| Platform | Minimum Version |
|----------|-----------------|
| Flutter | 3.38.2 |
| Dart | 3.10 |

## Getting Started

Run the following to generate code and fetch packages:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter pub get
```

For platform-specific setup and running, use the standard Flutter commands such as `flutter run` and `flutter build` for your target platform.
