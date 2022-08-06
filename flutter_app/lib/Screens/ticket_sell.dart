import 'package:flutter/material.dart';
import 'package:zoo/Services/Services_crud.dart';

import '../Models/Ticket.dart';

class ticket_sell extends StatefulWidget {
  ticket_sell() : super();

  final String title = "Flutter Laravel CRUD";

  @override
  ticket_sellState createState() => ticket_sellState();
}

class ticket_sellState extends State<ticket_sell> {
  late List<Ticket> _tickets;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late Ticket _selectedTicket;
  late bool _isUpdating;

  @override
  void initState() {
    super.initState();
    _tickets = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _getTickets();
  }

  _addTicket() {
    if (_nameController.text
        .trim()
        .isEmpty ||
        _priceController.text
            .trim()
            .isEmpty) {
      print("Empty fields");
      return;
    }
    Services.addTicket(_nameController.text, _priceController.text)
        .then((result) {
      if (result) {
        _getTickets();
      }
      _clearValues();
    });
  }

  _getTickets() {
    Services.getTickets().then((tickets) {
      setState(() {
        _tickets = tickets;
      });
      //_showProgress(widget.title);
      print("Length: ${tickets.length}");
    });
  }

  _deleteTicket(Ticket ticket) {
    Services.deleteTicket(ticket.id).then((result) {
      if (result) {
        setState(() {
          _tickets.remove(ticket);
        });
        _getTickets();
      }
    });
  }

  _updateTicket(Ticket ticket) {
    Services.updateTicket(
        ticket.id, _nameController.text, _priceController.text)
        .then((result) {
      if (result) {
        _getTickets();
        setState(() {
          _isUpdating = false;
        });
        _nameController.text = '';
        _priceController.text = '';
      }
    });
  }

  _setValues(Ticket ticket) {
    _nameController.text = ticket.name;
    _priceController.text = ticket.price;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _nameController.text = '';
    _priceController.text = '';
  }

  // SingleChildScrollView _dataBody() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: DataTable(
  //         dataTextStyle: TextStyle(color: Colors.white),
  //         headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),
  //         dataRowColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => states.contains(MaterialState.selected)
  //             ? Colors.white
  //             : Colors.black
  //         ),
  //         columns: [
  //           DataColumn(
  //               label: Text("ID"),
  //               numeric: false,
  //               tooltip: "This is the employee id"),
  //           DataColumn(
  //               label: Text(
  //                 "NAME",
  //               ),
  //               numeric: false,
  //               tooltip: "This is the name"),
  //           DataColumn(
  //               label: Text("PRICE"),
  //               numeric: false,
  //               tooltip: "This is the price"),
  //           DataColumn(
  //               label: Text("DELETE"),
  //               numeric: false,
  //               tooltip: "Delete Action"),
  //         ],
  //         rows: _tickets.map(
  //               (ticket) =>
  //               DataRow(
  //                 cells: [
  //                   DataCell(
  //                     Text(ticket.id),
  //                     onTap: () {
  //                       print("Tapped " + ticket.name);
  //                       _setValues(ticket);
  //                       _selectedTicket = ticket;
  //                     },
  //                   ),
  //                   DataCell(
  //                     Text(
  //                       ticket.name.toUpperCase(),
  //                     ),
  //                     onTap: () {
  //                       print("Tapped " + ticket.name);
  //                       _setValues(ticket);
  //                       _selectedTicket = ticket;
  //                     },
  //                   ),
  //                   DataCell(
  //                     Text(
  //                       ticket.price.toUpperCase(),
  //                     ),
  //                     onTap: () {
  //                       print("Tapped " + ticket.name);
  //                       _setValues(ticket);
  //                       _selectedTicket = ticket;
  //                     },
  //                   ),
  //                   DataCell(
  //                     IconButton(
  //                       icon: Icon(Icons.delete,color: Colors.redAccent,),
  //                       onPressed: () {
  //                         _deleteTicket(ticket);
  //                       },
  //                     ),
  //                     onTap: () {
  //                       print("Tapped " + ticket.name);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //         )
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }

  // showSnackBar(context, message) {
  //   _scaffoldKey.currentState!.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text("Buy a ticket"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () { 
            showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text("Add"),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: _nameController,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name Here',
                 ),
                  autofocus: false,
                 ),
                  TextField(
                    controller: _priceController,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Price Here',
                 ),
                  autofocus: false,
                 )
                     
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (() => Navigator.pop(context)), child: Text("CANCEL")),
                    TextButton(onPressed: (() { _addTicket(); Navigator.pop(context); }), child: Text("OK"))
                  ],
                ),);
           },),
        ],
      ),
       body: ListView.builder(itemCount: _tickets.length,
       itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: ListTile(
                      leading: Image.asset('assets/regular.png'),
                      title: Text(
                        _tickets[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(_tickets[index].price),
                      trailing: TextButton(
                        onPressed: () {
                          _tickets.remove(_tickets[index].id);
                        },
                        child: Text("Buy"),
                      ),
                    ),
                  ),
       
       ),
      //     Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       // Padding(
      //       //   padding: EdgeInsets.all(20.0),
      //       //   child: TextField(
      //       //     controller: _nameController,
      //       //     decoration: InputDecoration.collapsed(
      //       //       hintText: "First Name",
      //       //     ),
      //       //   ),
      //       // ),
      //       // Padding(
      //       //   padding: EdgeInsets.all(20.0),
      //       //   child: TextField(
      //       //     controller: _priceController,
      //       //     decoration: InputDecoration.collapsed(
      //       //       hintText: "Last Name",
      //       //     ),
      //       //   ),
      //       // ),
      //       // _isUpdating
      //       //     ? Row(
      //       //   children: <Widget>[
      //       //     ElevatedButton(
      //       //       child: Text('UPDATE'),
      //       //       onPressed: () {
      //       //         _updateTicket(_selectedTicket);
      //       //       },
      //       //     ),
      //       //     ElevatedButton(
      //       //       child: Text('CANCEL'),
      //       //       onPressed: () {
      //       //         setState(() {
      //       //           _isUpdating = false;
      //       //         });
      //       //         _clearValues();
      //       //       },
      //       //     ),
      //       //   ],
      //       // )
      //       //     : Container(),
      //       // Expanded(
      //       //   child: _dataBody(),
      //       // )
            
      //     ],
      //   ),
    
    );
  }
}