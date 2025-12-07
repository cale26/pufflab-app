import 'package:flutter/material.dart';
import 'dart:io';
import 'AddProductPage.dart'; // Import the AdminAddOrder page

class AdminViewMenu extends StatelessWidget {
  final File image;
  final String productName;
  final String productDescription;
  final double price;
  final int stockNumber;

  AdminViewMenu({
    required this.image,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.stockNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.file(image,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text('Product Name: $productName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description: $productDescription',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Price: \$${price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Stock Number: $stockNumber', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Product'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
