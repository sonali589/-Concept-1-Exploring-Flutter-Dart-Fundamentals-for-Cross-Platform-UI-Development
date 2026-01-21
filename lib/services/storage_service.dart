import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

/// Service class for handling Firebase Storage operations
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload a file to Firebase Storage
  /// [file] - The file to upload
  /// [path] - The storage path (e.g., 'uploads/profile_pictures/user123.jpg')
  /// Returns the download URL of the uploaded file
  Future<String> uploadFile(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }

  /// Upload a file with progress tracking
  /// [file] - The file to upload
  /// [path] - The storage path
  /// [onProgress] - Callback for progress updates (0.0 to 1.0)
  /// Returns the download URL of the uploaded file
  Future<String> uploadFileWithProgress(
    File file,
    String path,
    Function(double) onProgress,
  ) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putFile(file);

      // Listen to progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }

  /// Download a file from Firebase Storage
  /// [path] - The storage path of the file
  /// Returns the download URL
  Future<String> getDownloadUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Error getting download URL: $e';
    }
  }

  /// Delete a file from Firebase Storage
  /// [path] - The storage path of the file to delete
  Future<void> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      throw 'Error deleting file: $e';
    }
  }

  /// List all files in a directory
  /// [path] - The directory path
  /// Returns a list of file references
  Future<List<Reference>> listFiles(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final result = await ref.listAll();
      return result.items;
    } catch (e) {
      throw 'Error listing files: $e';
    }
  }

  /// Get file metadata
  /// [path] - The storage path of the file
  /// Returns metadata including size, content type, creation time, etc.
  Future<FullMetadata> getFileMetadata(String path) async {
    try {
      final ref = _storage.ref().child(path);
      return await ref.getMetadata();
    } catch (e) {
      throw 'Error getting file metadata: $e';
    }
  }

  /// Upload profile picture for a user
  /// Helper method that creates a standardized path for user profile pictures
  Future<String> uploadProfilePicture(File imageFile, String userId) async {
    final path = 'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
    return await uploadFile(imageFile, path);
  }

  /// Upload task attachment
  /// Helper method for uploading task-related files
  Future<String> uploadTaskAttachment(File file, String userId, String taskId) async {
    final extension = file.path.split('.').last;
    final path = 'task_attachments/$userId/$taskId/${DateTime.now().millisecondsSinceEpoch}.$extension';
    return await uploadFile(file, path);
  }
}
