import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/features/profile/user_controller.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;
  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _key = GlobalKey();



  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(text: widget.motivationQuote);
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                hintText: 'Usama Elgendy',
                title: "User Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter User Name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer.',
                title: "Motivation Quote",
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter Motivation Quote";
                  }
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 100));
                  if (_key.currentState!.validate()) {
                    await userController.updateUserData(
                      username: userNameController.text.trim(),
                      motivationQuote: motivationQuoteController.text.trim(),
                    );
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: const Text('Save Changes'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
