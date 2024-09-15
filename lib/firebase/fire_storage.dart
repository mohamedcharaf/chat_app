import 'dart:io';
   import 'package:chat/firebase/FireData.dart';
import 'package:firebase_storage/firebase_storage.dart';

   class Firestorage {
     final FirebaseStorage firestorage = FirebaseStorage.instance;

     Future<String?> sendImage(File file, String roomId , String uid) async {
       print('Entering sendImage method');
      
         String ext = file.path.split('.').last;
         final ref = firestorage
             .ref()
             .child("image/$roomId/${DateTime.now().millisecondsSinceEpoch}.$ext");
         
         print('Storage reference created: ${ref.fullPath}');

         print('Starting file upload...');
         final uploadTask = ref.putFile(file);

         uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
           print('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
         }, onError: (e) {
           print('Upload error: $e');
         });

         final TaskSnapshot taskSnapshot = await uploadTask;

         print('Upload task completed. State: ${taskSnapshot.state}');

         if (taskSnapshot.state == TaskState.success) {
           String imageUrl = await ref.getDownloadURL();
             FireData1().sendMsg(uid,imageUrl,roomId,type: 'image');
           print('Image uploaded successfully. URL: $imageUrl');
           return imageUrl;
         } else {
           print('Upload failed. State: ${taskSnapshot.state}');
           return null;
         }
         
       } 
     
     }
     