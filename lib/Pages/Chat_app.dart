import 'package:flutter/material.dart';

class Chat_app extends StatefulWidget {
  const Chat_app({Key? key}) : super(key: key);

  @override
  State<Chat_app> createState() => _Chat_appState();
}

class _Chat_appState extends State<Chat_app> {
  var jsondata = [
    {"user1": "Hello"},
    {"user2": "how r u?"},
    {"user1": "Hi"},
    {"user2": "m fine."},
    {"user2": "Ok"}
  ];
  final List<Map<String, String>> jsondata1 = [
    {"sender": "user1", "message": "Hello"},
    {"sender": "user2", "message": "how r u?"},
    {"sender": "user1", "message": "Hi"},
    {"sender": "user2", "message": "m fine."},
    {"sender": "user2", "message": "Ok"},
  ];
  TextEditingController textController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(Icons.arrow_back),
          SizedBox(width: 5),
          CircleAvatar(backgroundImage: AssetImage('images/cat.jpg')),
          SizedBox(width: 5),
          Text("User1"),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: jsondata1.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: jsondata1[index]["sender"] == "user1"
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: ListTile(
                    title: Text(jsondata1[index]["message"]!),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: textController1,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blueAccent),
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.looks_one_outlined,
                              color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              jsondata1.add({
                                "sender": "user1",
                                "message": textController1.text,
                              });
                              textController1.clear();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.looks_two_outlined,
                              color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              jsondata1.add({
                                "sender": "user2",
                                "message": textController1.text,
                              });
                              textController1.clear();
                            });
                          },
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.image, color: Colors.blueAccent))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
