import 'package:flutter/material.dart';
import 'package:untitled/Matrimonial%20App/addUser.dart';
import 'package:untitled/Matrimonial%20App/userList.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heartlinks – Find Your Match",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),),
        backgroundColor: Colors.pink.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWelcomeBanner(),
            _buildQuickActions(context),
            _buildTestimonials(),
            _buildCallToAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            "Find Your Perfect Match 💖",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Join thousands of happy couples who found love on Heartlinks!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Image.asset("assets/Images/love_banner.jpeg.jpg", height: 150,width: 400,),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _quickActionButton(context, Icons.person_add, "Add Profile", AddUserScreen()),
        _quickActionButton(context, Icons.favorite, "View Matches", UserListScreen()),
        _quickActionButton(context, Icons.star, "Favorites", UserListScreen(isFavorite: true)),
      ],
    );
  }

  Widget _quickActionButton(BuildContext context, IconData icon, String title, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink.shade200,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text("💬 Success Stories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _testimonialItem("Ravi & Priya", "We found love on Heartlinks! Thank you for making our journey special."),
          _testimonialItem("Amit & Sneha", "This platform made our dreams come true. Highly recommended!"),
        ],
      ),
    );
  }

  Widget _testimonialItem(String name, String review) {
    return ListTile(
      leading: Icon(Icons.favorite, color: Colors.pink.shade400),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(review),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.pink.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            "Start Your Journey Today!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade50,
            ),
            child: Text("Join Now"),
          ),
        ],
      ),
    );
  }
}
