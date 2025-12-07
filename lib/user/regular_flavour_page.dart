import 'package:flutter/material.dart';
import 'vanillaCreamPuff_Page.dart'; // Import the VanillaCreamPuffPage

class RegularFlavourPage extends StatelessWidget {
  final List<Map<String, dynamic>> puffs = [
    {
      "name": "Vanilla Cream Puff",
      "price": 3.00,
      "image": "assets/VanillaRegular.jpg"
    },
    {
      "name": "Chocolate Cream Puff",
      "price": 3.00,
      "image": "assets/ChocolateRegular.jpg"
    },
    {
      "name": "Yam Cream Puff",
      "price": 3.00,
      "image": "assets/VanillaRegular.jpg"
    },
    {
      "name": "Strawberry Cream Puff",
      "price": 3.00,
      "image": "assets/ChocolateRegular.jpg"
    },
    {
      "name": "Rose Cream Puff",
      "price": 3.00,
      "image": "assets/VanillaRegular.jpg"
    },
    {
      "name": "Honeydew Cream Puff",
      "price": 3.00,
      "image": "assets/ChocolateRegular.jpg"
    },
    {
      "name": "Coffee Cream Puff",
      "price": 3.00,
      "image": "assets/VanillaRegular.jpg"
    },
    {
      "name": "Peach Cream Puff",
      "price": 3.00,
      "image": "assets/ChocolateRegular.jpg"
    },
    {
      "name": "Lemon Cream Puff",
      "price": 3.00,
      "image": "assets/VanillaRegular.jpg"
    },
  ];

  RegularFlavourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0), // Light cream background
      appBar: AppBar(
        title: Text(
          'Puff Lab',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: Color(0xFF4A4A4A),
            width: double.infinity,
            child: Text(
              'Regular Flavour',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: puffs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          puffs[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      puffs[index]["name"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'RM${puffs[index]["price"].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      if (puffs[index]["name"] == "Vanilla Cream Puff") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VanillaCreamPuffPage(),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF333333),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
