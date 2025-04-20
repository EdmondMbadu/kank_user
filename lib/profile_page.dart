// profile_page.dart

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const ProfilePage({Key? key, required this.clientData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _businessCtrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final data = widget.clientData;
    _phoneCtrl = TextEditingController(
      text: data['phoneNumber'] as String? ?? '',
    );
    _addressCtrl = TextEditingController(
      text: data['homeAddress'] as String? ?? '',
    );
    _businessCtrl = TextEditingController(
      text: data['businessAddress'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _businessCtrl.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        widget.clientData['phoneNumber'] = _phoneCtrl.text;
        widget.clientData['homeAddress'] = _addressCtrl.text;
        widget.clientData['businessAddress'] = _businessCtrl.text;
      }
      _isEditing = !_isEditing;
    });
  }

  Future<void> _pickImage() async {
    // TODO: implement your image picker logic
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.clientData;
    final fullName = [
      data['firstName'],
      data['middleName'],
      data['lastName'],
    ].whereType<String>().join(' ');

    final picMap = data['profilePicture'] as Map<String, dynamic>?;
    final imageUrl = picMap != null ? picMap['downloadURL'] as String? : null;

    Widget _buildProfilePic() {
      final initial = fullName.isNotEmpty ? fullName[0] : '?';
      return Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  (imageUrl != null && imageUrl.isNotEmpty)
                      ? NetworkImage(imageUrl)
                      : null,
              child:
                  (imageUrl == null || imageUrl.isEmpty)
                      ? Text(
                        initial,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      )
                      : null,
            ),
            if (_isEditing)
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    Widget _buildField({
      required String label,
      required TextEditingController controller,
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
              fillColor:
                  isEditable ? Colors.grey.shade100 : Colors.grey.shade200,
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil du Client'),
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
        child: Column(
          children: [
            _buildProfilePic(),
            const SizedBox(height: 16),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            _buildField(
              label: 'Téléphone',
              controller: _phoneCtrl,
              isEditable: _isEditing,
            ),
            const SizedBox(height: 16),
            _buildField(
              label: 'Adresse',
              controller: _addressCtrl,
              isEditable: _isEditing,
            ),
            const SizedBox(height: 16),
            _buildField(
              label: 'Adresse professionnelle',
              controller: _businessCtrl,
              isEditable: _isEditing,
            ),
          ],
        ),
      ),
    );
  }
}
