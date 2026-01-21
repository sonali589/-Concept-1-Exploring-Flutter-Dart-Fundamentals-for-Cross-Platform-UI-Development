# 🚀 Quick Start Guide - Firebase Flutter App

## Prerequisites Checklist
- [ ] Flutter SDK installed (run `flutter doctor` to verify)
- [ ] Android Studio or Xcode installed
- [ ] Firebase account created
- [ ] Code editor (VS Code or Android Studio)

---

## Step-by-Step Setup (10 minutes)

### 1️⃣ Clone/Open Project
```bash
cd "d:\Kalvium\flutter projects\flutter_application_1"
flutter pub get
```

### 2️⃣ Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click **"Add Project"** or **"Create a project"**
3. Project name: `flutter-firebase-demo`
4. Enable/disable Google Analytics (your choice)
5. Click **"Create Project"**

### 3️⃣ Add Android App to Firebase

#### Get Your Package Name
Open: `android/app/build.gradle.kts`
Look for:
```kotlin
applicationId = "com.example.flutter_application_1"
```
Copy this package name.

#### Register App in Firebase
1. In Firebase Console, click the **Android icon** (</>) 
2. Paste the package name: `com.example.flutter_application_1`
3. App nickname (optional): `Flutter Firebase Demo`
4. Click **"Register app"**

#### Download google-services.json
1. Click **"Download google-services.json"**
2. Place the file in: `android/app/google-services.json`
3. **IMPORTANT**: The file must be in `android/app/`, NOT just `android/`

#### Verify File Location
```
flutter_application_1/
└── android/
    └── app/
        └── google-services.json  ← Must be here!
```

### 4️⃣ Enable Firebase Services

#### Enable Authentication
1. Firebase Console → **Build** → **Authentication**
2. Click **"Get Started"**
3. Select **"Email/Password"** from Sign-in methods
4. Toggle **"Email/Password"** to **ENABLED**
5. Click **"Save"**

#### Enable Firestore Database
1. Firebase Console → **Build** → **Firestore Database**
2. Click **"Create Database"**
3. Select **"Start in test mode"** (for development)
4. Choose a region (closest to you for better performance)
5. Click **"Enable"**

**IMPORTANT**: Test mode allows all read/write access. Change rules before production!

#### Enable Storage
1. Firebase Console → **Build** → **Storage**
2. Click **"Get Started"**
3. Select **"Start in test mode"**
4. Choose same region as Firestore
5. Click **"Done"**

### 5️⃣ Verify Setup

#### Check google-services.json Location
```bash
# Windows
dir android\app\google-services.json

# macOS/Linux
ls android/app/google-services.json
```

Should show the file. If not, re-download and place correctly.

#### Check Dependencies
```bash
flutter pub get
```

Should complete without errors.

### 6️⃣ Run the App

#### On Android Emulator
```bash
# Start emulator from Android Studio or:
flutter emulators --launch <emulator_id>

# Run app
flutter run
```

#### On Chrome (Web)
```bash
flutter run -d chrome
```

#### On Physical Device
1. Enable Developer Options on your phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

---

## 🧪 Test Your Setup

### Test 1: Authentication
1. App opens to login screen ✅
2. Click "Don't have an account? Sign Up"
3. Enter email: `test@example.com`
4. Enter password: `password123`
5. Click "Sign Up"
6. Should navigate to Tasks screen ✅
7. Go to Firebase Console → Authentication → Users
8. New user should appear ✅

### Test 2: Real-Time Sync (Single Device)
1. Add task: "Test task 1"
2. Task appears in list ✅
3. Go to Firebase Console → Firestore Database → tasks collection
4. New document appears ✅
5. Edit task in app → Changes reflect in console ✅
6. Delete task → Disappears from console ✅

### Test 3: Real-Time Sync (Multi-Device)
1. Open app on Device 1 → Sign in
2. Open app on Device 2 → Sign in with same account
3. Add task on Device 1
4. Task appears on Device 2 instantly ✅
5. Complete task on Device 2
6. Checkbox updates on Device 1 instantly ✅

**If all tests pass → You're all set! 🎉**

---

## ❌ Troubleshooting Common Issues

### Issue: "No Firebase App '[DEFAULT]' has been created"
**Fix**: 
- Check `main.dart` has Firebase initialization
- Ensure `google-services.json` is in correct location
- Run `flutter clean` then `flutter pub get`

### Issue: "File google-services.json is missing"
**Fix**:
- Download from Firebase Console
- Place in `android/app/google-services.json`
- File name must be exact (case-sensitive)

### Issue: "Permission denied" when accessing Firestore
**Fix**:
- Go to Firebase Console → Firestore Database → Rules
- Ensure rules are in test mode:
```javascript
allow read, write: if request.time < timestamp.date(2025, 12, 31);
```

### Issue: Real-time updates not working
**Fix**:
- Check internet connection
- Verify Firestore rules allow read access
- Make sure using `snapshots()` not `get()`
- Check StreamBuilder is properly implemented

### Issue: Gradle build failed
**Fix**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Still Having Issues?
Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

---

## 📂 Project Structure Overview

```
lib/
├── main.dart                     # App entry + Firebase init
├── services/
│   ├── auth_service.dart         # Authentication logic
│   ├── firestore_service.dart    # Database operations
│   └── storage_service.dart      # File storage
└── screens/
    ├── auth_screen.dart          # Login/Signup UI
    └── tasks_screen.dart         # Tasks list with real-time sync
```

---

## 🎯 Next Steps

### After Setup is Complete:
1. ✅ Read [README.md](README.md) for detailed documentation
2. ✅ Review [VIDEO_WALKTHROUGH_SCRIPT.md](VIDEO_WALKTHROUGH_SCRIPT.md)
3. ✅ Test all features thoroughly
4. ✅ Record your demo video
5. ✅ Update Firebase rules for production (see [firebase_security_rules.txt](firebase_security_rules.txt))

### Before Recording Video:
- [ ] Clear test data from Firestore
- [ ] Test on two devices/emulators
- [ ] Prepare talking points
- [ ] Check screen recording software
- [ ] Review script in VIDEO_WALKTHROUGH_SCRIPT.md

### Before Submitting Assignment:
- [ ] All features working correctly
- [ ] README.md is complete
- [ ] Video is 3-5 minutes
- [ ] Video uploaded to Google Drive
- [ ] Sharing settings: "Anyone with the link can edit"
- [ ] Link tested in incognito mode

---

## 🆘 Getting Help

### Official Documentation
- Firebase for Flutter: https://firebase.flutter.dev/
- Flutter Docs: https://docs.flutter.dev/

### Community Support
- Stack Overflow: Use tags `firebase` + `flutter`
- Flutter Discord: https://discord.gg/flutter
- GitHub Issues: https://github.com/firebase/flutterfire/issues

### Contact Your Instructor
- For assignment-specific questions
- If you're stuck after trying troubleshooting guide

---

## ✅ Final Checklist

Before considering setup complete:
- [ ] Firebase project created
- [ ] Android app registered in Firebase
- [ ] google-services.json in correct location
- [ ] Authentication enabled (Email/Password)
- [ ] Firestore Database enabled (test mode)
- [ ] Storage enabled (test mode)
- [ ] Dependencies installed (`flutter pub get`)
- [ ] App runs without errors
- [ ] Can sign up new user
- [ ] Can sign in with existing user
- [ ] Can add tasks
- [ ] Tasks appear in Firebase Console
- [ ] Real-time sync works between devices
- [ ] All CRUD operations working (Create, Read, Update, Delete)

**All checked? You're ready to create your video walkthrough! 🎬**

---

**Estimated Setup Time**: 10-15 minutes
**Difficulty Level**: Beginner-Friendly
**Support**: See TROUBLESHOOTING.md for detailed help

Good luck! 🚀🔥
