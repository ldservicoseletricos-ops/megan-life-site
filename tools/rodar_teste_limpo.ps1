cd C:\megan\megan-life-brain-clean\android-app

flutter clean

if (Test-Path ".gradle") { Remove-Item ".gradle" -Recurse -Force }
if (Test-Path "android\.gradle") { Remove-Item "android\.gradle" -Recurse -Force }
if (Test-Path "build") { Remove-Item "build" -Recurse -Force }
if (Test-Path "android\build") { Remove-Item "android\build" -Recurse -Force }
if (Test-Path "android\app\build") { Remove-Item "android\app\build" -Recurse -Force }

flutter pub get
flutter doctor -v
flutter run
