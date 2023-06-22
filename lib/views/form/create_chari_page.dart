import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/viewModels/create_chari_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../../constants/list.dart';

class CreateChariPage extends ConsumerWidget {
  const CreateChariPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MainController mainController = MainController();
    final CreateChariController createChariController =
        ref.watch(createChariProvider);
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
                await createChariController.selectImages();
              },
              child: const Text('images')),
          createChariController.croppedFile != null
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: createChariController.images.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Image.file(createChariController.images[index]),
                      );
                    },
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                  ),
                )
              : const SizedBox(
                  height: 100,
                ),
          const Text('category'),
          DropdownButton(
              items: categoryItem.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                final category = value.toString();
                createChariController.onCategoryChanged(value: category);
              },
              value: createChariController.category),
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
              controller: createChariController.brandEditingController,
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
              controller: createChariController.frameEditingController,
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
              controller: createChariController.captionEditingController,
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
                createChariController.createChari(
                    currentUserDoc: mainController.currentUserDoc);
              },
              child: const Text('post'),
            ),
          )
        ],
      )),
    );
  }
}
