import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/scan_qr.dart';
import 'package:project1/show_data.dart';
import 'package:project1/simple_counter.dart';
import 'bloc_counter.dart';
import 'theme.bloc.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:http/http.dart' show Client;

class HomePage extends StatefulWidget {

  final bool isDarkThemeEnabled;
  final ThemeBloc bloc;
  const HomePage(this.isDarkThemeEnabled, this.bloc, {Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map<String,dynamic> resultFromJson = {'data': []};
  var resultFromJson;
  bool loading = false;

  Client client = Client();
  // https://api.github.com/users/mashr9980/repos
  // final _baseUrl = "https://api.github.com/users/";

  Future<dynamic> getUsers(text) async {
    loading = true;
    final response = await client.get(Uri.parse("https://api.github.com/users/$text/repos"));

    if (response.statusCode == 200) {
      resultFromJson = json.decode(response.body);
      // print(resultFromJson[0]);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("User Found"),
      //   ),
      // );
      loading = false;
    } else {
      throw ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Not Found"),
        ),
      );
    }
  }

  final search = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    Size size = MediaQuery.of(context).size;
    return loading ? const Center(child: CircularProgressIndicator(),) : Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
            title: const Text("Search Github Users")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) => value.isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.search,
                // onEditingComplete: () => node.nextFocus(),
                keyboardType: TextInputType.text,
                controller: search,
                // obscureText: true,
                decoration: InputDecoration(
                  hintText: 'mrjohn',
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState.validate()){
                    await getUsers(search.text);
                    if(resultFromJson.length != 0){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(resultFromJson)),);
                    }
                    else if(resultFromJson.length == 0){
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text("No public Repositories found"),
                        ),
                      );
                    }
                    // print(resultFromJson.length);
                    // if (resultFromJson.isNotEmpty){
                    //   // Navigator.of(context).push(MaterialPageRoute(
                    //   //     builder: (BuildContext context) => ShowData(resultFromJson)));
                    //   scaffold.showSnackBar(
                    //     SnackBar(
                    //       content: Text(resultFromJson['login']),
                    //     ),
                    //   );
                    // }
                    // else if(resultFromJson['message'] == "Not Found"){
                    //   scaffold.showSnackBar(
                    //     const SnackBar(
                    //       content: Text("User Not Found"),
                    //     ),
                    //   );
                    // }
                  }

                },
                child: Container(
                  height: 52,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Theme.of(context).primaryColor,)),
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Search",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.04,
                        // color: txt_color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: ListTile(
                  title: const Text("Dark Theme"),
                  trailing: Switch(
                      value: widget.isDarkThemeEnabled,
                      onChanged: widget.bloc.changeTheTheme
                  ),
                ),
              ),
              ListTile(
                title: const Text('Simple Increment Counter'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const SimpleCounter()));
                },
              ),
              ListTile(
                title: const Text('Bloc Increment Counter'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const CounterApp()));
                },
              ),
              ListTile(
                title: const Text('Scan QR Code'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ScanQr()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}