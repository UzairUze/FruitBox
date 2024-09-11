import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WishlistController extends GetxController {
  RxBool favorite = false.obs;
  // List of items in the wishlist
  var wishlistItems = <Map<String, dynamic>>[].obs;

  final _fireStore = FirebaseFirestore.instance;

  ///getting in realtime data from store database;.
  Future<void> getWishlistData() async {
    try {
      _fireStore.collection('wishlist').snapshots().listen((snapshot) {
        wishlistItems.value = snapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            'title': data['title'] ?? '',
            'price': data['price'] ?? '',
            'image': data['image'] ?? '',
            'product_id': data['product_id'] ?? '',
            'isFavorite': data['isFavorite'] ?? false,
          };
        }).toList();
        Utils.toastMessage('Fetched data successfully');
      });

      ///this code correct.
      // Fetch all documents from 'hottest' collection
      // QuerySnapshot snap = await _fireStore.collection('wishlist').get();
      // wishlistItems.value = snap.docs.map((doc) {
      //   var data = doc.data() as Map<String, dynamic>;
      //   return {
      //     'id': doc.id, // Store the document ID
      //     'title': data['title'] ?? '',
      //     'price': data['price'] ?? '',
      //     'image': data['image'] ?? '',
      //     'product_id': data['product_id'] ?? '',
      //     'isFavorite': data['isFavorite'] ?? false,
      //   };
      // }).toList();

      // Clear the existing hottestItems list
      // wishlistItems.clear();
      // // Iterate through each document in the collection
      // for (var doc in snap.docs) {
      //   var data = doc.data() as Map<String, dynamic>;
      //   // Add each document's data to the hottestItems list
      //   wishlistItems.add({
      //     'title': data['title'] ?? '',
      //     'price': data['price'] ?? '',
      //     'image': data['image'] ?? '',
      //     'isFavorite': (data['isFavorite'] as bool?)?.obs ?? false.obs,
      //   });
      // }

      Utils.toastMessage('fetched data Successfully');
    } catch (e) {
      Utils.toastMessage(e.toString());
      print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getWishlistData();
  }

  // Method to add an item to the wishlist
  void addToWishlist(Map<String, dynamic> item) {
    wishlistItems.add(item);
  }

  ///when user remove any product in wishlist then isFavorite field gone false in  items collections
  void FavoriteBtn(var productId) async {
    await _fireStore
        .collection('items')
        .where('product_id', isEqualTo: productId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        // Update the fields in the document
        doc.reference.update({
          'isFavorite': false, // Update or set any field you want
          // Add other fields here if needed
        }).then((value) {
          Utils.toastMessage('Item favorite update successfully');
        }).catchError((error) {
          Utils.toastMessage('Error updating document: $error');
        });
      }
    }).catchError((error) {
      Utils.toastMessage('Error fetching document: $error');
    });
  }

  // Method to remove an item from the wishlist in realtime
  void removeFromWishlist(
    String productId,
  ) async {
    debugPrint(productId);
    FavoriteBtn(productId);
    await _fireStore
        .collection('wishlist')
        .where('product_id', isEqualTo: productId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    }).then((value) {
      debugPrint('product remove');
      Utils.toastMessage('product remove from wishlist');
    }).onError((error, StackTrace) {
      Utils.toastMessage('Error $error');
      debugPrint(error.toString());
    });
  }

  ///add products into wishlist
  // void toggleFavorite(int index) {
  //   // items[index]['isFavorite']?.value =
  //   // !(items[index]['isFavorite']?.value ?? false);
  //
  //   addToWishlist({
  //     'image': 'assets/images/food1s.png',
  //     'title': 'Beosound A1',
  //     'review': 4.8,
  //     'price': 650,
  //     'product_id': '1',
  //   });
  // }
}
