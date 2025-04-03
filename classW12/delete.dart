//delete.dart

class UpdateItemScreen extends StatefulWidget {
  final String itemId;
  final String currentName;
  final int currentQuantity;

  UpdateItemScreen({
    required this.itemId,
    required this.currentName,
    required this.currentQuantity,
  });

  @override
  _UpdateItemScreenState createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName;
    _quantityController.text = widget.currentQuantity.toString();
  }

  void _updateItem() {
    String name = _nameController.text;
    int quantity = int.tryParse(_quantityController.text) ?? 0;

    FirebaseFirestore.instance.collection('inventory').doc(widget.itemId).update({
      'name': name,
      'quantity': quantity,
    });

    Navigator.pop(context); // Return to the home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Item')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}
