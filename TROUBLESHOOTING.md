# Firebase Flutter - Troubleshooting Guide

## Common Issues and Solutions

### 1. Firebase Not Initialized Error
**Error**: `[core/no-app] No Firebase App '[DEFAULT]' has been created`

**Solution**:
- Ensure `Firebase.initializeApp()` is called before `runApp()`
- Make sure you have `WidgetsFlutterBinding.ensureInitialized()` before initialization
- Check that `google-services.json` (Android) is in the correct location

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // ← Must be here
  await Firebase.initializeApp();             // ← And here
  runApp(const MyApp());
}
```

---

### 2. google-services.json Not Found
**Error**: `File google-services.json is missing`

**Solution**:
1. Download from Firebase Console → Project Settings → Your Apps
2. Place in: `android/app/google-services.json` (NOT android/)
3. Add to `android/app/build.gradle.kts`:
```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

---

### 3. Authentication Errors

#### User Not Found / Wrong Password
**Error**: `[firebase_auth/user-not-found]` or `[firebase_auth/wrong-password]`

**Solution**:
- Double-check email and password
- Verify Email/Password is enabled in Firebase Console → Authentication
- Check for typos in email (case-sensitive)

#### Weak Password
**Error**: `[firebase_auth/weak-password]`

**Solution**:
- Use passwords with at least 6 characters
- Add validation in your UI:
```dart
validator: (value) {
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
```

---

### 4. Firestore Permission Denied
**Error**: `[cloud_firestore/permission-denied]`

**Solution**:
1. **For Development**: Use test mode rules in Firebase Console
```javascript
allow read, write: if request.time < timestamp.date(2024, 12, 31);
```

2. **For Production**: Implement proper security rules
```javascript
allow read, write: if request.auth != null;
```

3. Make sure user is authenticated before accessing Firestore

---

### 5. Real-Time Updates Not Working
**Problem**: Changes don't appear automatically

**Solutions**:
- Use `snapshots()` instead of `get()`:
```dart
// ❌ Wrong - only fetches once
FirebaseFirestore.instance.collection('tasks').get();

// ✅ Correct - real-time stream
FirebaseFirestore.instance.collection('tasks').snapshots();
```

- Wrap with `StreamBuilder`, not `FutureBuilder`:
```dart
StreamBuilder<QuerySnapshot>(
  stream: firestoreService.getUserTasks(userId),
  builder: (context, snapshot) { ... }
)
```

---

### 6. App Crashes on Startup
**Problem**: App crashes when opening

**Solutions**:
1. Check Flutter and Dart versions are compatible:
```bash
flutter --version
```

2. Clean and rebuild:
```bash
flutter clean
flutter pub get
flutter run
```

3. Check for null safety issues
4. Verify all dependencies are compatible

---

### 7. Gradle Build Failed (Android)
**Error**: `Execution failed for task ':app:processDebugGoogleServices'`

**Solutions**:
1. Update `android/build.gradle.kts`:
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

2. Ensure package name matches in:
   - `android/app/build.gradle.kts`
   - `google-services.json`
   - Firebase Console

3. Run: `flutter clean && flutter pub get`

---

### 8. iOS Build Issues
**Problem**: Build fails on iOS

**Solutions**:
1. Run pod install:
```bash
cd ios
pod install
cd ..
```

2. Update CocoaPods:
```bash
sudo gem install cocoapods
pod repo update
```

3. Open `ios/Runner.xcworkspace` (NOT .xcodeproj)

---

### 9. Firestore Timestamps Not Working
**Problem**: Timestamps showing null or incorrect time

**Solution**:
Use `FieldValue.serverTimestamp()` instead of `DateTime.now()`:
```dart
await tasksCollection.add({
  'title': title,
  'createdAt': FieldValue.serverTimestamp(), // ← Use this
});
```

---

### 10. Storage Upload Fails
**Error**: `[firebase_storage/unauthorized]`

**Solutions**:
1. Enable Firebase Storage in Firebase Console
2. Update Storage rules to allow authenticated users:
```javascript
allow read, write: if request.auth != null;
```
3. Ensure file size doesn't exceed limits
4. Check file path doesn't have special characters

---

### 11. StreamBuilder Shows Loading Forever
**Problem**: CircularProgressIndicator never disappears

**Solutions**:
1. Check connection state properly:
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return CircularProgressIndicator();
}
if (snapshot.hasError) {
  return Text('Error: ${snapshot.error}');
}
if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  return Text('No data');
}
// Show data
```

2. Verify Firestore query is correct
3. Check internet connection
4. Ensure Firestore rules allow read access

---

### 12. Data Not Syncing Between Devices
**Problem**: Changes on one device don't appear on another

**Solutions**:
1. Verify both devices are online
2. Check both are signed in with the same account
3. Ensure queries filter by `userId` correctly:
```dart
.where('userId', isEqualTo: userId)
```
4. Check Firestore rules allow reading other users' data if needed

---

### 13. Hot Reload Not Working
**Problem**: Changes don't appear after hot reload

**Solutions**:
1. Try hot restart: `R` in terminal or click the hot restart button
2. For Firebase changes, always do full restart
3. Clean and rebuild if issues persist

---

### 14. FlutterFire Configure Issues
**Error**: `flutterfire: command not found`

**Solutions**:
1. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Add to PATH (if needed)
3. Alternative: Manual setup using Firebase Console

---

### 15. Version Conflicts
**Error**: Dependency version conflicts

**Solutions**:
1. Update all Firebase packages to compatible versions:
```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0
```

2. Run:
```bash
flutter pub upgrade
```

3. Check compatibility at: https://firebase.flutter.dev/

---

## Debugging Tips

### Enable Firebase Debug Logging
```dart
// In main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Enable debug mode
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  
  runApp(const MyApp());
}
```

### Check Firebase Console Logs
1. Firebase Console → Firestore → Usage tab
2. Monitor read/write operations
3. Check for error patterns

### Use Try-Catch Everywhere
```dart
try {
  await firestoreService.addTask(title, userId);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Success!')),
  );
} catch (e) {
  print('Error: $e');  // ← Always log errors
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
  );
}
```

---

## Getting Help

### Official Resources
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Status Dashboard](https://status.firebase.google.com/)
- [Flutter Discord](https://discord.gg/flutter)

### Community Support
- Stack Overflow: Tag with `firebase` + `flutter`
- GitHub Issues: [FlutterFire Issues](https://github.com/firebase/flutterfire/issues)
- Reddit: r/FlutterDev

---

## Prevention Checklist

Before deployment, verify:
- [ ] Security rules are properly configured
- [ ] Test mode is disabled in production
- [ ] Error handling is implemented everywhere
- [ ] Loading states are shown to users
- [ ] Network errors are caught and displayed
- [ ] Authentication state is properly managed
- [ ] Offline functionality works (Firestore caching)
- [ ] File upload size limits are enforced
- [ ] User feedback is clear and helpful
- [ ] App doesn't crash on Firebase errors

---

**Remember**: Most Firebase issues are configuration-related. Double-check your setup before debugging code!
