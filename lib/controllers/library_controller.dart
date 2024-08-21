import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LibraryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addToLibrary(BuildContext context, String facultyName,
      String departmentName, String courseName) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      // Retrieve the selected course details from Firestore
      DocumentSnapshot courseSnapshot = await _firestore
          .collection('Faculties')
          .doc(facultyName)
          .collection('Departments')
          .doc(departmentName)
          .collection('Courses')
          .doc(courseName)
          .get();

      // Add the course and its details to the user's library
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('library')
          .doc(courseName)
          .set({
        'facultyName': facultyName,
        'departmentName': departmentName,
        'courseName': courseSnapshot['CourseName'],
        'examImageUrls': courseSnapshot[
            'ExamImageURLs'], // Assuming these fields exist in the course document
        'testImageUrls': courseSnapshot['TestImageURLs'],
        'solutionImageUrls': courseSnapshot['SolutionImageURLs'],
        // Add other course details as needed
      });

      // Show a snackbar message to indicate that the course was added to the library
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course added to library successfully'),
        ),
      );
    } catch (error) {
      print('Error adding course to library: $error');
      throw error;
    }
  }

  Future<List<String>> getUserLibrary() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      // Retrieve the user's library from Firestore
      QuerySnapshot librarySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('library')
          .get();

      // Extract the course names from the library
      List<String> courseNames = librarySnapshot.docs
          .map((doc) => doc['courseName'] as String)
          .toList();

      return courseNames;
    } catch (error) {
      print('Error getting user library: $error');
      throw error;
    }
  }
}


