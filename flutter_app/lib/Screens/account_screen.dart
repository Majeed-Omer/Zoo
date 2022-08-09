import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo/Screens/register_screen.dart';

class Account extends StatefulWidget {
  final String name;
  final String email;
  final image;

  Account({required this.name, required this.email, required this.image});  
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Widget imageBuilder(w) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset(
        'assets/sold.png',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setBool("isLoggedIn", false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const RegisterScreen(),
                    ));
              },
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  radius: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.name, style: TextStyle(fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "My Tickets",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(onPressed: () {}, child: Text("See More")),
                ]),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      
                      imageBuilder(70),
                      SizedBox(
                        width: 10,
                      ),
                      imageBuilder(70),
                      SizedBox(
                        width: 10,
                      ),
                      imageBuilder(70),
                      SizedBox(
                        width: 10,
                      ),
                      imageBuilder(70),
                      SizedBox(
                        width: 10,
                      ),
                      imageBuilder(70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
