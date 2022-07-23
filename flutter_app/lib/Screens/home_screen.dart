import 'package:flutter/material.dart';

import 'animals_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget itemBuilder(p, n) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return animal_details(p, n);
        }));
      },
      borderRadius: BorderRadius.circular(18),
      splashColor: Colors.blue[900],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          color: Colors.grey[200],
          child: Column(children: [
            Image.asset(
              p,
              fit: BoxFit.fill,
              width: 150,
              height: 100,
            ),
            Text(
              n,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Home"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Mammals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(onPressed: () {}, child: Text("See More")),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/lion-zoo.jpg", "lion"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/elephant.jpg", "elephant"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/monkey.jpg", "monkey"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/zebra.jpg", "zebra"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/graff.jpg", "graff"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/bear.jpg", "bear"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Birds",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(onPressed: () {}, child: Text("See More")),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/eagle.jpg", "eagle"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/owl.jpg", "owl"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/turkey.jpg", "turkey"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/sparrow.jpg", "sparrow"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/flamingo.webp", "flamingo"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/parrot.jpg", "parrot"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Reptiles",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(onPressed: () {}, child: Text("See More")),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/kro.jpg", "crocodile"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/snacks.jpg", "snake"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/turtle.jpg", "turtle"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/lizard.jpg", "lizard"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/Cobra.jpg", "cobra"),
                SizedBox(
                  width: 10,
                ),
                itemBuilder("assets/frog.jpg", "frog"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
