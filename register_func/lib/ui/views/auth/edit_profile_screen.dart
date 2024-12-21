import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:register_func/core/constants/app_routers.dart';
import 'package:register_func/core/theme/my_theme.dart';
import '../../viewmodels/profile_viewmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController,
      phoneController,
      addressController,
      descriptionController,
      hobbiesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    hobbiesController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  void _loadUserData() async {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    await profileViewModel.loadUserProfile();

    nameController.text = profileViewModel.name ?? '';
    phoneController.text = profileViewModel.phone ?? '';
    addressController.text = profileViewModel.address ?? '';
    descriptionController.text = profileViewModel.description ?? '';
    hobbiesController.text = profileViewModel.hobbies ?? '';
  }

  void _saveProfile() async {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.name = nameController.text;
    profileViewModel.phone = phoneController.text;
    profileViewModel.address = addressController.text;
    profileViewModel.description = descriptionController.text;
    profileViewModel.hobbies = hobbiesController.text;

    await profileViewModel.updateUserProfile();

    if (profileViewModel.errorMessage.isEmpty) {
      final snackBar = SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Profile updated successfully',
          contentType: ContentType.success,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      context.pop('/entryPoint');
    } else {
      final snackBar = SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: profileViewModel.errorMessage,
          contentType: ContentType.failure,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: MyTheme.backgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: AppTextStyles.appbarText,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: MyTheme.backgroundcolor,
      ),
      body: profileViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileViewModel.profileImage != null
                            ? FileImage(profileViewModel.profileImage!)
                            : profileViewModel.profileImageUrl != null
                                ? NetworkImage(
                                    profileViewModel.profileImageUrl!)
                                : AssetImage("assets/images/profile.jpg"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: MyTheme.primaryColor,
                        ),
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                  _buildTextField("Full Name", nameController),
                  _buildTextField("Phone", phoneController),
                  _buildTextField("Address", addressController),
                  _buildTextField("About", descriptionController, maxLines: 3),
                  _buildTextField("Hobbies", hobbiesController),
                  GestureDetector(
                    onTap: _saveProfile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      margin: const EdgeInsets.symmetric(horizontal: 76),
                      decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              'SAVE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Image(
                              image:
                                  AssetImage('assets/icons/right_arrow.png')),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<ProfileViewModel>(context, listen: false).profileImage =
          File(pickedFile.path);
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      child: TextField(
        style: TextStyle(color: MyTheme.white, fontSize: 16),
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          labelText: label,
          labelStyle: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
