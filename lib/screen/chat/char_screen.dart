// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Adel"),
            Text(
              "Last seen 11:28 am",
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          const SizedBox(
            width: 10,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.copy))
        ],
      ),
      body: 
        Column(
          
          
          children: [

            Expanded(child:
             ListView.builder(
              itemCount: 18,
              reverse: true,
              itemBuilder:(context, index) {
             

               return  Row(
                mainAxisAlignment:(index % 2 == 0 ? MainAxisAlignment.end : MainAxisAlignment.start),
                children: [
                  index % 2 == 0 ? Icon(Icons.edit) :SizedBox(),
                  Card(
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(19),
                       bottomRight: const Radius.circular(19),
                       topLeft: Radius.circular(index % 2 == 1 ? 0 : 19),
                       topRight: Radius.circular(index % 2 == 0 ? 0 : 19),
                    )),
                    color:(index % 2 == 0 ? Colors.teal : Colors.tealAccent),
                    
                    child: Padding(padding: const EdgeInsets.all(12),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          const Text("Message jhbjbjhbjbjbj knkffk sfnknknkn  nknkjnk nkdvk"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("06:12",style: Theme.of(context).textTheme.labelSmall),
                              const SizedBox(width: 6,),
                               index % 2 == 0 ? const Icon(Icons.check,size: 18,color: Color.fromARGB(133, 195, 213, 228),) : SizedBox(width: 0,) ,
                            ],
                          )
                        ],
                      ),
                    ),
                    
                    ),
                  )
                ],
              );
                
              },
           
             
           )),
            
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: TextField(
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                        suffixIcon: Row( 
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.sentiment_satisfied)),
                                  IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.image)),
                          ],
                        ),
                      
                        border: InputBorder.none,
                        hintText: "Message",
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                            ),
                  ),
                ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send))
              ],
            )
          ],
        )
    );
   
  }
}
