// import 'package:flutter/material.dart';
// import 'edit_user_screen.dart';
//
// class UserInfoEach extends StatefulWidget {
//   Map<String,dynamic>? userDetail;
//
//   UserInfoEach({super.key,this.userDetail});
//
//   @override
//   State<UserInfoEach> createState() => _UserInfoEachState();
// }
//
// class _UserInfoEachState extends State<UserInfoEach> {
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//         centerTitle: true,
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Card(
//             elevation: 5,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(child: Icon(Icons.person_pin, size: 50,)),
//                   Center(
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             '${widget.userDetail?['fName'] ?? ''}'+' '+'${widget.userDetail?['lName'] ?? ''}',
//                             style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text('About',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Name:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['fName']}'+' '+'${widget.userDetail?['lName']}'))
//                       ],
//                     ),),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Gender:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['gender']}'))
//                       ],
//                     ),),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Date Of Birth:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['dob']}'))
//                       ],
//                     ),),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Maritial Status:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['maritalStatus']}'))
//                       ],
//                     ),),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text('Religious Background',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Religion:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['religion']}'))
//                       ],
//                     ),), //religion
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Caste:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['caste']}'))
//                       ],
//                     ),), //Caste
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text('Professional Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                   ), //professional details
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Higher Education:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['education']}'))
//                       ],
//                     ),), //higheredu
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Occupation:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['occupation']}'))
//                       ],
//                     ),), //occupation
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Text('Contact Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                   ), //contact details
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Email:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['Email']}'))
//                       ],
//                     ),), //email
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Text('Phone:',style: TextStyle(fontWeight: FontWeight.bold)),
//                         SizedBox(width: 10),
//                         Expanded(child: Text('${widget.userDetail?['Phone']}'))
//                       ],
//                     ),), //phone
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                       padding: EdgeInsets.all(15),
//                       child: Center(
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
//                             onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                                   AddEdit(userDetail: widget.userDetail, user: {},),
//                               ));
//                             },
//                             child: Text('EDIT',style: TextStyle(color: Colors.white),)),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class UserDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> user;
//
//   const UserDetailScreen({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           user['name'],
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'DancingScript',
//             fontStyle: FontStyle.italic,
//             color: Colors.pink.shade900,
//
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.pink.shade100,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: user["gender"] == 0
//                         ? AssetImage('assets/Images/male.jpg')  // Male profile
//                         : AssetImage('assets/Images/female.jpg'), // Female profile
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//                 Text(
//                   "Name: ${user['name']}",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Age: ${user['dateOfBirth']}", // Modify if `getAge()` function is used
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Email: ${user['email']}",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Gender: ${user['gender'] == 0 ? 'Male' : 'Female'}",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back),
//                     label: Text("Back"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink.shade900,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class UserDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> user;
//
//   const UserDetailScreen({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           user['name'],
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'DancingScript',
//             fontStyle: FontStyle.italic,
//             color: Colors.pink.shade900,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.pink.shade100,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: user["gender"] == 0
//                         ? AssetImage('assets/Images/male.jpg')  // Male profile
//                         : AssetImage('assets/Images/female.jpg'), // Female profile
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 _buildUserInfo("Name", user['name']),
//                 _buildUserInfo("Age", user['dateOfBirth']),
//                 _buildUserInfo("Email", user['email']),
//                 _buildUserInfo("Phone", user['phone']),
//                 _buildUserInfo("City", user['city'] ?? "Not specified"),
//                 _buildUserInfo("Gender", user['gender'] == 0 ? 'Male' : user['gender'] == 1 ? 'Female' : 'Other'),
//                 _buildUserInfo("Hobbies", (user['hobbies'] as List).isEmpty ? "None" : user['hobbies'].join(", ")),
//                 _buildUserInfo("Favorite", user['isFavorite'] ? "Yes" : "No"),
//                 SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back),
//                     label: Text("Back"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink.shade900,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserInfo(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Text(
//         "$title: $value",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:ui';

class UserDetailScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          user['name'].toString(),
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'DancingScript',
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink.shade200, Colors.pink.shade50],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade300.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: (user['gender'].toString() == '0')
                        ? AssetImage('assets/Images/male.jpg')
                        : AssetImage('assets/Images/female.jpg'),
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildUserInfo("Name", user['name'].toString()),
                                _buildUserInfo("Age", user['dateOfBirth'].toString()),
                                _buildUserInfo("Email", user['email'].toString()),
                                _buildUserInfo("Phone", user['phone'].toString()),
                                _buildUserInfo("City", user['city']?.toString() ?? "Not specified"),
                                _buildUserInfo("Gender", user['gender'].toString() == '0' ? 'Male' : 'Female'),
                                _buildUserInfo("Hobbies", (user['hobbies'] is List && user['hobbies'].isNotEmpty) ? user['hobbies'].join(", ") : "None"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 30,
                      child: IconButton(
                        icon: Icon(
                          user['isFavorite'] == true ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade300,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade200,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.pink.shade900),
          ),
          Expanded(
            child: Text(
              value ?? 'Not available',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
