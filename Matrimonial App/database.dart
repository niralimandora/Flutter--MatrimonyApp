import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Members {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'cureOption.db');
    var db = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Members(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            phone INTEGER,
            dateOfBirth TEXT,
            gender INTEGER,
            hobbies TEXT,  -- Store hobbies as a JSON-encoded string
            password TEXT,
            isFavorite INTEGER  -- Use INTEGER for boolean (0 or 1)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      version: 1,
    );
    return db;
  }

  // Add a member to the database
  Future<void> addMember(Map<String, dynamic> member) async {
    final db = await initDatabase();
    member['hobbies'] = getHobbiesString(member['hobbies']); // Encode hobbies as JSON
    member['isFavorite'] = member['isFavorite'] ? 1 : 0; // Convert bool to int
    await db.insert('Members', member);
  }

  // Delete a member by ID
  Future<void> deleteMember(int id) async {
    final db = await initDatabase();
    await db.delete('Members', where: 'id = ?', whereArgs: [id]);
  }

  // Update a member by ID
  Future<void> updateMember(int id, Map<String, dynamic> updatedMember) async {
    final db = await initDatabase();
    updatedMember['hobbies'] = getHobbiesString(updatedMember['hobbies']); // Encode hobbies as JSON
    updatedMember['isFavorite'] = updatedMember['isFavorite'] ? 1 : 0; // Convert bool to int
    await db.update('Members', updatedMember, where: 'id = ?', whereArgs: [id]);
  }

  // Get a member by ID
  Future<Map<String, dynamic>> getMemberById(int id) async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM Members WHERE id = ?', [id]);

    if (result.isNotEmpty) {
      var member = result.first;
      dynamic toReturn = {
        ...member,
        'hobbies': getHobbiesList(member['hobbies']),
        'isFavorite': member['isFavorite'] == 1,
      };
      print(toReturn);
      return toReturn;
    }
    return {};
  }

  // Get all members
  Future<List<Map<String, dynamic>>> getAllMembers() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.rawQuery('select * from Members');

    return result.map((member) {
      return {
        ...member,
        'hobbies': getHobbiesList(member['hobbies']),
        'isFavorite': member['isFavorite'] == 1,
      };
    }).toList();
  }

  Future<int> numberOfMenbers() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query("Members");
    return result.length;
  }

  // Get favorite members
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query('Members', where: 'isFavorite = ?', whereArgs: [1]);
    return result.map((member) {
      return {
        ...member,
        'hobbies': getHobbiesList(member['hobbies']),
        'isFavorite': member['isFavorite'] == 1,
      };
    }).toList();
  }

  // Get non-favorite members
  Future<List<Map<String, dynamic>>> getNonFavorites() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query('Members', where: 'isFavorite = ?', whereArgs: [0]);
    return result.map((member) {
      return {
        ...member,
        'hobbies': getHobbiesList(member['hobbies']),
        'isFavorite': member['isFavorite'] == 1,
      };
    }).toList();
  }

  // Toggle favorite status of a member
  Future<void> toggleFavorite(int id) async {
    final db = await initDatabase();
    Map<String, dynamic> member = await getMemberById(id);

    // Ensure `isFavorite` is treated as an integer (0 or 1)
    int isFavorite = member['isFavorite'] ? 0 : 1; // Toggle favorite status
    member['isFavorite'] = isFavorite;

    member['hobbies'] = getHobbiesString(member['hobbies']);

    await db.update(
      'Members',
      member,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search members by query, age range, gender, and favorite status
  Future<List<Map<String, dynamic>>> searchMembers({
    String query = '',
    // RangeValues ageRange = const RangeValues(0, 100),
    // int selectedGender = 2, // 2 means all genders
    bool isFavorite = false,
  })
  async {
    final db = await initDatabase();
    List<Map<String, dynamic>> allMembers = await getAllMembers();

    List<Map<String, dynamic>> result = allMembers.where((member) {
      // Filter by favorite status
      if (isFavorite && member['isFavorite'] != true) return false;

      // Filter by gender
      // if (selectedGender != 3 && member['gender'] != selectedGender) return false;

      // Filter by age range
      // int age = getAge(member['dateOfBirth']);
      // if (age < ageRange.start || age > ageRange.end) return false;

      // Filter by query
      if (query.isNotEmpty) {
        bool isMatch = false;
        member.forEach((key, value) {
          if (key != 'id' && value.toString().toLowerCase().contains(query.toLowerCase())) {
            isMatch = true;
          }
        });
        if (!isMatch) return false;
      }

      return true;
    }).toList();
    return result;
  }

  // Helper function to calculate age from date of birth
  int getAge(String dateOfBirth) {
    try {
      // Split the date string into day, month, and year
      final parts = dateOfBirth.split('/');
      if (parts.length != 3) {
        throw FormatException('Invalid date format: $dateOfBirth');
      }

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Create a DateTime object
      final dob = DateTime(year, month, day);
      final now = DateTime.now();

      // Calculate age
      int age = now.year - dob.year;
      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
        age--;
      }

      return age;
    } catch (e) {
      print('Error parsing date: $e');
      return 0; // Return a default value or handle the error as needed
    }
  }

  String getHobbiesString(List<String> hobbies) {
    return hobbies.join(',');
  }

  List<String> getHobbiesList(String hobbiesString) {
    return hobbiesString.split(',');
  }
}

Members members = Members();