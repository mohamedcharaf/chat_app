
import 'package:chat/model/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupMessageCard extends StatelessWidget {
  final int index;
  final Message message;

  const GroupMessageCard({
    Key? key,
    required this.index, required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.fromId == FirebaseAuth.instance.currentUser!.uid;
    DateTime createdAt;
    String formattedDate = "06:12"; 

    return Column(
      children: [
        StreamBuilder(
           stream: FirebaseFirestore.instance.collection('users').doc(message.fromId).snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData ? Row(
              mainAxisAlignment: (isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start),
              children: [
                if (isMe) const Icon(Icons.edit),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(19),
                      bottomRight: const Radius.circular(19),
                      topLeft: Radius.circular(isMe ? 0 : 19),
                      topRight: Radius.circular(isMe ? 0 : 19),
                    ),
                  ),
                  color: (isMe ? Colors.teal : Colors.tealAccent),
                  child: Padding(
                    padding:  EdgeInsets.all(12),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          isMe ? 
                            Text(snapshot.data!.data()!['name']) : Container(),
                             
                          
                           Text(message.msg!),
                           
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                message.createdAt!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(width: 6),
                              if (isMe)
                                const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Color.fromARGB(133, 195, 213, 228),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ) : Container();
          }
        ),
    
      ],
    );
  }
}
