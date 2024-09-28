// import 'package:chat/firebase/FireData.dart';
// import 'package:chat/model/msg_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class GroupMessageCard extends StatefulWidget {
//   final int index;
//   final String roomId;
//   final Message messagesItems;
//   final bool  selected ;

//   const GroupMessageCard(
//       {Key? key,
//       required this.messagesItems,
//       required this.index,
//       required this.roomId, required this.selected})
//       : super(key: key);

//   @override
//   State<GroupMessageCard> createState() => _GroupMessageCardState();
// }

// class _GroupMessageCardState extends State<GroupMessageCard> {
//   @override
//   void initState() {
//     super.initState();
//     FireData1().readMessage(widget.roomId, widget.messagesItems.id!);
//   }

//   String _formatMessageDate(DateTime messageDateTime) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final messageDate = DateTime(
//         messageDateTime.year, messageDateTime.month, messageDateTime.day);

//     if (messageDate.isAfter(today)) {
//       // Date dans le futur
//       return DateFormat('dd/MM/yyyy HH:mm').format(messageDateTime);
//     } else if (messageDate == today) {
//       return "Aujourd'hui ${DateFormat('HH:mm').format(messageDateTime)}";
//     } else if (messageDate == yesterday) {
//       return "Hier ${DateFormat('HH:mm').format(messageDateTime)}";
//     } else if (now.difference(messageDate).inDays < 7) {
//       return DateFormat('EEEE HH:mm', 'fr_FR').format(messageDateTime);
//     } else {
//       return DateFormat('dd/MM/yyyy HH:mm').format(messageDateTime);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isMe =
//         widget.messagesItems.fromId == FirebaseAuth.instance.currentUser?.uid;

//     DateTime createdAt;
//     String formattedDate;
//     try {
//       createdAt = DateTime.parse(widget.messagesItems.createdAt!);
//       formattedDate = _formatMessageDate(createdAt);
//     } catch (e) {
//       print('Error parsing date: $e');
//       formattedDate = "Date invalide";
//     }

//     return Container(
//       decoration: BoxDecoration(  color:widget.selected ? Colors.blue : Colors.transparent   ,borderRadius:BorderRadius.circular(12) ) ,
//       margin: EdgeInsets.symmetric(vertical:1 ),
//       child: Row(
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: const Radius.circular(19),
//                 bottomRight: const Radius.circular(19),
//                 topLeft:
//                     isMe ? const Radius.circular(19) : const Radius.circular(0),
//                 topRight:
//                     isMe ? const Radius.circular(0) : const Radius.circular(19),
//               ),
//             ),
//             color: isMe ? Colors.teal : Colors.tealAccent,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Container(
//                 constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width / 2),
//                 child: Column(
//                   crossAxisAlignment:
//                       isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                   children: [
//                     widget.messagesItems.type == 'image'
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: CachedNetworkImage(
//                               imageUrl: widget.messagesItems
//                                   .msg!, // Use content for the image URL
      
//                               placeholder: (context, url) {
//                                 return CircularProgressIndicator();
//                               },
//                             ),
//                           )
//                         : Text(
//                             widget.messagesItems
//                                 .msg!, // Use content for text messages
//                             style: const TextStyle(color: Colors.black),
//                           ),
//                     const SizedBox(height: 4),
//                     Row(
//                       mainAxisAlignment:
//                           isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           formattedDate,
//                           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                 fontSize: 10,
//                                 color: Colors.black54,
//                               ),
//                         ),
//                         const SizedBox(width: 4),
//                         if (isMe)
//                            Icon(
//                             Iconsax.tick_circle,
//                             size: 14,
//                             color :widget.messagesItems.read =="" ?  Colors.blueGrey: Colors.blue,
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
