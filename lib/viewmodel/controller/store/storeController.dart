import 'package:flutter/cupertino.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/wishlist/wishlistcontroller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class storeController extends GetxController {
  final wishlistController = Get.put(WishlistController());
  final _fireStore = FirebaseFirestore.instance;
  // List<Map<String, dynamic>> Storeitems = <Map<String, dynamic>>[].obs;

  var items = <Map<String, dynamic>>[].obs;

  ///getting data from store database;.
  Future<void> getStoreData() async {
    try {
      // Fetch all documents from 'hottest' collection
      QuerySnapshot snap = await _fireStore.collection('items').get();
      // Clear the existing hottestItems list
      items.value = snap.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id, // Store the document ID
          'title': data['title'] ?? '',
          'price': data['price'] ?? '',
          'image': data['image'] ?? '',
          'product_id': data['product_id'] ?? '',
          'isFavorite': data['isFavorite'] ?? false,
        };
      }).toList();

      // Storeitems.clear();
      // Iterate through each document in the collection
      // for (var doc in snap.docs) {
      //   var data = doc.data() as Map<String, dynamic>;
      //   // Add each document's data to the hottestItems list
      //   Storeitems.add({
      //     'title': data['title'] ?? '',
      //     'price': data['price'] ?? '',
      //     'image': data['image'] ?? '',
      //     'isFavorite': (data['isFavorite'] as bool?)?.obs ?? false.obs,
      //   });
      // }

      Utils.toastMessage('Store Data show Successfully');
    } catch (e) {
      Utils.toastMessage(e.toString());
      print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStoreData();
  }

  ///when user add any product in wishlist then isFavorite field gone true in  items collections
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

  ///toggle function for add or remove product from wishlist
  void toggleFavorite(int index) {
    items[index]['isFavorite'] = !(items[index]['isFavorite'] as bool);
    items.refresh(); // Notify the observers of the change

    // Storeitems[index]['isFavorite']?.value =
    //     !(Storeitems[index]['isFavorite']?.value ?? false);

    // Add or remove from the wishlist
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
