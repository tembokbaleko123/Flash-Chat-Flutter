import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';

User? loggedInUser; //loggedInUser pengguna masuk

class ChatScreen extends StatefulWidget {
  static const String id = '/chat';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =
      TextEditingController(); //variabel untuk menghapus text yang sudah dikirm (sisa text pada textfield)
  final _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? messageText;

  Future<void> getAndroidId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String? androidId = androidInfo.id; // Android ID
    print("Android ID: $androidId");
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final QuerySnapshot messages =
  //       await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messsageStream() async {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> koleksi =
  //       _firestore.collection('messages').snapshots();
  //   await for (var snapshot in koleksi) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getAndroidId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);
                // messsageStream();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            // StreamBuilder(
            //   stream: _firestore.collection('messages').snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       final messages = snapshot.data!.docs;
            //       List<MessageBuble> messageBubbles =
            //           []; //ubah dari List<Text> ke List <MessageBubble>
            //       for (var message in messages) {
            //         final messageText = message.get('text');
            //         final messageSender = message.get('sender');

            //         final messageBubble = MessageBuble(
            //           sender: messageSender,
            //           text: messageText,
            //         );
            //         // final messageWidget = Text(
            //         //   '$messageText from $messageSender',
            //         //   style: TextStyle(fontSize: 50),
            //         // );
            //         messageBubbles.add(messageBubble);
            //       }
            //       return Expanded(
            //         child: ListView(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //           children: messageBubbles,
            //         ),
            //       );
            //     } else {
            //       return CircularProgressIndicator(
            //         backgroundColor: Colors.lightBlueAccent,
            //       );
            //     }
            //   },
            // ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController
                          .clear(); //untuk menghapus sisa sisa text pada textfield
                      //Implement send functionality.
                      //messageText + loggednInUser.email
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
