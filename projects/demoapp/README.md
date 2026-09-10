# Flutter Concepts Lab

Flutter Concepts Lab is a small Flutter application demonstrating three core Flutter concepts in one app:

- Accepting and validating user input with forms
- Displaying local images and applying a custom font
- Creating an interactive animation with `AnimatedContainer`

## Screens

The home screen uses named routes to navigate to each demonstration:

### User Input & Forms

Demonstrates:

- `Form` and `GlobalKey<FormState>`
- `TextFormField`
- `TextEditingController`
- `InputDecoration`
- Field validators and validation messages
- Form submission with a `SnackBar`

### Images, Assets & Fonts

Displays seven local landscape images in a `GridView.count`. The images are loaded with `Image.asset()` from `assets/images/`.

The application uses the local `RobotoSlab` font configured in `pubspec.yaml`:

```yaml
fonts:
	- family: RobotoSlab
		fonts:
			- asset: assets/fonts/RobotoSlab-VariableFont_wght.ttf
```

### AnimatedContainer

The animation screen includes a button that changes the container's:

- Width and height
- Color
- Border radius
- Shadow

The changes are animated with `AnimatedContainer` and an easing curve.

## Project Structure

```text
lib/main.dart                         Application and screen implementations
assets/images/                        Local gallery images
assets/fonts/                         Custom RobotoSlab font
test/widget_test.dart                 Navigation, form, and animation tests
pubspec.yaml                          Asset and font configuration
```

## Run the App

From the `demoapp` directory:

```bash
flutter pub get
flutter run
```

## Test and Analyze

```bash
flutter test
flutter analyze
```

## Requirements

- Flutter SDK with Dart 3.13 or newer
- A configured Flutter target such as Chrome, Android, iOS, macOS, Linux, or Windows

##Images 

