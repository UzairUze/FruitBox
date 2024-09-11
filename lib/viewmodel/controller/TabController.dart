import 'package:flutter/cupertino.dart';
import 'package:fruitbox/utils/utils.dart';
import 'package:fruitbox/viewmodel/controller/wishlist/wishlistcontroller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabcontrollerT extends GetxController {
  final wishlistController = Get.put(WishlistController());
  final _fireStore = FirebaseFirestore.instance;

  var selectedTab = 0.obs;
  List<String> tabs = ['Hottest', 'Popular', 'New combo', 'Top'];
  var items = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTabData();
    changeTab(0); // Load the hottest items by default
  }

  /// Method to listen to real-time updates from Firestore
  void getTabData() {
    // Fetch hottest items
    _fireStore.collection('hottest').snapshots().listen((snap) {
      hottestItems.value = snap.docs.map((doc) {
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
      if (selectedTab.value == 0) {
        items.assignAll(hottestItems);
      }
    });

    // Fetch popular items
    _fireStore.collection('popular').snapshots().listen((snap) {
      popularItems.value = snap.docs.map((doc) {
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
      if (selectedTab.value == 1) {
        items.assignAll(popularItems);
      }
    });

    // Fetch new combo items
    _fireStore.collection('newCombo').snapshots().listen((snap) {
      newComboItems.value = snap.docs.map((doc) {
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
      if (selectedTab.value == 2) {
        items.assignAll(newComboItems);
      }
    });

    // Fetch top items
    _fireStore.collection('top').snapshots().listen((snap) {
      topItems.value = snap.docs.map((doc) {
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
      if (selectedTab.value == 3) {
        items.assignAll(topItems);
      }
    });
  }

  /// Toggle function to add or remove a product from the wishlist
  void toggleFavorite(int index) {
    // Toggle the isFavorite status locally
    items[index]['isFavorite'] = !(items[index]['isFavorite'] as bool);
    items.refresh(); // Notify observers of the change

    final bool isFavorite = items[index]['isFavorite'] as bool;
    final String id = items[index]['id'] ?? ''; // Ensure id is not null
    final String collectionName =
        tabs[selectedTab.value].toLowerCase(); // Get the selected tab name

    // Update the isFavorite field in the selected tab's collection in Firebase
    _fireStore
        .collection(collectionName)
        .doc(id)
        .update({'isFavorite': isFavorite});

    if (isFavorite) {
      // Add item to wishlist
      _fireStore.collection('wishlist').add({
        'image': items[index]['image'],
        'isFavorite': true,
        'price': items[index]['price'],
        'title': items[index]['title'],
        'product_id': items[index]['product_id'],
      }).then((value) {
        Utils.toastMessage('Product added to wishlist');
      }).onError((error, stackTrace) {
        Utils.toastMessage('Error: $error');
      });
    } else {
      // Remove item from wishlist
      _fireStore
          .collection('wishlist')
          .where('product_id', isEqualTo: items[index]['product_id'])
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      }).then((value) {
        Utils.toastMessage('Product removed from wishlist');
      }).onError((error, stackTrace) {
        Utils.toastMessage('Error: $error');
      });
    }
  }

  // void toggleFavorite(int index) {
  //   items[index]['isFavorite'] = !(items[index]['isFavorite'] as bool);
  //   items.refresh(); // Notify the observers of the change
  //
  //   if (items[index]['isFavorite'] as bool == true) {
  //     // Add item to wishlist
  //     var id = items[index]['id'];
  //     _fireStore.collection('items').doc(id).update({'isFavorite': true});
  //     _fireStore.collection('wishlist').add({
  //       'image': items[index]['image'],
  //       'isFavorite': true,
  //       'price': items[index]['price'],
  //       'title': items[index]['title'],
  //       'product_id': items[index]['product_id'],
  //     }).then((value) {
  //       Utils.toastMessage('Product added to wishlist');
  //     }).onError((error, stackTrace) {
  //       Utils.toastMessage('Error: $error');
  //     });
  //   } else {
  //     // Remove item from wishlist
  //     _fireStore
  //         .collection('wishlist')
  //         .where('product_id', isEqualTo: items[index]['product_id'])
  //         .get()
  //         .then((snapshot) {
  //       for (DocumentSnapshot doc in snapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     }).then((value) {
  //       Utils.toastMessage('Product removed from wishlist');
  //     }).onError((error, stackTrace) {
  //       Utils.toastMessage('Error: $error');
  //     });
  //   }
  // }

  /// Switch between tabs
  void changeTab(int index) {
    selectedTab.value = index;
    switch (index) {
      case 0:
        items.assignAll(hottestItems);
        break;
      case 1:
        items.assignAll(popularItems);
        break;
      case 2:
        items.assignAll(newComboItems);
        break;
      case 3:
        items.assignAll(topItems);
        break;
    }
  }

  final hottestItems = <Map<String, dynamic>>[].obs;
  final popularItems = <Map<String, dynamic>>[].obs;
  final newComboItems = <Map<String, dynamic>>[].obs;
  final topItems = <Map<String, dynamic>>[].obs;
}

// class TabcontrollerT extends GetxController {
//   final wishlistController = Get.put(WishlistController());
//
//   final _fireStore = FirebaseFirestore.instance;
//   var selectedTab = 0.obs;
//   List<String> tabs = ['Hottest', 'Popular', 'New combo', 'Top'];
//   List<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
//
//   ///getting data from firestore
//   final hottestItems = [
//     {
//       'title': 'Quinoa fruit salad',
//       'price': '₦10,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//     {
//       'title': 'Tropical fruit salad',
//       'price': '₦10,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//   ];
//
//   final popularItems = [
//     {
//       'title': 'Berry mango combo',
//       'price': '₦8,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//     {
//       'title': 'Melon fruit salad',
//       'price': '₦8,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//   ];
//
//   final newComboItems = [
//     {
//       'title': 'Exotic fruit mix',
//       'price': '₦12,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//   ];
//
//   final topItems = [
//     {
//       'title': 'Honey lime combo',
//       'price': '₦2,000',
//       'image': 'assets/images/food1.png',
//       'isFavorite': false.obs,
//     },
//   ];
//
//   ///getting data from firebase store and showing in to gridview.
//   Future<void> getData(
//       String collectionName, List<Map<String, Object>> items) async {
//     try {
//       // Fetch all documents from 'hottest' collection
//       QuerySnapshot snap = await _fireStore.collection(collectionName).get();
//       // Clear the existing hottestItems list
//       items.clear();
//       // Iterate through each document in the collection
//       for (var doc in snap.docs) {
//         var data = doc.data() as Map<String, dynamic>;
//         // Add each document's data to the hottestItems list
//         items.add({
//           'title': data['title'] ?? '',
//           'price': data['price'] ?? '',
//           'image': data['image'] ?? '',
//           'isFavorite': (data['isFavorite'] as bool?)?.obs ?? false.obs,
//         });
//       }
//
//       Utils.toastMessage('Data show Successfully');
//     } catch (e) {
//       Utils.toastMessage(e.toString());
//       print('Error fetching data: $e');
//     }
//   }
//
//   ///in this function I override getdata function 4 times to getting data.
//   Future<void> getgridData() async {
//     /// To fetch data from 'newCombo' collection and store it in newComboItems list
//     await getData('newCombo', newComboItems);
//
//     /// To fetch data from 'top' collection and store it in topItems list
//     await getData('top', topItems);
//
//     ///To fetch data from 'hottest' collection and store it in hottestItems list
//     await getData('hottest', hottestItems);
//
//     ///To fetch data from 'popular' collection and store it in popularItems list
//     await getData('popular', popularItems);
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     getgridData();
//
//     // getData('hottest', hottestItems);
//     items.assignAll(hottestItems); // Load the hottest items by default
//   }
//
//   void changeTab(int index) {
//     selectedTab.value = index;
//     switch (index) {
//       case 0:
//         items.assignAll(hottestItems);
//         break;
//       case 1:
//         items.assignAll(popularItems);
//         break;
//       case 2:
//         items.assignAll(newComboItems);
//         break;
//       case 3:
//         items.assignAll(topItems);
//         break;
//     }
//   }
//
//   void toggleFavorite(int index) {
//     items[index]['isFavorite']?.value =
//         !(items[index]['isFavorite']?.value ?? false);
//   }
// }
