import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/features/profile/user_controller.dart';
import 'package:tasky_app/features/profile/user_details_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await Provider.of<UserController>(context, listen: false).loadUserData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveImage(XFile file) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final newFile = await File(file.path).copy('${appDir.path}/${file.name}');

      await Provider.of<UserController>(context, listen: false)
          .updateUserImage(newFile.path);
    } catch (e) {
      debugPrint('Failed to save image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error saving image")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'My Profile',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: userController.userImagePath == null
                          ? const AssetImage('assets/images/person.png')
                          : FileImage(File(userController.userImagePath!))
                      as ImageProvider,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showImageSourceDialog(context, (XFile file) async {
                          await _saveImage(file);
                        });
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  userController.username ?? '',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  userController.motivationQuote ??
                      'One task at a time. One step closer.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Profile Info',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 24),
          ListTile(
            onTap: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UserDetailsScreen(
                    userName: userController.username ?? '',
                    motivationQuote:
                    userController.motivationQuote ??
                        'One task at a time. One step closer.',
                  ),
                ),
              );
              if (result == true) {
                await _loadUserData();
              }
            },
            contentPadding: EdgeInsets.zero,
            title: const Text('User Details'),
            leading:
            const CustomSvgPicture(path: 'assets/images/profile_icon.svg'),
            trailing:
            const CustomSvgPicture(path: 'assets/images/arrow_right.svg'),
          ),
          const Divider(thickness: 1),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Dark Mode'),
            leading: const CustomSvgPicture(path: 'assets/images/dark_icon.svg'),
            trailing: ValueListenableBuilder(
              valueListenable: ThemeController.themeNotifier,
              builder: (BuildContext context, value, Widget? child) {
                return Switch(
                  value: value == ThemeMode.dark,
                  onChanged: (bool value) async {
                    ThemeController.toggleTheme();
                  },
                );
              },
            ),
          ),
          const Divider(thickness: 1),
          ListTile(
            onTap: () async {
              await Provider.of<UserController>(context, listen: false)
                  .clearUserData();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  WelcomeScreen(),
                ),
                    (route) => false,
              );
            },
            contentPadding: EdgeInsets.zero,
            title: const Text('Log Out'),
            leading: const CustomSvgPicture(path: 'assets/images/logout_icon.svg'),
            trailing: const CustomSvgPicture(path: 'assets/images/arrow_right.svg'),
          ),
        ],
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
