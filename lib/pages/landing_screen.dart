import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/components/text_input_field_container.dart';
import 'package:tasky_app/core/extensions/custom_string_extension.dart';
import 'package:tasky_app/core/models/user.dart';
import 'package:tasky_app/core/models/users.dart';
import 'package:tasky_app/pages/navbar_screen.dart';

class LandingScreen extends StatelessWidget {
   LandingScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/Images/Logo.svg', width: 42),
                    SizedBox(width: 16),
                    Text('Tasky', style: Theme.of(context).textTheme.displayLarge)
                  ],
                ),
                SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome To Tasky', style: Theme.of(context).textTheme.displayMedium),
                    SizedBox(width: 16),
                    SvgPicture.asset('assets/Images/Hand.svg', height: 28)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 20),
                  child: Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(context).textTheme.displaySmall
                  )
                ),
                SvgPicture.asset('assets/Images/MainPhoto.svg', width: 215),
                SizedBox(height: 28),
                TextInputFieldContainer(
                  Label:"Full Name",
                  hintText: "e.g. Sarah Khalid",
                  controller: controller,
                  validator: (String? value){
                    if( value.isNullOrEmpty || !value!.contains(' '))
                      {
                        return 'Enter Your Full Name With 1 Space';
                      }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_key.currentState?.validate() ?? false) {
                        await Users.addUser(User(controller.text));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => NavbarScreen()),
                        );
                      }
                      
                    },
                    child: Text(
                      'Let’s Get Started', style: Theme.of(context).textTheme.displaySmall
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
