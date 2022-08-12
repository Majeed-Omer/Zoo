import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoo/Screens/register_screen.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { facebook, instagram, email, linkedin, whatsapp }

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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
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
        body: ListView(
          children:[ Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
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
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Tickets",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextButton(onPressed: () {}, child: Text("See All")),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Reach us",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => share(SocialMedia.facebook),
                        icon: FaIcon(FontAwesomeIcons.facebookSquare,
                            size: h / 23, color: Colors.blue),
                      ),
                      IconButton(
                          onPressed: () => share(SocialMedia.instagram),
                          icon: FaIcon(
                            FontAwesomeIcons.instagramSquare,
                            size: h / 23,
                            color: Colors.redAccent,
                          )),
                      IconButton(
                          onPressed: () => share(SocialMedia.linkedin),
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            size: h / 23,
                            color: Color.fromARGB(255, 7, 69, 120),
                          )),
                      IconButton(
                          onPressed: () => share(SocialMedia.whatsapp),
                          icon: FaIcon(
                            FontAwesomeIcons.whatsappSquare,
                            size: h / 23,
                            color: Colors.lightGreenAccent,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),]
        ));
  }

  Future share(SocialMedia socialMedia) async {
    // final subject = 'Best Flutter Video Ever!';
    // final text = 'hhhhhhhhhhhhhhhhhhhhhhhhh';
    // final urlShare = Uri.encodeComponent('majeed.omer');
    final urls = {
      SocialMedia.facebook: 'https://www.facebook.com/majeed.omer.9/',
      SocialMedia.instagram: 'https://www.instagram.com/majeedomer1/',
      SocialMedia.linkedin:
          'https://www.linkedin.com/in/mom-two-581275243/?fbclid=IwAR3e2Zjk4ri6GEfaUCfvRNcNq9BQCGyP52inwZLOuwko0yjQ2tPsObTQTnI',
      SocialMedia.whatsapp: 'https://api.whatsapp.com/07508610867'
    };
    final url = urls[socialMedia]!;

    if (!await canLaunch(url)) {
      await launch(url);
    }
  }
}
