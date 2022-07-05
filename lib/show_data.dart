import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  final data;
  const ShowData(this.data, {Key key}) : super(key: key);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    // for (int index1=0; index1<0 )
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).,
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Repositories List"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Row(
              //   children: const [
              //     Padding(
              //       padding: EdgeInsets.all(10.0),
              //       child: Text("Repositories List"),
              //     ),
              //   ],
              // ),
              widget.data.length == 0 ? const Text("No Repositories Found") :
              Column(
                children: List.generate(widget.data.length,(index){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(widget.data[index]['name'],style: const TextStyle(fontWeight: FontWeight.w500),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          height: 52,
                          width: size.width,
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                            BorderRadius.circular(5),
                            // boxShadow: const [
                            //   BoxShadow(
                            //       color: Colors.grey,
                            //       spreadRadius: 1,
                            //       blurRadius: 2,
                            //       offset: Offset(1, 2))
                            // ],
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Center(child:
                          Text(widget.data[index]['owner']['avatar_url'].toString(),
                            textAlign: TextAlign.center,)),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
