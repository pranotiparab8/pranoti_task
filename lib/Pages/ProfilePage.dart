import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 1.5;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.green,
        width: double.infinity,
        height: coverHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child:
                  const Text("Settings", style: TextStyle(color: Colors.white)),
            ),
            const Text(
              "Profile",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: (profileHeight / 2) + 5,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: const AssetImage("images/cat.jpg"),
        ),
      );

  Widget buildContent() {
    return Column(
      children: const [
        Text("Victoria Robertson",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
          "A mantra goes here",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
