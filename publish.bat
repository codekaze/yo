@REM Required:
@REM flutter pub global activate pubspec_version

cmd /c cider bump minor 
git add .
git commit -m "Set new version"
git push --force
flutter pub publish --force