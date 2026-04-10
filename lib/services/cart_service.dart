import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../features/shop/models/cart_item_model.dart';


class CartFirebaseService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;
  bool get isAuthenticated => _userId != null;

  CollectionReference<Map<String, dynamic>> get _cartCollection => _firestore.collection('Carts');

  DocumentReference<Map<String, dynamic>> get _userCartDoc => _cartCollection.doc(_userId);

  //upload entire cart
  Future<void> syncLocalCartToFirebase(List<CartItemModel> cartItems) async {
    if (!isAuthenticated) return;

    final batch = _firestore.batch();

    final cartData = {
      'items': cartItems.map((item) => item.toJson()).toList(),
      'lastUpdatedAt': FieldValue.serverTimestamp(),
      'itemCount': cartItems.length,
      'totalPrice': cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity)),
    };

    try {
      // await _userCartDoc.set(cartData, SetOptions(merge: true));
      batch.set(_userCartDoc, cartData, SetOptions(merge: true));
      await batch.commit();
    } catch (e) {
      // print('Error syncing cart to Firebase: $e');
    }
  }

  Future<void> mergeAndSync(List<CartItemModel> localCartItems) async {
    if (!isAuthenticated) return;

    try {
      final docSnapshot = await _userCartDoc.get();
      List<CartItemModel> firebaseCartItems = [];

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>? ?? [];
        firebaseCartItems = items.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)).toList();
      }

      // Merge local and Firebase cart items
      final mergedCartItems = [...firebaseCartItems];

      for (var localItem in localCartItems) {
        final index = mergedCartItems.indexWhere((item) => item.productId == localItem.productId);
        if (index != -1) {
          // If item exists in both carts, sum the quantities
          mergedCartItems[index].quantity += localItem.quantity;
        } else {
          // If item only exists in local cart, add it to merged list
          mergedCartItems.add(localItem);
        }
      }
      // Sync the merged cart back to Firebase
      await syncLocalCartToFirebase(mergedCartItems);
    } catch (e) {
      // print('Error merging and syncing cart: $e');
    }
  }
  
  //Download remote cart
  Future<List<CartItemModel>> fetchCartFromFirebase() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    final docRef = _firestore.collection('Carts').doc(uid);
    final snapshot = await docRef.get();
    if(!snapshot.exists) return [];

    final data = snapshot.data() as Map<String, dynamic>;
    final List<dynamic> items = data['items'] ?? [];

    return items.map((json) => CartItemModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  Stream<List<CartItemModel>> cartStream() {
    if (!isAuthenticated) return Stream.value([]);

    return _userCartDoc.snapshots().map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> items = data['items'] ?? [];
      return items.map((json) => CartItemModel.fromJson(json as Map<String, dynamic>)).toList();
    });
  }

  Future<void> clearRemoteCart() async {
    if (!isAuthenticated) return;

    try {
      await _userCartDoc.delete();
    } catch (e) {
      // print('Error clearing remote cart: $e');
    }
  }
}