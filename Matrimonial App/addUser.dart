import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database.dart';

class AddUserScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
  const AddUserScreen({super.key, this.user});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? _fullName = TextEditingController();
  TextEditingController? _email = TextEditingController();
  TextEditingController? _phone = TextEditingController();
  TextEditingController? _dateOfBirth =
      TextEditingController(); // Store date as String (dd-mm-yyyy)
  String? _city;
  int? _gender;
  List<String> _hobbies = [];
  TextEditingController? _password = TextEditingController();
  TextEditingController? _confirmPassword = TextEditingController();
  bool _isObscureConfirmPassword = true;
  bool _isObscurePassword = true;
  @override
  void initState() {
    // TODO: implement initState
    _fullName?.text=widget.user!["name"];
    _email?.text=widget.user!["email"];
    _dateOfBirth?.text=widget.user!["dateOfBirth"];
    _password?.text=widget.user!["password"];
    _confirmPassword?.text=widget.user!["password"];
    _city=widget.user!["city"];
    _gender=widget.user!["gender"];
    _hobbies=widget.user!["hobbies"];
    _phone?.text=widget.user!["phone"].toString();
    super.initState();
  }
  // For City dropdown
  final List<String> _cities = [
    "Agra",
    "Ahmedabad",
    "Allahabad",
    "Amritsar",
    "Aurangabad",
    "Bangalore",
    "Bhopal",
    "Bhubaneswar",
    "Chandigarh",
    "Chennai",
    "Coimbatore",
    "Delhi",
    "Faridabad",
    "Ghaziabad",
    "Gurgaon",
    "Guwahati",
    "Hyderabad",
    "Indore",
    "Jaipur",
    "Jalandhar",
    "Jamshedpur",
    "Kanpur",
    "Kochi",
    "Kolkata",
    "Lucknow",
    "Ludhiana",
    "Madurai",
    "Meerut",
    "Mumbai",
    "Nagpur",
    "Nashik",
    "Noida",
    "Patna",
    "Pune",
    "Raipur",
    "Rajkot",
    "Ranchi",
    "Surat",
    "Thane",
    "Thiruvananthapuram",
    "Vadodara",
    "Varanasi",
    "Vijayawada",
    "Visakhapatnam"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // Assign the formatted date to the TextEditingController's text property
        _dateOfBirth?.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  String? _validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your date of birth';
    }

    // Parse date and calculate age
    final dateParts = value.split('-');
    if (dateParts.length != 3) {
      return 'Enter a valid date in dd-mm-yyyy format';
    }

    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    final birthDate = DateTime(year, month, day);
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    if (age < 18 || age > 80) {
      return 'Age must be between 18 and 80';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title:Text(widget.user != null ? "Edit User" : "Add User",
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.pink.shade50,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Full Name
                    TextFormField(
                      controller: _fullName,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.pink),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(Icons.close, size: 16),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z\s'-]")),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        final regExp = RegExp(r"^[a-zA-Z\\'-]{3,50}$");
                        if (!regExp.hasMatch(value)) {
                          return 'Enter a valid full name (3-50 characters, alphabets only)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Email
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email:",
                        labelStyle: TextStyle(color: Colors.pink),
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        final regExp = RegExp(
                            r'^[a-zA-Z0-9._%+]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!regExp.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Phone Number
                    TextFormField(
                      controller: _phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.pink),
                        hintText: 'Enter your Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        final regExp = RegExp(r'^\+?[0-9]{10,15}$');
                        if (!regExp.hasMatch(value)) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Date of Birth (with Calendar Picker)
                    TextFormField(
                      controller: _dateOfBirth,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: Colors.pink),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: _validateDateOfBirth,
                    ),
                    SizedBox(height: 10),

                    // City (Dropdown)
                    DropdownButtonFormField<String>(
                      value: _city,
                      decoration: InputDecoration(

                        labelText: 'City',
                        labelStyle: TextStyle(color: Colors.pink),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),

                        ),
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem<String>(
                            value: city, child: Text(city));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _city = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700, width: 1), // Pink border
                        borderRadius: BorderRadius.circular(40), // Rounded corners
                      ),
                      padding: EdgeInsets.all(2), // Padding inside the container
                      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 8), // Margin around the container
                      child: ListTile(
                        title: Text(
                          'Gender :',
                          style: TextStyle(color: Colors.pink, fontSize: 17),
                        ),
                        subtitle: Row(
                          children: [
                            Radio<int>(
                              value: 0, // Male
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            Text('Male', style: TextStyle(color: Colors.pink, fontSize: 17)),
                            Radio<int>(
                              value: 1, // Female
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            Text('Female', style: TextStyle(color: Colors.pink, fontSize: 17)),
                            Radio<int>(
                              value: 2, // Other
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            Text('Other', style: TextStyle(color: Colors.pink, fontSize: 17)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(// Background color of the container
                        borderRadius: BorderRadius.circular(30), // Rounded border
                        border: Border.all(width: 1), // Pink border
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Hobbies :',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CheckboxListTile(
                              title: Text('Reading'),
                              value: _hobbies.contains('Reading'),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    _hobbies.add('Reading');
                                  } else {
                                    _hobbies.remove('Reading');
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CheckboxListTile(
                              title: Text('Traveling'),
                              value: _hobbies.contains('Traveling'),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    _hobbies.add('Traveling');
                                  } else {
                                    _hobbies.remove('Traveling');
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CheckboxListTile(
                              title: Text('Cooking'),
                              value: _hobbies.contains('Cooking'),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    _hobbies.add('Cooking');
                                  } else {
                                    _hobbies.remove('Cooking');
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    //Password
                    TextFormField(
                      controller: _password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.pink),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        },
                      )),
                      obscureText: _isObscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (!RegExp(
                                r'^(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                            .hasMatch(value)) {
                          return 'Password must contain at least one number, one special character, and be at least 6 characters long';
                        }
                        return null;
                      },
                    ),

              SizedBox(height: 10),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.pink),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirmPassword = !_isObscureConfirmPassword;
                          });
                        },
                      ),),
                      obscureText: _isObscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _password?.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

              SizedBox(height: 10),

                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            // Save the form

                            Map<String, dynamic> userData = {
                              'name': _fullName?.text,
                              'email': _email?.text,
                              'phone': _phone?.text,
                              'dateOfBirth': _dateOfBirth?.text,
                              'city':_city,
                              'gender': _gender,
                              'hobbies': _hobbies,
                              'password': _password?.text,
                              'isFavorite': false,
                            };

                            members.addMember(userData);

                            // You can now add userData to your list
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Entry is successful!'),
                                backgroundColor: Colors.pink.shade200,
                              ),
                            );

                            _formKey.currentState!.reset();
                            setState(() {
                              _formKey.currentState!.reset();
                              _fullName?.clear();
                              _email?.clear();
                              _phone?.clear();
                              _dateOfBirth?.clear();
                              _city = null;
                              _gender = null;
                              _hobbies = [];
                              _password?.clear();
                              _confirmPassword?.clear();
                            });
                          }
                          Navigator.pop(context);
                        },

                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.pink.shade900, fontSize: 20),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
