# Configure Firebase for Web - Quick Guide

## Step 1: Create/Access Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your existing project OR create a new one

## Step 2: Add Web App

1. In Firebase Console, click the **Web icon** (</>)
2. Register app name: "Flutter Web App"
3. Click "Register app"
4. You'll see a configuration like this:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyAbc123...",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

## Step 3: Update firebase_options.dart

Open `lib/firebase_options.dart` and replace these values in the `web` section:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyAbc123...',           // ← From firebaseConfig.apiKey
  appId: '1:123456789:web:abc123',     // ← From firebaseConfig.appId
  messagingSenderId: '123456789',      // ← From firebaseConfig.messagingSenderId
  projectId: 'your-project-id',        // ← From firebaseConfig.projectId
  authDomain: 'your-project.firebaseapp.com',  // ← From firebaseConfig.authDomain
  storageBucket: 'your-project-id.appspot.com', // ← From firebaseConfig.storageBucket
);
```

## Step 4: Run on Chrome

```bash
flutter run -d chrome
```

---

## Quick Alternative: Run on Windows Desktop (No Web Config Needed)

If you don't want to configure web right now, you can run on Windows desktop:

```bash
flutter run -d windows
```

This will use the Windows configuration which also needs to be set up, but you can test the UI without Firebase first.

---

## Need Android Instead?

If you already have `google-services.json` configured for Android:

1. Start an Android emulator from Android Studio
2. Run: `flutter run`
3. Select the Android device

Android will work immediately with your existing `google-services.json` file!

---

## Where to Get Config Values?

**Firebase Console → Project Settings → Your Apps → Web App → SDK setup and configuration**

Copy the values from the `firebaseConfig` object shown there.
