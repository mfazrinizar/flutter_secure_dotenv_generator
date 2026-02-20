# Contributing to flutter_secure_dotenv_generator

Thank you for your interest in contributing! This guide will help you get started.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/<your-username>/flutter_secure_dotenv_generator.git
   ```
3. Install dependencies:
   ```bash
   dart pub get
   ```

### Local Development with flutter_secure_dotenv

During development you may want to test against a local copy of `flutter_secure_dotenv`. Create a `pubspec_overrides.yaml` (git-ignored) in the project root:

```yaml
dependency_overrides:
  flutter_secure_dotenv:
    path: ../flutter_secure_dotenv
```

## Development Workflow

### Branching

- `main` — stable releases published to pub.dev
- `dev` — active development; PRs should target this branch

Create a feature branch from `dev`:

```bash
git checkout -b feature/my-feature dev
```

### Code Quality

Before submitting a PR, make sure all checks pass:

```bash
dart format --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

CI runs these automatically on every push and pull request.

### Tests

All new features and bug fixes **must** include tests. Run the test suite with:

```bash
dart test
```

## Pull Requests

1. Keep PRs focused — one feature or fix per PR.
2. Write clear commit messages.
3. Update `CHANGELOG.md` under an `## Unreleased` section.
4. Ensure CI passes before requesting review.

## Reporting Issues

- Use [GitHub Issues](https://github.com/mfazrinizar/flutter_secure_dotenv_generator/issues).
- Include Dart SDK version, package version, and a minimal reproduction.

## Code of Conduct

Be respectful and constructive in all interactions. We follow the [Dart community guidelines](https://dart.dev/community).
