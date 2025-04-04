import 'package:flutter/material.dart';

/// Simple data class for client info
class Client {
  final String name; // read-only for now
  String phone;
  String address;
  String businessAddress;

  Client({
    required this.name,
    required this.phone,
    required this.address,
    required this.businessAddress,
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Example client data
  final Client _client = Client(
    name: "Kobongo Mbala",
    phone: "+243 987 654 321",
    address: "Lingwala, Kinshasa",
    businessAddress: "Marché Central, Kinshasa",
  );

  bool _isEditing = false;

  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _businessController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    _phoneController = TextEditingController(text: _client.phone);
    _addressController = TextEditingController(text: _client.address);
    _businessController = TextEditingController(text: _client.businessAddress);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    _businessController.dispose();
    super.dispose();
  }

  /// Toggle edit mode
  void _toggleEdit() {
    setState(() {
      // If we're switching from edit to non-edit, save changes.
      if (_isEditing) {
        _client.phone = _phoneController.text;
        _client.address = _addressController.text;
        _client.businessAddress = _businessController.text;
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compte du Client"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Name (read-only)
                _buildReadOnlyField("Nkombo (Name)", _client.name),
                const Divider(height: 32),

                // Phone (editable if _isEditing = true)
                _buildEditableField(
                  "Téléphone",
                  _phoneController,
                  isEditable: _isEditing,
                ),
                const Divider(height: 32),

                // Address
                _buildEditableField(
                  "Adresse",
                  _addressController,
                  isEditable: _isEditing,
                ),
                const Divider(height: 32),

                // Business Address
                _buildEditableField(
                  "Adresse ya mosala",
                  _businessController,
                  isEditable: _isEditing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A simple read-only display for the name
  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// A text field that can be toggled between read-only and editable
  Widget _buildEditableField(
    String label,
    TextEditingController controller, {
    required bool isEditable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: !isEditable,
          decoration: InputDecoration(
            filled: true,
            fillColor: isEditable ? Colors.grey.shade100 : Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
