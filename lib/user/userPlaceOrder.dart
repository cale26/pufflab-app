import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userOrderSummary.dart';

class UserPlaceOrderPage extends StatefulWidget {
  final String productName;
  final double price;
  final String description;
  final String imageUrl;

  const UserPlaceOrderPage({
    Key? key,
    required this.productName,
    required this.price,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<UserPlaceOrderPage> createState() => _UserPlaceOrderPageState();
}

class _UserPlaceOrderPageState extends State<UserPlaceOrderPage> {
  int quantity = 1;

  Future<void> addToCart() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('User not logged in. Please log in to continue.')),
      );
      return;
    }

    try {
      double totalAmount = widget.price * quantity;

      await FirebaseFirestore.instance.collection('Order').add({
        'email': user.email,
        'productName': widget.productName,
        'price': widget.price,
        'quantity': quantity,
        'totalAmount': totalAmount,
        'imageUrl': widget.imageUrl,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserOrderSummaryPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: SingleChildScrollView(
        // This allows the content to scroll if it overflows
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                widget.productName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(widget.description),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Text(
                    'RM${(widget.price * quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: addToCart,
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
