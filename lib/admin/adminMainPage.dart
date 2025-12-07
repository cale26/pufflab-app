import 'package:flutter/material.dart';
import 'package:project1/loginAdmin.dart';
import 'AddProductPage.dart';
import 'cloudHomePage.dart';
import 'AdminNewOrder.dart';
import 'adminViewReview.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 1; // Default to home (middle button)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on index
    switch (index) {
      case 0: // Receipt/Orders
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NewOrderPage()),
        );
        break;
      case 1: // Home
        // Already on home page, do nothing or refresh
        break;
      case 2: //review
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AdminViewReview()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E7D7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Puff Lab',
          style: TextStyle(
            fontFamily: 'Cursive',
            color: Color(0xFFFFF3E0),
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFFFF3E0)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginAdminPage()),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Customer Order',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewOrderPage()),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              title: 'Launch Product',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddProductPage()),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              title: 'Product Catalog',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductCatalogPage()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.receipt_outlined, 0),
            _buildNavItem(Icons.home_outlined, 1),
            _buildNavItem(Icons.comment, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFFFFF3E0), width: 2)
              : null,
        ),
        child: Icon(
          icon,
          color: const Color(0xFFFFF3E0),
          size: 24,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0), // Cream color
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.receipt_outlined, null),
          _buildNavItem(Icons.home_outlined, null),
          _buildNavItem(Icons.comment, null),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String? label) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xFFFFF3E0),
        size: 24,
      ),
    );
  }
}
