// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../../models/chari.dart';

// class AddEditChariPage extends StatefulWidget {
//   final Chari? currentChari;
//   const AddEditChariPage({Key? key, this.currentChari}) : super(key: key);

//   @override
//   State<AddEditChariPage> createState() => _AddEditChariPageState();
// }

// class _AddEditChariPageState extends State<AddEditChariPage> {
//   TextEditingController brandController = TextEditingController();
//   TextEditingController frameController = TextEditingController();
//   TextEditingController detailController = TextEditingController();

//   String isSelectedCategory = 'single';

// // 新規投稿
//   Future<void> createChari() async {
//     final chariCollection = FirebaseFirestore.instance.collection('chari');
//     await chariCollection.add({
//       'category': isSelectedCategory,
//       'brand': brandController.text,
//       'frame': frameController.text,
//       'detail': detailController.text,
//       'createdDate': Timestamp.now()
//     });
//   }

// // 更新
//   Future<void> updateChari() async {
//     final doc = FirebaseFirestore.instance
//         .collection('chari')
//         .doc(widget.currentChari!.id);
//     await doc.update({
//       'category': isSelectedCategory,
//       'brand': brandController.text,
//       'frame': frameController.text,
//       'detail': detailController.text,
//       'updatedDate': Timestamp.now()
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.currentChari != null) {
//       brandController.text = widget.currentChari!.brand;
//       frameController.text = widget.currentChari!.frame;
//       detailController.text = widget.currentChari!.detail!;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title:
//               Text(widget.currentChari == null ? 'new chari' : 'edit chari')),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const Text('category'),
//             const SizedBox(
//               height: 1,
//             ),
//             DropdownButton(
//               items: <String>[
//                 'single',
//                 'MTB',
//                 'touring',
//                 'road',
//                 'mini',
//                 'mamachari',
//                 'others'
//               ].map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   // isSelectedCategory = value!;
//                 });
//               },
//               value: isSelectedCategory,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text('brand'),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextField(
//                 controller: brandController,
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.only(left: 10)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text('frame'),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextField(
//                 controller: frameController,
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.only(left: 10)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text('detail'),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextField(
//                 controller: detailController,
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.only(left: 10)),
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               alignment: Alignment.center,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (widget.currentChari == null) {
//                     await createChari();
//                   } else {
//                     await updateChari();
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text(widget.currentChari == null ? 'post' : 'update'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
