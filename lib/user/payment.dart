import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'orderConfirmation.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? userEmail;
  String selectedPaymentMethod = 'Online Banking'; // Default payment method

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Online Banking'),
                leading: Radio<String>(
                  value: 'Online Banking',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Cash at Counter'),
                leading: Radio<String>(
                  value: 'Cash at Counter',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: userEmail == null
          ? Center(child: Text("Error: User not logged in"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Order')
                  .where('email', isEqualTo: userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  double totalAmount = snapshot.data!.docs.fold(
                      0,
                      (sum, doc) =>
                          sum +
                          (doc.data() as Map<String, dynamic>)['totalAmount']);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Confirm & Pay',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[300],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pick up at the store',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Lakeview Cafe,\nUniversiti Malaysia Sarawak, Jln Datuk\nMohammad Musa, 94300 Kota Samarahan,\nSarawak',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Standard (15 mins)',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var order = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              return Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        order['imageUrl'],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order['productName'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'RM${order['price'].toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('x${order['quantity']}'),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Summary',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Subtotal'),
                                    Text('RM${totalAmount.toStringAsFixed(2)}'),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'RM${totalAmount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: _showPaymentMethodDialog,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedPaymentMethod,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (userEmail == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error: User not logged in')),
                                  );
                                  return;
                                }

                                try {
                                  final orders = snapshot.data!.docs.map((doc) {
                                    final data =
                                        doc.data() as Map<String, dynamic>;
                                    return {
                                      'email': userEmail,
                                      'imageUrl': data['imageUrl'],
                                      'paymentMethod': selectedPaymentMethod,
                                      'price': data['price'],
                                      'productName': data['productName'],
                                      'quantity': data['quantity'],
                                      'subtotal':
                                          data['price'] * data['quantity'],
                                      'totalAmount': totalAmount,
                                      'transactionID':
                                          DateTime.now().millisecondsSinceEpoch,
                                      'timestamp': FieldValue.serverTimestamp(),
                                    };
                                  }).toList();

                                  WriteBatch batch =
                                      FirebaseFirestore.instance.batch();
                                  final transactionCollection =
                                      FirebaseFirestore.instance
                                          .collection('transaction');

                                  for (var order in orders) {
                                    batch.set(
                                        transactionCollection.doc(), order);
                                  }

                                  await batch.commit();

                                  String message = selectedPaymentMethod ==
                                          'Online Banking'
                                      ? 'Payment successful!'
                                      : 'Order confirmed! Please pay at the counter.';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderConfirmationPage(orders: orders),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error: ${e.toString()}')),
                                  );
                                }
                              },
                              child: Text(
                                selectedPaymentMethod == 'Online Banking'
                                    ? 'Pay Now'
                                    : 'Confirm Order',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFE4C4),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'UserMenuPage');
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}

// This line indicate the Major Change for SCM Project purpose
