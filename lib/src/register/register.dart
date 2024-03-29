import 'package:flutter/material.dart';
import 'package:probation/components/text_field.dart';
import 'package:probation/controller/member_controller.dart';
import 'package:probation/model/member.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  Future<Member>? futureMember;

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: (futureMember == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 80),
        child: const Text('Registration'),
      ),

      const SizedBox(
        height: 20,
      ),

      // username input
      UsernameTextField(
        controller: emailController,
        hintText: 'Email',
      ),

      const SizedBox(
        height: 20,
      ),

      // username input
      UsernameTextField(
        controller: firstNameController,
        hintText: 'First Name',
      ),

      const SizedBox(
        height: 20,
      ),

      // username input
      UsernameTextField(
        controller: lastNameController,
        hintText: 'Last Name',
      ),

      const SizedBox(
        height: 20,
      ),

      // username input
      UsernameTextField(
        controller: phoneNumberController,
        hintText: 'Phone Number',
      ),

      // const SizedBox(
      //   height: 20,
      // ),

      // //  password input
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 23),
      //   height: 50,
      //   child: TextField(
      //     // controller: controller,
      //     obscureText: hidePassword,
      //     decoration: InputDecoration(
      //         enabledBorder: const OutlineInputBorder(
      //           borderSide: BorderSide(width: 1, color: Colors.blue),
      //         ),
      //         focusedBorder: const OutlineInputBorder(
      //           borderSide: BorderSide(color: Colors.blue),
      //         ),
      //         hintText: 'Password',
      //         suffixIcon: IconButton(
      //             onPressed: () {
      //               setState(() {
      //                 hidePassword = !hidePassword;
      //               });
      //             },
      //             icon: Icon(
      //                 hidePassword ? Icons.lock : Icons.remove_red_eye))),
      //   ),
      // ),

      // const SizedBox(
      //   height: 20,
      // ),

      // // repeat password
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 23),
      //   height: 50,
      //   child: TextField(
      //     // controller: controller,
      //     obscureText: hidePassword,
      //     decoration: InputDecoration(
      //         enabledBorder: const OutlineInputBorder(
      //           borderSide: BorderSide(width: 1, color: Colors.blue),
      //         ),
      //         focusedBorder: const OutlineInputBorder(
      //           borderSide: BorderSide(color: Colors.blue),
      //         ),
      //         hintText: 'Retype Password',
      //         suffixIcon: IconButton(
      //             onPressed: () {
      //               setState(() {
      //                 hidePassword = !hidePassword;
      //               });
      //             },
      //             icon: Icon(
      //                 hidePassword ? Icons.lock : Icons.remove_red_eye))),
      //   ),
      // ),
      const SizedBox(
        height: 30,
      ),

      SizedBox(
        height: 40,
        width: 170,
        child: Material(
          // borderRadius: BorderRadius.circular(10),
          // color: Colors.amber,
          elevation: 7,
          // shadowColor: Colors.yellow,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                futureMember = createMember(
                  emailController.text,
                  firstNameController.text,
                  lastNameController.text,
                  phoneNumberController.text,
                );
              });
            },
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  FutureBuilder<Member> buildFutureBuilder() {
    return FutureBuilder<Member>(
      future: futureMember,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Registration Completed'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
          // Center(
          //   child: Column(children: [
          //     Text(
          //       snapshot.data!.email,
          //     ),
          //      Text(
          //       snapshot.data!.first_name,
          //     ),
          //      Text(
          //       snapshot.data!.last_name,
          //     ),
          //      Text(
          //       snapshot.data!.phone_number,
          //     )
          //   ]),
          // );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Text('${snapshot.error}'),
          );
        }

        return const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ));
      },
    );
  }
}
