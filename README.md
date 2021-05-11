# Go!

Create an activity and get together with your friends!

## Getting Started

This project is using DDD [(Domain Driven Design)](https://resocoder.com/2020/03/09/flutter-firebase-ddd-course-1-domain-driven-design-principles/) with a personal slight modification in the infrastructure layer.

![DDD](./assets/images/readme/DDD.png)


## How to use

This project is a normal flutter project, so, before running make sure you have the Flutter sdk installed. You can follow this [guide](https://flutter.dev/docs/get-started/install) to get it done.

Then:

1. Clone this repository
2. This project is using the stable channel of the Flutter SDK, today:

![version](./assets/images/readme/flutter_version.png)

3. Get dependencies with 
```
flutter pub get
```
4. run the project with
```
flutter run
```

## Test
This project have a few tests. You can run the tests with:
```
flutter test
```

Also, you can generate a file to evaluate the test coverage. 
```
flutter test --coverage
```
The above command will generate the coverage/lcov.info file, which can be used to generate a visual report.

## Coverage Report
** Only for mac

To generate a graphic report to see the test coverage, follow the following steps:

- Install lcov:
```
brew install lcov
```

- Generate the report with the following command: (Note: the report is filled with the data present in the lcov.info file generated on the previous step)
```
genhtml coverage/lcov.info -o coverage/html
```

- The report is generated in the folder coverage/html. Open the index.html file with your web browser to see the report.


For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
