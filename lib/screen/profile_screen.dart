import 'package:flutter/material.dart';
import 'package:quiz2/screen/leader_board_screen.dart';
import 'package:quiz2/screen/manage_question_screen.dart';
import 'package:quiz2/service/firebase_auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  Future<void> _logout() async {
    try {
      await _firebaseAuthService.logout();
      Navigator.of(context).pushReplacementNamed(
          '/login'); // Navigate to the login screen after logout
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error logging out: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Account",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    title: const Text(
                      "Your Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Profile"),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {},
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.settings,
                          color: Colors.blue, size: 24),
                    ),
                    title: const Text(
                      "Manage Question",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageQuestionsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue[100],
                      child:
                          const Icon(Icons.help, color: Colors.blue, size: 24),
                    ),
                    title: const Text(
                      "Help",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue[100],
                      child:
                          const Icon(Icons.help, color: Colors.blue, size: 24),
                    ),
                    title: const Text(
                      "LeaderBoard",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LeaderboardScreen();
                      }));
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.card_giftcard,
                          color: Colors.blue, size: 24),
                    ),
                    title: const Text(
                      "Affiliate",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.person_add,
                          color: Colors.blue, size: 24),
                    ),
                    title: const Text(
                      "Invite A Friend",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Center(
                                  child: Text(
                                    "Invite friend",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://yt3.googleusercontent.com/viNp17XpEF-AwWwOZSj_TvgobO1CGmUUgcTtQoAG40YaYctYMoUqaRup0rTxxxfQvWw3MvhXesw=s900-c-k-c0x00ffffff-no-rj',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1200px-Instagram_logo_2022.svg.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://store-images.s-microsoft.com/image/apps.37935.9007199266245907.b029bd80-381a-4869-854f-bac6f359c5c9.91f8693c-c75b-4050-a796-63e1314d18c9?h=464',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Telegram_2019_Logo.svg/800px-Telegram_2019_Logo.svg.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://thumbs.dreamstime.com/b/sms-icon-vector-simple-illustration-sms-icon-isolated-white-background-sms-icon-vector-simple-101969076.jpg',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://pbs.twimg.com/profile_images/1661161645857710081/6WtDIesg_400x400.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Gmail_icon_%282020%29.svg/640px-Gmail_icon_%282020%29.svg.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.network(
                                        'https://play-lh.googleusercontent.com/ruvfjFuxDoQpaZjNoY8wJOBCAL_yBkI6LB_ETZpZxu5gJ4FDlFhuW9NJzOA4XhB-PMtu=w240-h480-rw',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            InkWell(
              onTap: _logout,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
