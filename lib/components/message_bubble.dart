import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  const MessageBuble({super.key, this.sender, this.text, required this.isMe});

  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        //untuk mengubah arah dari bubble text (kita dari kiri, teman dari kanan)

        children: [
          //ini untuk meanampilkan siapa yang mengirim
          Text(
            sender!,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(
                        30), // Agar kelihatan lancip (lihat kanan atas)
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(
                        30)), //BorderRadius.circular(30), //agar kelihatan bulat
            elevation: 5, //Agar kelihatan ada shadow pada kotak
            color: isMe
                ? Colors.lightBlueAccent
                : Colors.white, //ternary operator pakai
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                //untuk menampilkan isi si pengirim pesan
                text!, //from $sender',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
