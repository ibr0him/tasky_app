import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/models/users.dart';
import 'package:tasky_app/pages/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed:(){
          Navigator.push(context,
          MaterialPageRoute(builder: (_)=>AddTaskScreen())
          );

        },
        icon: Icon(Icons.add),
        label: Text("Add New Task"),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(167, 40)
        )
      ),
      body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage('assets/Images/Small Avatar.png'),
                          radius: 40,
                        backgroundColor: Colors.transparent,

                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Good Evening ,${Users.currentUser!.fullName}",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: 200,
                            child: Text(
                              Users.currentUser!.qoute,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: 16,
                                color: Color(0xFFC6C6C6)
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(width: 20),
                      SvgPicture.asset('assets/Images/Light.svg',width: 34)
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 16,bottom: 12),
                  child: Text(
                    "Yuhuu ,Your work Is",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32
                    )
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "almost done !",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 32
                        )
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset('assets/Images/Hand.svg',width: 32,),
                  ],
                )
              ],

            ),
          )
      ),
    );
  }
}
