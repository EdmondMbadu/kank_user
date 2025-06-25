// profile_page.dart
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid accent red
const Color kLightBlue = Color(0xFFE7F0FF); // subtle background tint
/*───────────────────────────────────────────────────────────*/

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> clientData;
  const ProfilePage({Key? key, required this.clientData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _businessCtrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final d = widget.clientData;
    _phoneCtrl = TextEditingController(text: d['phoneNumber'] ?? '');
    _addressCtrl = TextEditingController(text: d['homeAddress'] ?? '');
    _businessCtrl = TextEditingController(text: d['businessAddress'] ?? '');
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
        widget.clientData
          ..['phoneNumber'] = _phoneCtrl.text.trim()
          ..['homeAddress'] = _addressCtrl.text.trim()
          ..['businessAddress'] = _businessCtrl.text.trim();
      }
      _isEditing = !_isEditing;
    });
  }

  Future<void> _pickImage() async {
    // TODO: implement your image picker logic
  }

  /*──────────── Helpers ────────────*/
  Widget _buildProfilePic(String fullName, String? imageUrl) {
    final initial = fullName.isNotEmpty ? fullName[0] : '?';
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: kLightBlue,
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
                        color: kPrimaryBlue,
                      ),
                    )
                    : null,
          ),
          if (_isEditing)
            Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: kAccentRed,
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
    required bool editable,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: kPrimaryBlue,
        ),
      ),
      const SizedBox(height: 4),
      TextField(
        controller: controller,
        readOnly: !editable,
        decoration: InputDecoration(
          filled: true,
          fillColor: editable ? Colors.white : kLightBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.25)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.25)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kAccentRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );

  /*──────────── UI ────────────*/
  @override
  Widget build(BuildContext context) {
    final d = widget.clientData;
    final fullName = [
      d['firstName'],
      d['middleName'],
      d['lastName'],
    ].whereType<String>().join(' ');

    final picMap = d['profilePicture'] as Map<String, dynamic>?;
    final imageUrl = picMap?['downloadURL'] as String?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        title: const Text(
          'Profil du Client',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _toggleEdit,
          ),
        ],
      ),

      /*── Gradient background ──*/
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfilePic(fullName, imageUrl),
              const SizedBox(height: 18),
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                ),
              ),
              const SizedBox(height: 32),

              /*── Fields ─*/
              _buildField(
                label: 'Téléphone',
                controller: _phoneCtrl,
                editable: _isEditing,
              ),
              const SizedBox(height: 22),
              _buildField(
                label: 'Adresse',
                controller: _addressCtrl,
                editable: _isEditing,
              ),
              const SizedBox(height: 22),
              _buildField(
                label: 'Adresse professionnelle',
                controller: _businessCtrl,
                editable: _isEditing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
