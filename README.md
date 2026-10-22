# Market Assistant

## Git configuration

```bash
git config user.name "User Name"

git config user.email "mail@domain.com"
```

## Applications

```bash
flutter create --template=app apps/<app_name>

cd apps/<app_name>

flutter run
```

## Packages

```bash
flutter create --template=package packages/<package_name>
```

```yaml
# apps/<app_name>/pubspec.yaml
dependencies:
    # other packages
    <package_name>:
        path: ../../packages/<package_name>
```

```bash
cd apps/<app_name>

flutter pub get
```

## Native platform generation

```bash
# android
flutter create --platforms=android ./apps/<app_name>
```

```bash
# ios
flutter create --platforms=ios ./apps/<app_name>
```

## Documentation

- [Android Wireless debugging](./docs/android_wireless_debugging.md)
- [Project architecture](./docs/project_architecture.md)
