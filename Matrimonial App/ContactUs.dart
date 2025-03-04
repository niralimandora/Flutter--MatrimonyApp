import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(
              fontSize: 40,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),
        ),
        backgroundColor: Colors.pink.shade200,
        centerTitle: true,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📞 Get in Touch with Us",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _contactItem(Icons.email, "Email", "support@heartlinks.com",
                "mailto:support@heartlinks.com"),
            _contactItem(
                Icons.phone, "Phone", "+91 9876543210", "tel:+919876543210"),
            _contactItem(Icons.location_on, "Office",
                "123, Love Street, Delhi, India", ""),
            Divider(),
            Text("🌍 Connect with us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialMediaButton(
                    Icons.facebook, "https://facebook.com/heartlinks"),
                _socialMediaButton(
                    Icons.camera_alt, "https://instagram.com/heartlinks"),
                _socialMediaButton(Icons.chat, "https://wa.me/919876543210"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String title, String value, String link) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink.shade900),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      onTap: () {
        if (link.isNotEmpty) launchUrl(Uri.parse(link));
      },
    );
  }

  Widget _socialMediaButton(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, size: 30, color: Colors.pink.shade900),
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
    );
  }
}
