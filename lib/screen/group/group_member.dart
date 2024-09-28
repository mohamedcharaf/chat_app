import 'package:chat/firebase/FireData.dart';
import 'package:chat/model/groupe_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/group/group_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupMember extends StatefulWidget {
  final GroupRoom chatgroup;
  const GroupMember({Key? key, required this.chatgroup}) : super(key: key);

  @override
  State<GroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  late bool isAdmin;
  late String myId;

  @override
  void initState() {
    super.initState();
    myId = FirebaseAuth.instance.currentUser!.uid;
    isAdmin = widget.chatgroup.admin.contains(myId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Members"),
        actions: [
          if (isAdmin)
            IconButton(
              onPressed: () => _navigateToGroupEdit(),
              icon: const Icon(Icons.person_add),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id', whereIn: widget.chatgroup.members)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No members found'));
            }

            List<ChatUser> userList = snapshot.data!.docs
                .map((e) => ChatUser.fromJson(e.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) => _buildMemberTile(userList[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMemberTile(ChatUser user) {
    bool isUserAdmin = widget.chatgroup.admin.contains(user.id);

    return ListTile(
      title: Text(user.name ?? 'Unknown'),
      subtitle: Text(
        isUserAdmin ? "Admin" : "Member",
        style: const TextStyle(color: Colors.green),
      ),
      trailing: isAdmin && myId != user.id
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings),
                  onPressed: () => _toggleAdminStatus(user, isUserAdmin),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => _removeMember(user),
                ),
              ],
            )
          : null,
    );
  }

  void _navigateToGroupEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupEdit(chatgroup: widget.chatgroup),
      ),
    );
  }

  void _toggleAdminStatus(ChatUser user, bool isUserAdmin) {
    if (isUserAdmin) {
      FireData1().removeAdmin(widget.chatgroup.id, user.id!).then((_) {
        setState(() {
          widget.chatgroup.admin.remove(user.id);
        });
      });
    } else {
      FireData1().promptAdmin(widget.chatgroup.id, user.id!).then((_) {
        setState(() {
          widget.chatgroup.admin.add(user.id!);
        });
      });
    }
  }

  void _removeMember(ChatUser user) {
    FireData1().removeMember(widget.chatgroup.id, user.id!).then((_) {
      setState(() {
        widget.chatgroup.members.remove(user.id);
      });
    });
  }
}