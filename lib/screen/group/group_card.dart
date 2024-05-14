import 'package:badges/badges.dart';
import 'package:chat/screen/group/group_screen.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GroupScreen()),
          );
        },
        leading: const CircleAvatar(
          backgroundColor: Colors.blue, // Ajout de la couleur de fond
          child: Icon(
            Icons.group,
            color: Colors.white, // Couleur de l'icône
          ),
        ),
        title: const Text(
          "Group Name",
          style: TextStyle(fontWeight: FontWeight.bold), // Ajout de la police en gras
        ),
        subtitle: const Text(
          "Last Message Here",
          style: TextStyle(color: Colors.grey), // Couleur du sous-titre
        ),
        trailing: const Badge(
          // badgeColor: Colors.red, // Couleur du badge
          badgeContent: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              "3",
              style: TextStyle(color: Colors.white), // Couleur du texte du badge
            ),
          ),
        ),
      ),
    );
  }
}
