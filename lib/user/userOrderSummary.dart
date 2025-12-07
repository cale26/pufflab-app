import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/userMenu.dart';
import 'payment.dart';
import 'profile.dart';

class UserOrderSummaryPage extends StatefulWidget {
  const UserOrderSummaryPage({Key? key}) : super(key: key);

  @override
  State<UserOrderSummaryPage> createState() => _UserOrderSummaryPageState();
}

class _UserOrderSummaryPageState extends State<UserOrderSummaryPage> {
  String? userEmail;
  int _selectedIndex = 0; // Declare and initialize _selectedIndex

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Order')
          .doc(orderId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("product deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete product: $e")),
      );
    }
  }

  Future<void> updateQuantity(
      String orderId, int newQuantity, double price) async {
    if (newQuantity < 1) return; // Prevent quantity from going below 1
    try {
      double newTotalAmount = price * newQuantity;
      await FirebaseFirestore.instance.collection('Order').doc(orderId).update({
        'quantity': newQuantity,
        'totalAmount': newTotalAmount,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update quantity: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: userEmail == null
          ? Center(child: Text("Error: User not logged in"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Order')
                  .where('email', isEqualTo: userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var orders = snapshot.data!.docs;
                  double totalAmount = orders.fold(0, (sum, doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return sum + (data['totalAmount'] ?? 0);
                  });

                  if (orders.isEmpty) {
                    return Center(child: Text("Empty Cart."));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            var order =
                                orders[index].data() as Map<String, dynamic>;
                            String orderId = orders[index].id;

                            return ListTile(
                              leading: Image.network(order['imageUrl'],
                                  width: 50, height: 50),
                              title: Text(order['productName']),
                              subtitle: Row(
                                children: [
                                  Text(
                                      'RM${order['price']} x ${order['quantity']}'),
                                  Spacer(),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () => updateQuantity(
                                          orderId,
                                          order['quantity'] - 1,
                                          order['price'],
                                        ),
                                      ),
                                      Text(order['quantity'].toString(),
                                          style: TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () => updateQuantity(
                                          orderId,
                                          order['quantity'] + 1,
                                          order['price'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteOrder(orderId),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Total: RM${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Add more"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFF2E3D5)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PaymentPage()),
                                    );
                                  },
                                  child: Text("Checkout"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF2E3D5), // Peach/beige color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserMenuPage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserOrderSummaryPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                break;
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor:
              const Color.fromARGB(255, 94, 94, 94).withOpacity(0.5),
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
      ),
    );
  }
}
