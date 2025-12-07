import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  // Save product data to Firestore
  Future<DocumentReference<Map<String, dynamic>>> saveProductData(
      Map<String, dynamic> data) async {
    return _firestore.collection("products").add({
      'name': data['name'],
      'description': data['description'],
      'price': data['price'],
      'stockNumber': data['stockNumber'],
      'imageUrl': data['imageUrl'],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Read all products
  Stream<QuerySnapshot> readProducts() {
    return _firestore.collection("products").snapshots();
  }

  // Get the URL of the last uploaded file
  Future<String?> getLastUploadedFileUrl() async {
    if (currentUser == null) {
      throw Exception("No user is logged in");
    }

    final querySnapshot = await _firestore
        .collection("user-files")
        .doc(currentUser!.uid)
        .collection("uploads")
        .orderBy("created_at", descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get("url");
    }
    return null;
  }

  // Save uploaded file metadata to Firestore
  Future<void> saveUploadedFilesData(Map<String, String> fileData) async {
    if (currentUser == null) {
      throw Exception("No user is logged in");
    }

    await _firestore
        .collection("user-files")
        .doc(currentUser!.uid)
        .collection("uploads")
        .add(fileData);
  }

  // Get a single product by ID
  Future<DocumentSnapshot> getProductById(String productId) {
    return _firestore.collection("products").doc(productId).get();
  }

  // Update a product
  Future<void> updateProduct(String productId, Map<String, dynamic> data) {
    return _firestore.collection("products").doc(productId).update({
      'name': data['name'],
      'description': data['description'],
      'price': data['price'],
      'stockNumber': data['stockNumber'],
      'imageUrl': data['imageUrl'],
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete a product
  Future<void> deleteProduct(String productId) {
    return _firestore.collection("products").doc(productId).delete();
  }
}
