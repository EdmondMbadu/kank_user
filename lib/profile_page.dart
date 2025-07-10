// profile_page_modern.dart – polished UI with white/blue/red theme
import 'package:flutter/material.dart';

/*───────────────────────────────────────────────────────────*/
/*– Brand palette –*/
const Color kPrimaryBlue = Color(0xFF0A2A55); // deep navy-blue
const Color kAccentRed = Color(0xFFD7263D); // vivid red
const Color kLightBlue = Color(0xFFF5F9FF); // very soft background tint

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
    /* TODO */
  }

  /*──────────── Helpers ────────────*/
  Widget _buildProfilePic(String fullName, String? imageUrl) {
    final initial = fullName.isNotEmpty ? fullName[0] : '?';
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
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
          ),
          if (_isEditing)
            Positioned(
              right: 4,
              bottom: 4,
              child: InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(20),
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
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        readOnly: !_isEditing,
        decoration: InputDecoration(
          filled: true,
          fillColor: _isEditing ? Colors.white : kLightBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.18)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: kPrimaryBlue.withOpacity(.18)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
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
    final imageUrl =
        (d['profilePicture'] as Map<String, dynamic>?)?['downloadURL']
            as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryBlue),
        title: const Text(
          'Profil du client',
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: kAccentRed,
            ),
            onPressed: _toggleEdit,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, color: kAccentRed),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightBlue],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfilePic(fullName, imageUrl),
              const SizedBox(height: 20),
              Text(
                fullName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                ),
              ),
              const SizedBox(height: 32),
              _buildField(label: 'Téléphone', controller: _phoneCtrl),
              const SizedBox(height: 22),
              _buildField(label: 'Adresse', controller: _addressCtrl),
              const SizedBox(height: 22),
              _buildField(
                label: 'Adresse professionnelle',
                controller: _businessCtrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
