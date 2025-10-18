import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final List<Map<String, dynamic>> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  void _addOrEditItem({int? index}) {
    bool isEdit = index != null;
    if (isEdit) {
      _nameController.text = _items[index]['name'];
      _qtyController.text = _items[index]['qty'].toString();
    } else {
      _nameController.clear();
      _qtyController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah (Qty)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text.trim();
                String qty = _qtyController.text.trim();
                if (name.isNotEmpty && qty.isNotEmpty) {
                  setState(() {
                    if (isEdit) {
                      _items[index!] = {'name': name, 'qty': int.parse(qty)};
                    } else {
                      _items.add({'name': name, 'qty': int.parse(qty)});
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(isEdit ? 'Update' : 'Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Text(
                'Shopping Ketjeh',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.lightBlue[900],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Fathi Fathan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'My Wallet',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'BTC 2,50,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Icon ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionIcon(Icons.payment, 'Payment', iconSize: 34),
                _buildActionIcon(Icons.shopping_cart, 'Product', iconSize: 34),
                _buildActionIcon(Icons.category, 'Categories', iconSize: 34),
                _buildActionIcon(Icons.more_horiz, 'More', iconSize: 34),
              ],
            ),

            const SizedBox(height: 20),

            // --- Daftar Produk (sebelumnya daftar belanja) ---
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada produk 🛍️',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          color: const Color(0xFF1565C0), // 🎨 biru
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            title: Text(
                              item['name'],
                              style: const TextStyle(
                                color: Colors.white, // teks putih
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Jumlah: ${item['qty']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orangeAccent,
                                  ),
                                  onPressed: () => _addOrEditItem(index: index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => _deleteItem(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[50], // background biru muda
        onPressed: () => _addOrEditItem(),
        child: Icon(
          Icons.add,
          color: Colors.blue[800], // ikon biru tua
          size: 30,
        ),
        elevation: 4,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_outlined),
            activeIcon: Icon(Icons.swap_horiz),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            activeIcon: Icon(Icons.shopping_basket),
            label: 'Basket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget _buildActionIcon(IconData icon, String label, {double iconSize = 28}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20), // dikit lebih kecil biar rapet
        child: Icon(icon, color: Colors.blue[700], size: iconSize),
      ),
      const SizedBox(height: 4), // jarak antar ikon dan teks dikurangi
      Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
