import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fruitbox/view/auth/login.dart';
import 'package:fruitbox/view/auth/verfiy_number.dart';
import 'package:fruitbox/view/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../resources/routes/routename.dart';
import '../../../utils/utils.dart';

class authViewModel extends GetxController {
  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final verifyCodeController = TextEditingController().obs;

  final addPostController = TextEditingController().obs;
  final updatePostController = TextEditingController().obs;
  final fetchPostController = TextEditingController().obs;
  final addFSPostController = TextEditingController().obs;
  final updatePostFSController = TextEditingController().obs;

  final forgetController = TextEditingController().obs;
  final forgetFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  var username = ''.obs;
  var useremail = ''.obs;

  final RxBool loading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  ///firestore instance
  final _firestore = FirebaseFirestore.instance;

  ///Clear the Text Editing controller
  void clearTEC() {
    emailController.value.clear();
    passwordController.value.clear();
    usernameController.value.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsername();
  }

  ///fetch the username from the firebase
  void fetchUsername() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String email = currentUser.email!;
      useremail.value = email;
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs.first;
          username.value = userDoc['username'] ?? 'No username available';
        } else {
          username.value = 'No user found';
        }
      } catch (e) {
        username.value = 'Error: ${e.toString()}';
      }
    } else {
      username.value = 'Loading..';
    }
  }

  ///login with firebase
  Future<void> login() async {
    loading.value = true;
    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      Utils.toastMessage('✅Login Successfully');
      loading.value = false;

      // Navigate to Welcome screen after successful login
      Get.to(() => WelcomeScreen());

      // Clear the text fields
      emailController.value.clear();
      passwordController.value.clear();
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Utils.toastMessage('Invalid email or password.');
      } else {
        Utils.toastMessage('An error occurred: ${e.code}');
      }
      debugPrint(e.toString());
    } catch (error) {
      loading.value = false;
      Utils.toastMessage(error.toString());
      debugPrint(error.toString());
    }
  }

  ///Signup with firebase or store user name or email
  Future<void> signup() async {
    loading.value = true;
    try {
      // Create user with email and password
      UserCredential value = await _auth.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      // Get the current user's UID
      String uid = value.user!.uid;

      // Create a new document in the "users" collection with the user's UID
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': emailController.value.text,
        'username': usernameController
            .value.text, // Assuming you have a usernameController
      });

      Utils.toastMessage('✅Signup Successfully');
      loading.value = false;

      // Navigate to Welcome screen after successful signup
      Get.to(() => WelcomeScreen());

      // Clear the text fields
      emailController.value.clear();
      passwordController.value.clear();
      usernameController.value.clear();
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'email-already-in-use') {
        Utils.toastMessage('The email address is already in use.');
      } else {
        Utils.toastMessage('An error occurred: ${e.code}');
      }
      debugPrint(e.toString());
    } catch (error) {
      loading.value = false;
      Utils.toastMessage(error.toString());
      debugPrint(error.toString());
    }
  }

  // void signup() {
  //   loading.value = true;
  //   _auth
  //       .createUserWithEmailAndPassword(
  //           email: emailController.value.text,
  //           password: passwordController.value.text)
  //       .then((value) {
  //     // Get the current user's UID
  //     String uid = value.user!.uid;
  //
  //     /// Create a new document in the "users" collection with the user's UID
  //     FirebaseFirestore.instance.collection('users').doc(uid).set({
  //       'email': emailController.value.text,
  //
  //       /// Add more fields as needed, such as 'username'
  //       'username': usernameController
  //           .value.text, // Assuming you have a usernameController
  //     }).then((_) {
  //       Utils.toastMessage('✅Signup Successfully');
  //       loading.value = false;
  //       Get.to(() =>
  //           WelcomeScreen()); // Navigate to Welcome screen after successful signup
  //       emailController.value.clear();
  //       passwordController.value.clear();
  //       usernameController.value.clear(); // Clear the username field
  //     }).catchError((error) {
  //       debugPrint(error.toString());
  //       loading.value = false;
  //       Utils.toastMessage(error.toString());
  //     });
  //   }).onError((error, StackTrace) {
  //     debugPrint(error.toString());
  //     loading.value = false;
  //     Utils.toastMessage(error.toString());
  //   });
  // }

  ///logout function
  void logout() {
    _auth.signOut().then((_) {
      Utils.toastMessage('✅Logout successfully');
      Get.toNamed(Routename.splashScreen); // Navigate to the login screen
    }).onError((error, StackTrace stackTrace) {
      debugPrint(error.toString());
      Utils.toastMessage('Error logging out: ${error.toString()}');
    });
  }

  ///login with google account
  signwithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth!.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    debugPrint(userCredential.user?.displayName);
    if (userCredential != null) {
      //  Get.toNamed(Routename.homeView);
    }
  }

  ///login with phone number
  void signwithNumber() {
    try {
      loading.value = true;
      _auth.verifyPhoneNumber(
        phoneNumber: phoneController.value.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          loading.value = false;
          Utils.toastMessage(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          loading.value = false;
          Get.to(() => VerifyCodeScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (e) {
          loading.value = false;
          Utils.toastMessage(e.toString());
        },
      );
    } catch (e) {
      loading.value = false;
      Utils.toastMessage('An error occurred: $e');
    }
  }

  ///verify with code
  verifyCode(String verifyId) async {
    loading.value = true;
    final credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: verifyCodeController.value.text.toString());
    try {
      loading.value = false;
      await _auth.signInWithCredential(credential);
      loading.value = false;
      // Get.toNamed(Routename.homeView);
      Utils.toastMessage('Login Successfully');
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Utils.toastMessage(e.toString());
    }
  }

  ///add post function
  addPost() {
    loading.value = true;

    ///Creating id varible and store time in millisecond.
    ///when we assign post id or child id then its same.
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    ///adding data
    databaseRef.child(id).set({
      'Title': addPostController.value.text,
      'id': id,
    }).then((value) {
      Utils.toastMessage('Post Successfully');
      loading.value = false;
      addPostController.value.clear();
    }).onError((error, StackTrace) {
      Utils.toastMessage(error.toString());
      loading.value = false;
    });
  }

  ///showDialog for updating post
  Future<void> showDialogUpdate(String title, String id) async {
    updatePostController.value.text = title;
    Get.dialog(
      AlertDialog(
        title: Text('Update!'),
        content: Container(
          child: TextFormField(
            controller: updatePostController.value,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                databaseRef.child(id).update({
                  'Title': updatePostController.value.text.toString(),
                }).then((value) {
                  Utils.toastMessage('Updated Successfully');
                }).onError((error, StackTrace) {
                  Utils.toastMessage(error.toString());
                });
              },
              child: Text('Update')),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel')),
        ],
      ),
    );
  }

  Future<void> showDialogDel(String id) async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete!'),
        content: Text('Are you sure want to delete?'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                databaseRef.child(id).remove().then((value) {
                  Utils.toastMessage('Deleted Successfully');
                }).onError((error, stackTrace) {
                  Utils.toastMessage(error.toString());
                });
              },
              child: Text('Delete')),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel')),
        ],
      ),
    );
  }

  addFirestoreData() {
    loading.value = true;
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    _firestore.doc(id).set({
      'Title': addFSPostController.value.text.toString(),
      'id': id,
    }).then((value) {
      addFSPostController.value.clear();
      loading.value = false;
      Utils.toastMessage('Post Successfully');
    }).onError((error, StackTrace) {
      Utils.toastMessage(error.toString());
      loading.value = false;
    });
  }

  ///update data in firestore
  // Future<void> showDialogUpdateFS(String title, String id) async {
  //   updatePostFSController.value.text = title;
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text('Update!'),
  //       content: Container(
  //         child: TextFormField(
  //           controller: updatePostFSController.value,
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Get.back();
  //               _firestore.doc(id).update({
  //                 'Title': updatePostFSController.value.text.toString(),
  //               }).then((value) {
  //                 Utils.toastMessage('Updated Successfully');
  //               }).onError((error, stackTrace) {
  //                 Utils.toastMessage(error.toString());
  //               });
  //             },
  //             child: Text('Update')),
  //         TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: Text('Cancel')),
  //       ],
  //     ),
  //   );
  // }
  //
  // Future<void> showDialogDelFS(String id) async {
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text('Delete!'),
  //       content: Text('Are you sure want to delete?'),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Get.back();
  //               _firestore.collection('users').doc(id).delete().then((value) {
  //                 Utils.toastMessage('Deleted Successfully');
  //               }).onError((error, stackTrace) {
  //                 Utils.toastMessage(error.toString());
  //               });
  //             },
  //             child: Text('Delete')),
  //         TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: Text('Cancel')),
  //       ],
  //     ),
  //   );
  // }

  ///forget password function
  forgetPassword() {
    loading.value = true;
    _auth
        .sendPasswordResetEmail(email: forgetController.value.text.toString())
        .then((value) {
      loading.value = false;
      Utils.toastMessage('✅Send link to email');
      forgetController.value.clear();
      Get.toNamed(Routename.authScreen);
    }).onError((error, StackTrace) {
      Utils.toastMessage(error.toString());
      loading.value = false;
      forgetController.value.clear();
    });
  }
}
