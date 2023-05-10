import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/models/create_chari_model.dart';
import 'package:yourchari_app/models/main_model.dart';

class CreateChariPage extends ConsumerWidget {
  const CreateChariPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MainModel mainModel = MainModel();
    final CreateChariModel createChariModel = ref.watch(createChariProvider);
    //formcontroller
    // final isSelectedCategory = createChariModel.category;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New chari'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await createChariModel.selectImages();
              },
              child: const Text('images')),
          createChariModel.croppedFile != null
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: createChariModel.images.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Image.file(createChariModel.images[index]),
                        
                      );
                    },
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                  ),
                )
              // ? SizedBox(
              //     height: 100,
              //     child: Image.file(createChariModel.croppedFile!),
              // )
              : const SizedBox(
                  height: 100,
                ),
          const Text('category'),
          DropdownButton(
              items: [
                'single',
                'MTB',
                'touring',
                'road',
                'mini',
                'mamachari',
                'others'
              ].map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                final category = value.toString();
                createChariModel.onCategoryChanged(value: category);
              },
              value: createChariModel.category),
          const SizedBox(
            height: 10,
          ),
          const Text('others'),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: createChariModel.brandEditingController,
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
              controller: createChariModel.frameEditingController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('caption'),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: createChariModel.captionEditingController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
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
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                createChariModel.createChari(
                    currentUserDoc: mainModel.currentUserDoc);
              },
              child: const Text('post'),
            ),
          )
        ],
      )),
    );
  }
}
