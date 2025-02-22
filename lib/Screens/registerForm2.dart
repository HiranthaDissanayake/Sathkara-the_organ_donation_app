import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:organ_donation_app/Services/saveBloodDonarDetails.dart';
import 'package:organ_donation_app/theme/ThemeProvider.dart';
import 'package:provider/provider.dart';

class BloodDonationFormPage extends StatefulWidget {
  const BloodDonationFormPage({super.key});

  @override
  State<BloodDonationFormPage> createState() => _BloodDonationFormPageState();
}

class _BloodDonationFormPageState extends State<BloodDonationFormPage> {

  String _selectedHospital = 'Select Nearby Hospital';
  String _selectedBloodType = 'Select Blood Type';
  String _selectedGender = 'Select Gender';

  DateTime _selectedBirthDate = DateTime.now();
  DateTime _selectedLastDonatedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _dateLastDonated = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _medicalConditionController = TextEditingController();
  final TextEditingController _previousSurgeriesController = TextEditingController();
  final TextEditingController _anyDiseasesController = TextEditingController();

  final List<String> _hospitals = [
    'Select Nearby Hospital',
    'Kandy Hospital',
    'Colombo Hospital',
    'Galle Hospital',
    'Jaffna Hospital',
    'Matara Hospital',
  ];

  final List<String> _bloodTypes = [
    'Select Blood Type',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final List<String> _genderType = [
    'Select Gender',
    'Male',
    'Female',
  ];

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _selectedBirthDate = picked;
          _birthDateController.text = DateFormat.yMd().format(_selectedBirthDate);
        } else {
          _selectedLastDonatedDate = picked;
          _dateLastDonated.text = DateFormat.yMd().format(_selectedLastDonatedDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themProvider = Provider.of<Themeprovider>(context);
    final bool isDarkMode = themProvider.isDarkMode;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(179, 205, 224, 1),
      body: Container(
        decoration: isDarkMode
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Images/image.png"),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Images/background_image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, right: 30, left: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Enter Blood Donor Details",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Full Name Of Donor"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _idController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ID number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("ID Number"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Donor Address"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Contact Number"),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _birthDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date of birth';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text("Date Of Birth"),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () => _selectDate(context, true),
                                icon: const Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: DropdownButton(
                            value: _selectedGender,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue as String;
                              });
                            },
                            items: _genderType.map((genderType) {
                              return DropdownMenuItem(
                                value: genderType,
                                child: Text(genderType),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButton(
                      value: _selectedHospital,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedHospital = newValue as String;
                        });
                      },
                      items: _hospitals.map((hospital) {
                        return DropdownMenuItem(
                          value: hospital,
                          child: Text(hospital),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    const Text("Medical History Of Donor"),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _medicalConditionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your medical history';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Medical Conditions"),
                        border: OutlineInputBorder(),
                        helperText: 'such as diabetes, hypertension, etc.',
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton(
                      value: _selectedBloodType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBloodType = newValue as String;
                        });
                      },
                      items: _bloodTypes.map((bloodType) {
                        return DropdownMenuItem(
                          value: bloodType,
                          child: Text(bloodType),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _previousSurgeriesController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your previous surgeries';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Previous Surgeries"),
                        border: OutlineInputBorder(),
                        helperText: 'Any previous surgeries the donor has undergone.',
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _dateLastDonated,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last donation date';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text("Last Donation Date"),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => _selectDate(context, false),
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _anyDiseasesController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your infectious diseases';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Do you have any infectious diseases"),
                        helperText: 'e.g: Hepatitis, HIV',
                        border: OutlineInputBorder(),
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                _selectedBloodType != 'Select Blood Type' &&
                                _selectedGender != 'Select Gender' && _selectedHospital != 'Select Nearby Hospital') {
                              await Saveblooddonardetails().addBloodDonarDetails(
                                _nameController.text,
                                _idController.text,
                                _addressController.text,
                                _phoneController.text,
                                _selectedBirthDate,
                                _selectedGender,
                                _selectedHospital,
                                _medicalConditionController.text,
                                _selectedBloodType,
                                _previousSurgeriesController.text,
                                _selectedLastDonatedDate,
                                _anyDiseasesController.text,
                              );

                              // Clear the fields
                              _nameController.clear();
                              _idController.clear();
                              _addressController.clear();
                              _phoneController.clear();
                              _medicalConditionController.clear();
                              _previousSurgeriesController.clear();
                              _anyDiseasesController.clear();
                              _birthDateController.clear();
                              _dateLastDonated.clear();
                              _selectedBirthDate = DateTime.now();
                              _selectedLastDonatedDate = DateTime.now();

                              setState(() {
                                _selectedHospital = 'Select Nearby Hospital';
                                _selectedGender = 'Select Gender';
                                _selectedBloodType = 'Select Blood Type';
                              });

                              openDialog(context);
                            }

                            else if (_selectedBloodType == 'Select Blood Type' || _selectedGender == 'Select Gender' || _selectedHospital == 'Select Nearby Hospital') {
                              Fluttertoast.showToast(
                                msg: "Please select a valid blood type, gender and hospital.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: isDarkMode
                                ? MaterialStateProperty.all(Colors.grey.shade700)
                                : MaterialStateProperty.all(Color.fromRGBO(1, 31, 75, 1)),
                          ),
                          child: const Text(
                            "SUBMIT",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
              child: Text(
            "Terms and Conditions",
            style: TextStyle(fontSize: 20),
          )),
          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Blood Donors must:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    const Text("1. Be at least 18 years old."),
                    const SizedBox(height: 10),
                    const Text("2. Be in good physical and mental health."),
                    const SizedBox(height: 10),
                    const Text(
                        "3. Not have any medical conditions that would make donation unsafe for the donor or the recipient."),
                    const SizedBox(height: 10),
                    const Text(
                        "4. Not have any infectious diseases that could be transmitted through blood donation."),
                    const SizedBox(height: 10),
                    const Text("5. Not be pregnant or breastfeeding."),
                    const SizedBox(height: 10),
                    const Text(
                        "6. Not have a history of substance abuse or addiction."),
                    const SizedBox(height: 10),
                    const Text(
                        "7. Be aware of the risks involved in blood donation."),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const Text(
                        "8. Make a voluntary decision to donate blood without coercion or undue influence."),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Donor Registered Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(1, 31, 75, 1))),
                      child: const Text(
                        "I Agree",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}