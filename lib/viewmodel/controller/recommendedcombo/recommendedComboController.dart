import 'package:flutter/cupertino.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/wishlist/wishlistcontroller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedComboController extends GetxController {
  final wishlistController = Get.put(WishlistController());
  final _fireStore = FirebaseFirestore.instance;

  var items = <Map<String, dynamic>>[].obs;

  /// Method to listen to real-time updates from Firestore
  void getStoreData() {
    _fireStore.collection('recommendedcombo').snapshots().listen((snap) {
      items.value = snap.docs.map((doc) {
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
      Utils.toastMessage('Store Data show Successfully');
    });
  }

  @override
  void onInit() {
    super.onInit();
    getStoreData();
  }

  /// When a user adds a product to the wishlist, the isFavorite field is set to true in the items collection
  void FavoriteBtn(var documentId) async {
    if (documentId != null && documentId.isNotEmpty) {
      await _fireStore.collection('items').doc(documentId).update({
        'isFavorite': true,
      }).then((value) {
        Utils.toastMessage('Updated Successfully');
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } else {
      Utils.toastMessage('Invalid document ID');
    }
  }

  /// Toggle function to add or remove a product from the wishlist
  void toggleFavorite(int index) {
    items[index]['isFavorite'] = !(items[index]['isFavorite'] as bool);
    items.refresh(); // Notify the observers of the change

    if (items[index]['isFavorite'] as bool == true) {
      // Add item to wishlist
      var id = items[index]['id'];
      print(id);
      FavoriteBtn(id);
      _fireStore.collection('wishlist').add({
        'image': items[index]['image'],
        'isFavorite': true,
        'price': items[index]['price'],
        'title': items[index]['title'],
        'product_id': items[index]['product_id'],
      }).then((value) {
        debugPrint('data added');
        Utils.toastMessage('product add to wishlist');
      }).onError((error, StackTrace) {
        Utils.toastMessage('Error $error');
        debugPrint(error.toString());
      });
    } else {
      // Remove item from wishlist
      FirebaseFirestore.instance
          .collection('wishlist')
          .where('product_id', isEqualTo: items[index]['product_id'])
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
  }
}
