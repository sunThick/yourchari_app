import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEditChariPage extends StatefulWidget {
  const AddEditChariPage({super.key});

  @override
  State<AddEditChariPage> createState() => _AddEditChariPageState();
}

class _AddEditChariPageState extends State<AddEditChariPage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController createDateController = TextEditingController();

  String? isSelectedCategory = 'single';

  Future<void> createChari() async {
    final chariCollection = FirebaseFirestore.instance.collection('chari');
    await chariCollection.add({
      'category': isSelectedCategory,
      'brand': brandController.text,
      'frame': frameController.text,
      'detail': detailController.text,
      'createdDate': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('new chari')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('category'),
            const SizedBox(
              height: 1,
            ),
            Container(
              child: DropdownButton(
                items: <String>[
                  'single',
                  'MTB',
                  'touring',
                  'road',
                  'mini',
                  'mamachari',
                  'others'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    isSelectedCategory = value;
                  });
                },
                value: isSelectedCategory,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('brand'),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: brandController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('frame'),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: frameController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('detail'),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: detailController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await createChari();
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                },
                child: Text('post'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
