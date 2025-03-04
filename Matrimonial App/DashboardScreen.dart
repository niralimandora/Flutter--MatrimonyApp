import 'package:flutter/material.dart';
import 'package:untitled/Matrimonial%20App/ContactUs.dart';
import 'package:untitled/Matrimonial%20App/Home.dart';
import 'AboutUs.dart';
import 'addUser.dart';
import 'userList.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heartlinks',
          style: TextStyle(
              fontSize: 40,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),
        ),
        backgroundColor: Colors.pink.shade200,
        centerTitle: true,
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         child: Column(
      //           children: [
      //             CircleAvatar(
      //               backgroundImage: AssetImage('assets/Images/logo.jpeg'),
      //             ),
      //             Text(
      //               "Heartlinks",
      //               style: TextStyle(
      //                   fontSize: 40,
      //                   fontFamily: 'DancingScript',
      //                   fontStyle: FontStyle.italic,
      //                   color: Colors.pink.shade900),
      //             ),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AddUserScreen()),
      //           );
      //         },
      //         title: Text('Adduser'),
      //         leading: Icon(Icons.person_add),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => UserListScreen()),
      //           );
      //         },
      //         title: Text('User List'),
      //         leading: Icon(Icons.list),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => UserListScreen(isFavorite: true)),
      //           );
      //         },
      //         title: Text('Favorite User'),
      //         leading: Icon(Icons.favorite),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AboutUsScreen()),
      //           );
      //         },
      //         title: Text('About us'),
      //         leading: Icon(Icons.info),
      //       ),
      //     ],
      //   ),
      //   backgroundColor: Colors.pink.shade50,
      // ),
      drawer: Drawer(
        backgroundColor: Colors.pink.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/Images/logo.jpeg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Heartlinks",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DancingScript',
                      fontStyle: FontStyle.italic,
                      color: Colors.pink.shade900,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              title: 'Home',
              icon: Icons.home,
              context: context,
              destination: HomeScreen(),
            ),
            Divider(),
            _buildDrawerItem(
              title: 'Contact Us',
              icon: Icons.phone,
              context: context,
              destination: ContactUsScreen(),
            ),
            _buildDrawerItem(
              title: 'About Us',
              icon: Icons.info,
              context: context,
              destination: AboutUsScreen(),
            ),
          ],
        ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 40,
            childAspectRatio: 2.5,
          ),
          children: [
            _buildDashboardButton(
              context,
              icon: Icons.person_add,
              title: 'Add User',
              color1: Colors.pink.shade200,
              color2: Colors.pink.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.list,
              title: 'User List',
              color1: Colors.pink.shade200,
              color2: Colors.pink.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen()),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.favorite,
              title: 'Favorite',
              color1: Colors.pink.shade200,
              color2: Colors.pink.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListScreen(isFavorite: true),
                  ),
                );
              },
            ),
            _buildDashboardButton(
              context,
              icon: Icons.info,
              title: 'About Us',
              color1: Colors.pink.shade200,
              color2: Colors.pink.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required BuildContext context,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink.shade900),
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}

Widget _buildDashboardButton(BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onPressed,
  required Color color1,
  required Color color2,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 500,
      height: 500,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.pink.shade900),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.pink.shade900,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  DashboardCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
