import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/color_use.dart';
import 'package:sweet_favors/pages/Wish/wish_details.dart';

class WishGrant extends StatelessWidget {
  final String price;
  // final String picture;

  const WishGrant({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(children: [
                    Image.asset(
                      'assets/myGirl.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: colorUse.textColorSecondary,
                        shadows: [
                          Shadow(
                            blurRadius: 15.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(8, 5),
                          )
                        ],
                      ),
                    )
                  ])),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishDetails(),
                      // builder: (context) => WishDetails(product: product, grantBy: grantBy),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('View wish detail'),
                ),
              ))
            ],
          )),
    );
  }
}

// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});

//   @override
//   State<MyCustomForm> createState() => _MyCustomFormState();
// }

// class _MyCustomFormState extends State<MyCustomForm> {
//   final _formKey = GlobalKey<FormState>();
//   final myConroterName = TextEditingController();
//   final myConroterNum = TextEditingController();
//   final myConroterMail = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     myConroterName.dispose();
//     myConroterNum.dispose();
//     myConroterMail.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//         body: Center(
//           child: Container(
//             width: 600,
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               border: Border.all(
//                   color: const Color(0xFF000000),
//                   width: 4.0,
//                   style: BorderStyle.solid), //Border.all
//               /*** The BorderRadius widget  is here ***/
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               color: Color.fromARGB(255, 178, 115, 255),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 26),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Input your name',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please input your name';
//                         }
//                         return null;
//                       },
//                       controller: myConroterName,
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 26),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Input your student number',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please input your student number';
//                         } else {
//                           final isNumber = RegExp(r"^[0-9]");
//                           if (isNumber.hasMatch(value) && value.length == 11) {
//                             return null;
//                           } else {
//                             return "Must be 11 digit";
//                           }
//                         }
//                       },
//                       controller: myConroterNum,
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 26),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'Input your email',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please input your email';
//                         } else {
//                           final isEmail = RegExp(
//                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//                           if (isEmail.hasMatch(value)) {
//                             return null;
//                           } else {
//                             return "Must be an email";
//                           }
//                         }
//                       },
//                       controller: myConroterMail,
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 98, 255, 200),
//                         ),
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailScreen(
//                                     name: myConroterName.text,
//                                     num: myConroterNum.text,
//                                     mail: myConroterMail.text),
//                               ),
//                             );
//                           }
//                         },
//                         child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Submit your info'),
//                               ),
//                               Icon(Icons.add_task)
//                             ]),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailScreen extends StatelessWidget {
//   // In the constructor, require a Todo.
//   const DetailScreen(
//       {super.key, required this.name, required this.num, required this.mail});

//   // Declare a field that holds the Todo.
//   final String name;
//   final String num;
//   final String mail;

//   @override
//   Widget build(BuildContext context) {
//     // Use the Todo to create the UI.
//     return Scaffold(
//         body: Center(
//             child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: const Color(0xFF000000),
//             width: 4.0,
//             style: BorderStyle.solid), //Border.all
//         /*** The BorderRadius widget  is here ***/
//         borderRadius: BorderRadius.all(
//           Radius.circular(10),
//         ),
//         color: Color.fromARGB(255, 255, 115, 232),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           const Text('This is your information gathered from the last page'),
//           Text('Your Name: '+name),
//           Text('Your student number: '+num),
//           Text('Your email: '+mail)
//         ]),
//       ),
//     )));
//   }
// }
