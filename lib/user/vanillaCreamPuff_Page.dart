import 'package:flutter/material.dart';
import 'package:project1/profile.dart'; // Make sure to import your ProfilePage

class VanillaCreamPuffPage extends StatefulWidget {
  @override
  _VanillaCreamPuffPageState createState() => _VanillaCreamPuffPageState();
}

class _VanillaCreamPuffPageState extends State<VanillaCreamPuffPage> {
  int quantity = 1;
  final double price = 3.00;

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Vanilla Cream Puff',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/VanillaRegular.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Eu Augue Mauris Trincidunt Aliquam. A Aenean Duis Sollicitudin Urna Fames Pulvinar Amet, At. Id Iaculis Mi Quisque Proin. Commodo Metus Adipiscing Tempor, Feugiat.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decreaseQuantity,
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _increaseQuantity,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'RM${(price).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFf5d9a0),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'OrderSummaryPage',
                  arguments: {
                    'productName': 'Vanilla Cream Puff',
                    'quantity': quantity,
                    'price': price,
                    'imageAsset': 'assets/VanillaRegular.jpg',
                  },
                );
              },
              child: Text(
                'Add to Order',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'homepage');
              break;
            case 1:
              // Add navigation for camera icon if needed
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}
