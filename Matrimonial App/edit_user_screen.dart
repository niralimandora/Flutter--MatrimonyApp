import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class AddEdit extends StatefulWidget {
  Map<String,dynamic>? userDetail;
  AddEdit({super.key, Map<String,dynamic>? userDetail, required Map user}) {
    this.userDetail = userDetail;
  }

  @override
  State<AddEdit> createState() => _AddEdit();
}

class _AddEdit extends State<AddEdit> {
  List<String> city = ['Rajkot','Ahmedabad','Surat','Vadodara','Jamnagar','Amritsar','Chandigarh'];
  String? selectedCity;
  DateTime? selectedDate;
  bool hobbyChecked = false;
  bool passObscure = true;
  String? selectedGender;
  String? selectedStatus;

  TextEditingController fnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // TextEditingController higheducationController = TextEditingController();
  // TextEditingController occupationController = TextEditingController();
  // TextEditingController religionController = TextEditingController();
  // TextEditingController casteController = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime adultDate = DateTime(currentDate.year - 18, currentDate.month, currentDate.day);

    DateTime? datePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: adultDate
    );

    if(datePicker != null) {
      setState(() {
        selectedDate = datePicker;
        dateController.text = DateFormat('yyyy-MM-dd').format(datePicker);
      });
    }
  }

  String? validateDob(String? value) {
    if(value == null || value.isEmpty) {
      return "Please select your date of birth.";
    }

    DateTime dob = DateTime.parse(value);
    DateTime today = DateTime.now();
    int age = today.year - dob.year;

    if(today.month < dob.month || today.month == dob.month && today.day < dob.day) {
      age--;
    }

    if(age<18) {
      return "You must be at least 18 to register";
    }
    return null;
  }

  //hobbies
  Map<String,bool> hobbies = {
    'Reading' : false,
    'Eating' : false,
    'Cooking' : false,
  };

  void initState() {
    super.initState();

    // Initialize controllers with old data
    fnameController = TextEditingController(text: "${widget.userDetail?['fName'] ?? ''}");

    // selectedGender = TextEditingController(text: widget.userDetail?['gender'] ?? '');
    dateController = TextEditingController(text: widget.userDetail?['dob'] ?? '');
    // selectedStatus = TextEditingController(text: widget.userDetail?['maritalStatus'] ?? '');
    // religionController = TextEditingController(text: widget.userDetail?['religion'] ?? '');
    // casteController = TextEditingController(text: widget.userDetail?['caste'] ?? '');
    // higheducationController = TextEditingController(text: widget.userDetail?['education'] ?? '');
    // occupationController = TextEditingController(text: widget.userDetail?['occupation'] ?? '');
    emailController = TextEditingController(text: widget.userDetail?['Email'] ?? '');
    phoneController = TextEditingController(text: widget.userDetail?['Phone'] ?? '');
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,

        title: Text(
          'User Details',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'DancingScript',
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade900),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("Full Name: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: fnameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z ]*$')),
                          ],
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return 'Please enter First Name';
                            }
                            if (!RegExp(r"^[a-zA-Z\s']{3,50}$").hasMatch(value)) {
                              return 'Enter valid First Name';
                            }
                            return null;
                          },
                        ),
                      ),

                    ],
                  ), //firstname
                  //               SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("DOB: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Date of Birth',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () => selectDate(context),
                            validator: validateDob,
                          )
                      ),
                    ],
                  ),  //dob
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("Email: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return 'Please enter email address';
                            }
                            if(!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                              return "Enter Valid Email Address";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ), //email
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("Mobile: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')), // Only allows digits (0-9)
                            LengthLimitingTextInputFormatter(10)
                          ],
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return 'Please enter Mobile Number';
                            }
                            if(!RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)) {
                              return "Enter Valid Mobile Number";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ), //mobile
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("City: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child:
                        DropdownButton<String>(
                          value: selectedCity,
                          hint: Text('Choose your city'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                          isExpanded: true,
                          items: city.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ), //city
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Gender: ", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 5,),
                      Radio<String>(value: "Female",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text('Female',style: TextStyle(fontWeight: FontWeight.bold),),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Radio<String>(value: "Male",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text('Male',style: TextStyle(fontWeight: FontWeight.bold),),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Radio<String>(value: "Other",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text('Other',style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ), //gender
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text("Maritial Status: ", style: TextStyle(fontSize: 16)),
                  //
                  //     Radio<String>(value: "Never Married",
                  //       groupValue: selectedStatus,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedStatus = value;
                  //         });
                  //       },
                  //     ),
                  //     Text('Never Married',style: TextStyle(fontWeight: FontWeight.bold),),
                  //     // SizedBox(
                  //     //   width: 20,
                  //     // ),
                  //     Radio<String>(value: "Divorced",
                  //       groupValue: selectedStatus,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedStatus = value;
                  //         });
                  //       },
                  //     ),
                  //     Text('Divorced',style: TextStyle(fontWeight: FontWeight.bold),),
                  //   ],
                  // ),//maritial status
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child:
                  //       Text("Religion: ", style: TextStyle(fontSize: 16)),
                  //     ),
                  //     // SizedBox(width: 10,),
                  //     // Expanded(
                  //     //   flex: 3,
                  //     //   child: TextFormField(
                  //     //     controller: religionController,
                  //     //     decoration: InputDecoration(
                  //     //       enabledBorder: UnderlineInputBorder(
                  //     //         borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                  //     //       ),
                  //     //     ),
                  //     //     keyboardType: TextInputType.text,
                  //     //     validator: (value) {
                  //     //       if (value == null || value!.isEmpty) {
                  //     //         return 'Please enter your Religion';
                  //     //       }
                  //     //       return null;
                  //     //     },
                  //     //   ),
                  //     // ),
                  //   ],
                  // ), //religion
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child:
                  //       Text("Caste: ", style: TextStyle(fontSize: 16)),
                  //     ),
                  //     // SizedBox(width: 10,),
                  //     // Expanded(
                  //     //   flex: 3,
                  //     //   child: TextFormField(
                  //     //     controller: casteController,
                  //     //     decoration: InputDecoration(
                  //     //       enabledBorder: UnderlineInputBorder(
                  //     //         borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                  //     //       ),
                  //     //     ),
                  //     //     keyboardType: TextInputType.text,
                  //     //     validator: (value) {
                  //     //       if (value == null || value!.isEmpty) {
                  //     //         return 'Please enter your Religion';
                  //     //       }
                  //     //       return null;
                  //     //     },
                  //     //   ),
                  //     // ),
                  //   ],
                  // ), //caste
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child:
                  //       Text("Higher Education: ", style: TextStyle(fontSize: 16)),
                  //     ),
                  //     // SizedBox(width: 10,),
                  //     // Expanded(
                  //     //   flex: 3,
                  //     //   child: TextFormField(
                  //     //     controller: higheducationController,
                  //     //     decoration: InputDecoration(
                  //     //       enabledBorder: UnderlineInputBorder(
                  //     //         borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                  //     //       ),
                  //     //     ),
                  //     //     keyboardType: TextInputType.text,
                  //     //     validator: (value) {
                  //     //       if (value == null || value!.isEmpty) {
                  //     //         return 'Please enter Education Detail';
                  //     //       }
                  //     //       return null;
                  //     //     },
                  //     //   ),
                  //     // ),
                  //   ],
                  // ), //higher edu
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child:
                  //       Text("Occupation: ", style: TextStyle(fontSize: 16)),
                  //     ),
                  //     // SizedBox(width: 10,),
                  //     // Expanded(
                  //     //   flex: 3,
                  //     //   child: TextFormField(
                  //     //     controller: occupationController,
                  //     //     decoration: InputDecoration(
                  //     //       enabledBorder: UnderlineInputBorder(
                  //     //         borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                  //     //       ),
                  //     //     ),
                  //     //     keyboardType: TextInputType.text,
                  //     //     validator: (value) {
                  //     //       if (value == null || value!.isEmpty) {
                  //     //         return 'Please enter Occupation Detail';
                  //     //       }
                  //     //       return null;
                  //     //     },
                  //     //   ),
                  //     // ),
                  //   ],
                  // ), //occupation
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("Password: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: passController,
                          obscureText: passObscure,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                              ),
                              suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                  passObscure = !passObscure;
                                });
                              }, icon: Icon(passObscure ?  Icons.visibility_off : Icons.visibility))
                          ),
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ), //password
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                        Text("Confirm Password: ", style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: confPassController,
                          obscureText: passObscure,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFB71C1C), width: 1.0),
                              ),
                              suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                  passObscure = !passObscure;
                                });
                              }, icon: Icon(passObscure ?  Icons.visibility_off : Icons.visibility))
                          ),
                          validator: (value) {
                            if (value != passController.text.toString().toLowerCase() || value!.isEmpty) {
                              return 'Please enter Confirm Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ), //confirmPassword
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle button press
                            if(_formKey.currentState!.validate()) {
                              Map<String, dynamic> map = {};
                              map['fName'] = fnameController.text.toString();

                              map['Email'] = emailController.text.toString();
                              map['Phone'] = phoneController.text.toString();
                              map['city'] = selectedCity.toString();
                              map['Password'] = passController.text.toString();
                              map['ConPassword'] = confPassController.text
                                  .toString();
                              map['dob'] = dateController.text.toString();
                              map['gender'] = selectedGender.toString();
                              map['maritialStatus'] = selectedStatus.toString();
                              // map['education'] = higheducationController.text.toString();
                              // map['religion'] = religionController.text.toString();
                              // map['occupation'] = occupationController.text.toString();
                              // map['caste'] = casteController.text.toString();

                              Navigator.pop(context, map);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color:Color(0xFFB71C1C),width: 2.0),
                            backgroundColor: Color(0xFFB71C1C),
                          ),
                          child: Text(
                            widget.userDetail == null ? "Save" : "Edit"
                            ,style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle button press
                            fnameController.clear();

                            emailController.clear();
                            phoneController.clear();
                            passController.clear();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color:Colors.pink
                                ,width: 2.0),
                            backgroundColor: Colors.pink.shade200,
                          ),
                          child: Text("Reset",style: TextStyle(color: Colors.black,fontSize: 20),),
                        ),
                      )

                    ],
                  ), //elevatedbutton
                  SizedBox(height: 10,),
                ],
              ),)
        ),
      ),
    );
  }
}