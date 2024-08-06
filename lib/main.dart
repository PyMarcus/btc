import 'package:bitcoin_app/service/service.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  String _result = "R\$ 0,00";
  dynamic _updateResponse;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: bitcoin(context),
    );
  }

  void update(){
    _updateResponse = getBitcoinPrice();
  }

  Widget bitcoin(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/bitcoin.png"),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FutureBuilder<Map>(
              future: _updateResponse,
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    _result = "Waiting...";
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if(snapshot.hasError){
                      print("Error");
                    }else if(snapshot.hasData){
                      _result = snapshot.data!["BRL"]["buy"].toString();
                    }
                    break;
                  case ConnectionState.none:
                }
                return Text(_result, style: const TextStyle(fontSize: 32),);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  update();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
             child:const Text(
                "Atualizar"),),
          )
        ],
      ),
    );
  }
}
