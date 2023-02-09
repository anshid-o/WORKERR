// import 'package:flutter/material.dart';
// import 'package:workerr_app/core/colors.dart';
// import 'package:workerr_app/core/constants.dart';
// import 'package:workerr_app/presentation/user/screens/main/chat/chat_screen_child.dart';
// import 'package:workerr_app/presentation/user/screens/main/home/update_status.dart';
// import 'package:workerr_app/presentation/user/screens/main/post/show_workers.dart';

// class WorkCard extends StatefulWidget {
//   const WorkCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<WorkCard> createState() => _WorkCardState();
// }

// class _WorkCardState extends State<WorkCard> {
//   List<String> status = [
//     'Requested',
//     'Accepted',
//     'Completed',
//     'Failed',
//   ];
//   List<String> rate = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//   ];
//   String selectedStatus = 'Requested';
//   String selectedrate = '3';
//   String selectedItem = 'Anshid O';
//   bool isPressed = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       child: Row(
//         children: [
//           Container(
//             width: 280,
//             height: 160,
//             // color: Colors.blue,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               gradient: kbluegd,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     children: const [
//                       Icon(
//                         Icons.color_lens,
//                         shadows: kshadow,
//                         color: Color.fromARGB(255, 1, 51, 8),
//                       ),
//                       Text(
//                         'Painting',
//                         style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w800,
//                             color: kred,
//                             letterSpacing: 3),
//                       ),
//                       // Spacer(),
//                       kwidth30,

//                       Text(
//                         '10/05/2021',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     width: 300,
//                     height: 105,
//                     child: const Center(
//                       child: Text(
//                         'I have a painting job to be done in my new shop, it has almost 2000 square feet wall. i want to be done this work before 15th. If you intrested to do the work , Please contact.',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(6, 0, 10, 0),
//                 child: Text(
//                   'Status',
//                   style: TextStyle(
//                     // shadows: kshadow,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: kred,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 tooltip: 'Update Status',
//                 onPressed: () {
//                   showModalBottomSheet(
//                       backgroundColor: Color.fromARGB(255, 255, 249, 191),
//                       isScrollControlled: true,
//                       context: context,
//                       shape: const RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(20))),
//                       builder: (context) => Container(
//                             padding: EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Text(
//                                       'Choose Status :',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     ksize(y: 8),
//                                     SizedBox(
//                                       width: 200,
//                                       child: DropdownButtonFormField<String>(
//                                         decoration: InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                                 borderSide: BorderSide(
//                                                     width: 4, color: kgreen))),
//                                         value: selectedStatus,
//                                         items: status
//                                             .map(
//                                               (item) =>
//                                                   DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style:
//                                                       TextStyle(fontSize: 15),
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                         onChanged: (item) {
//                                           setState(() {
//                                             selectedStatus = item!;
//                                           });
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 kheight,
//                                 if (selectedStatus != 'Requested')
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Choose Worker :',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       ksize(y: 3),
//                                       SizedBox(
//                                         width: 200,
//                                         child: DropdownButtonFormField<String>(
//                                           decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                   borderSide: BorderSide(
//                                                       width: 4,
//                                                       color: kgreen))),
//                                           value: selectedItem,
//                                           items: workers
//                                               .map(
//                                                 (item) =>
//                                                     DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style:
//                                                         TextStyle(fontSize: 15),
//                                                   ),
//                                                 ),
//                                               )
//                                               .toList(),
//                                           onChanged: (item) {
//                                             setState(() {
//                                               selectedItem = item!;
//                                             });
//                                           },
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 kheight,
//                                 if (selectedStatus != 'Requested')
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Rate :',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       ksize(y: 80),
//                                       SizedBox(
//                                         width: 200,
//                                         child: DropdownButtonFormField<String>(
//                                           decoration: InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                   borderSide: BorderSide(
//                                                       width: 4,
//                                                       color: kgreen))),
//                                           value: selectedrate,
//                                           items: rate
//                                               .map(
//                                                 (item) =>
//                                                     DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style:
//                                                         TextStyle(fontSize: 15),
//                                                   ),
//                                                 ),
//                                               )
//                                               .toList(),
//                                           onChanged: (item) {
//                                             setState(() {
//                                               selectedrate = item!;
//                                             });
//                                           },
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 kheight,
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     ksize(y: 85),
//                                     Container(
//                                       width: 115,
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           color: kgreen,
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Center(
//                                         child: TextButton(
//                                           onHover: (hovered) => setState(() {
//                                             this.isPressed = hovered;
//                                           }),
//                                           style: TextButton.styleFrom(
//                                               side: BorderSide(
//                                                   color: Colors.white,
//                                                   width: 4),
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10))),
//                                           onPressed: () {
//                                             // await Future.delayed(const Duration(milliseconds: 800));

//                                             Navigator.pop(context);
//                                           },
//                                           onLongPress: () {
//                                             // Navigator.pop(context);
//                                           },
//                                           child: Listener(
//                                             onPointerDown: (event) =>
//                                                 setState(() {
//                                               isPressed = true;
//                                             }),
//                                             onPointerUp: (event) =>
//                                                 setState(() {
//                                               isPressed = false;
//                                             }),
//                                             child: SizedBox(
//                                               width: 100,
//                                               height: 30,
//                                               child: Center(
//                                                 child: Text(
//                                                   'Update',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     shadows: [
//                                                       for (double i = 1;
//                                                           i <
//                                                               (isPressed
//                                                                   ? 10
//                                                                   : 6);
//                                                           i++)
//                                                         Shadow(
//                                                           color: kshadowColor,
//                                                           blurRadius: 3,
//                                                         )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ));
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => UpdateStatus(),
//                   //   ),
//                   // );
//                 },
//                 icon: const Icon(
//                   Icons.markunread,
//                   color: kgreen2,
//                   size: 30,
//                   shadows: kshadow,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
