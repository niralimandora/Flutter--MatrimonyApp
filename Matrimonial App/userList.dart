// import 'package:flutter/material.dart';
// import 'database.dart';
// import 'edit_user_screen.dart';
// import 'age.dart';
//
// class UserListScreen extends StatefulWidget {
//   final bool isFavorite;
//
//   const UserListScreen({super.key, this.isFavorite = false});
//
//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }
//
// class _UserListScreenState extends State<UserListScreen> {
//   String searchQuery = "";
//   late Future<List<Map<String,dynamic>>> futureUsers;
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUsers(); // Load users initially
//   }
//
//   void fetchUsers() {
//     setState(() {
//       futureUsers = members.getAllMembers().then((users) {
//         // If it's the favorite screen, filter only favorite users
//         final filteredUsers = users
//             .where((user) => user['name'].toLowerCase().contains(searchQuery.toLowerCase()))
//             .toList();
//
//         return widget.isFavorite
//             ? filteredUsers.where((user) => user['isFavorite']).toList()
//             : filteredUsers;
//         });
//       });
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     // final filteredUsers = members.searchMembers(query: searchQuery);
//     final Future<List<Map<String, dynamic>>> filteredUsers = members.getAllMembers().then((users) =>
//         users.where((user) => user['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.isFavorite ? 'Favorite List' : 'User List',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevation: 2,
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: widget.isFavorite
//                   ? [Colors.pink.shade300, Colors.pink.shade600]
//                   : [Colors.green.shade300, Colors.green.shade600],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value;
//                 });
//               },
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: futureUsers,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.people_outline, size: 64, color: Colors.grey),
//                           SizedBox(height: 16),
//                           Text('No users found.',
//                               style: TextStyle(fontSize: 18, color: Colors.grey)),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return ListView.builder(
//                       itemCount: snapshot.data?.length,
//                       itemBuilder: (context, index) {
//                         final user = snapshot.data?[index];
//                         final age = getAge(user?['dateOfBirth']);
//
//                         return Card(
//                           margin: const EdgeInsets.all(8.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4,
//                           color: Colors.white,
//                           shadowColor: Colors.black.withOpacity(0.1),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(Icons.person, color: Colors.blue, size: 24),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           user?['name'],
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                             color: Colors.black87,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.calendar_today, color: Colors.orange, size: 24),
//                                         SizedBox(width: 8),
//                                         Text('$age years',
//                                             style: TextStyle(fontSize: 14, color: Colors.black54)),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.email, color: Colors.green, size: 24),
//                                         SizedBox(width: 8),
//                                         Text(user?['email'],
//                                             style: TextStyle(fontSize: 14, color: Colors.black54)),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.female, color: Colors.teal, size: 24),
//                                         SizedBox(width: 8),
//                                         Text(user!['gender'].toString(),
//                                             style: TextStyle(fontSize: 14, color: Colors.black54)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(
//                                         user['isFavorite']
//                                             ? Icons.favorite
//                                             : Icons.favorite_border,
//                                         color: user['isFavorite'] ? Colors.red : Colors.grey,
//                                         size: 26,
//                                       ),
//                                       onPressed: ()async {
//                                         await members.toggleFavorite(user['id']);
//                                         fetchUsers();
//                                         setState(() {
//                                           // user['isFavorite'] = !user['isFavorite'];
//                                         });
//                                       },
//                                     ),
//
//                                     IconButton(
//                                       icon: Icon(Icons.edit, color: Colors.blue, size: 26),
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => AddEdit(user: {}),
//                                           ),
//                                         ).then((updatedUser) {
//                                           if (updatedUser != null) {
//                                             setState(() {});
//                                           }
//                                         });
//                                       },
//                                     ),
//
//                                     IconButton(
//                                       icon: Icon(Icons.delete, color: Colors.red, size: 26),
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) => AlertDialog(
//                                             title: Text('Delete'),
//                                             content: Text('Are you sure you want to delete?'),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () => Navigator.pop(context),
//                                                 child: Text('No', style: TextStyle(color: Colors.black)),
//                                               ),
//                                               TextButton(
//                                                 onPressed: ()async {
//                                                   await members.deleteMember(user['id']);
//                                                   setState(() {});
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Yes', style: TextStyle(color: Colors.black)),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///old
import 'package:flutter/material.dart';
import 'package:untitled/Matrimonial%20App/UserInfo.dart';
import 'package:untitled/Matrimonial%20App/addUser.dart';
import 'database.dart';
import 'edit_user_screen.dart';
import 'age.dart';

class UserListScreen extends StatefulWidget {
  final bool isFavorite;

  const UserListScreen({super.key, this.isFavorite = false});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String searchQuery = "";
  late Future<List<Map<String,dynamic>>> futureUsers;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Load users initially
  }
  void fetchUsers() {
    setState(() {
      futureUsers = members.getAllMembers().then((users) {
        // If it's the favorite screen, filter only favorite users
        final filteredUsers = users
            .where((user) => user['name'].toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return widget.isFavorite
            ? filteredUsers.where((user) => user['isFavorite']).toList()
            : filteredUsers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final filteredUsers = members.searchMembers(query: searchQuery);
    final Future<List<Map<String, dynamic>>> filteredUsers = members.getAllMembers().then((users) =>
        users.where((user) => user['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isFavorite ? 'Favorite List' : 'User List',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddUserScreen();
                  },
                ),
              ).then((value) {
                // if (value != null) {
                //   _user.userList.add(value);
                //   filterCard(searchController.text); // Refresh search list
                //   setState(() {});
                // }
              });
            },
            icon: Icon(
              Icons.person_add,
              color: Colors.pink.shade900,
            ),
          ),
        ],
        elevation: 2,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isFavorite
                  ? [Colors.pink.shade200, Colors.pink.shade200]
                  : [Colors.pink.shade200, Colors.pink.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  fetchUsers();
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No users found.',
                              style: TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data?[index];
                        final age = getAge(user?['dateOfBirth']);

                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailScreen(user: user),
                                ),
                              );
                            },
                          child: Card(

                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          color: Colors.white,
                          shadowColor: Colors.black.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.blue, size: 24),
                                        SizedBox(width: 8),
                                        Text(
                                          user?['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, color: Colors.orange, size: 24),
                                        SizedBox(width: 8),
                                        Text('$age years',
                                            style: TextStyle(fontSize: 14, color: Colors.black54)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.email, color: Colors.green, size: 24),
                                        SizedBox(width: 8),
                                        Text(user?['email'],
                                            style: TextStyle(fontSize: 14, color: Colors.black54)),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.female, color: Colors.teal, size: 24),
                                        SizedBox(width: 8),
                                       Text(
                                           user!["gender"] == 0? 'Male' : 'Famele',
                                           style: TextStyle(fontSize: 14, color: Colors.black54)
                                       ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        user['isFavorite']
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: user['isFavorite'] ? Colors.red : Colors.grey,
                                        size: 26,
                                      ),
                                      onPressed: ()async {
                                        await members.toggleFavorite(user['id']);
                                        fetchUsers();
                                        setState(() {
                                          // user['isFavorite'] = !user['isFavorite'];
                                        });
                                      },
                                    ),

                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue, size: 26),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddUserScreen(user: user), // Pass user data
                                          ),
                                        ).then((updatedUser) {
                                          if (updatedUser != null) {
                                            fetchUsers(); // Refresh user list after edit
                                          }
                                        });
                                      },
                                    ),


                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red, size: 26),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Delete'),
                                            content: Text('Are you sure you want to delete?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('No', style: TextStyle(color: Colors.black)),
                                              ),
                                              TextButton(
                                                onPressed: ()async {
                                                  await members.deleteMember(user['id']);
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Yes', style: TextStyle(color: Colors.black)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
