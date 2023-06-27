import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourchari_app/constants/dialog.dart';
import 'package:yourchari_app/viewModels/create_chari_model.dart';
import 'package:yourchari_app/viewModels/main_controller.dart';

import '../../constants/list.dart';

class CreateChariPage extends ConsumerWidget {
  const CreateChariPage({Key? key}) : super(key: key);

  Widget divider() {
    return const Divider(
      thickness: 2,
      height: 40,
    );
  }

  Widget bottomSheet({required context}) {
    return Consumer(builder: (context, ref, _) {
      final CreateChariController createChariController =
          ref.watch(createChariProvider);
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          margin: const EdgeInsets.only(top: 64),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                for (final partsCategory in partsCategories)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ExpansionTile(
                        title: Text(partsCategory.keys.toList().first),
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.black12,
                        children: [
                          Wrap(
                            children: [
                              for (final part in partsCategory.values.first)
                                InkWell(
                                  onTap: () {
                                    createChariController.addPartsForm(
                                        part: part);
                                  },
                                  child: Card(
                                    color: !createChariController.partsFormList
                                            .contains(part)
                                        ? Colors.grey
                                        : Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(part,
                                          style: !createChariController
                                                  .partsFormList
                                                  .contains(part)
                                              ? const TextStyle(fontSize: 15)
                                              : const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainController mainController = ref.watch(mainProvider);
    final CreateChariController createChariController =
        ref.watch(createChariProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () => cancelDialog(context),
            child: const Center(child: Icon(Icons.cancel_outlined)),
          ),
          title: const Text('自転車の情報を入力'),
          actions: [
            InkWell(
              onTap: () => (context),
              child: const Center(
                  child: Text(
                '次へ ',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
          ],
        ),
        // bottomSheet: SizedBox(
        //   width: double.infinity,
        //   height: 40,
        //   child: Row(
        //     children: [
        //       Text("Above Keyboard"),
        //       ElevatedButton(
        //           onPressed: () {
        //             _focusNode.unfocus();
        //           },
        //           child: Text('完了'))
        //     ],
        //   ),
        // ),
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    //----------------------写真選択--------------------------------------
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                              height: 99,
                              child: ReorderableListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: createChariController.images.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    key: Key('$index'),
                                    child: SizedBox(
                                      child: InkWell(
                                        onTap: () => {
                                          createChariPreviewImage(context,
                                              image: createChariController
                                                  .images[index],
                                              createChariController:
                                                  createChariController)
                                        },
                                        child: Stack(
                                          children: [
                                            Image.file(createChariController
                                                .images[index]),
                                            Container(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "${index + 1} / 6",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onReorder: (int oldIndex, int newIndex) {
                                  createChariController.onImagesListChange(
                                      newIndex: newIndex, oldIndex: oldIndex);
                                },
                              )),
                          if (createChariController.images.length < 6)
                            InkWell(
                              onTap: () async {
                                await createChariController.selectImages();
                              },
                              child: const SizedBox(
                                height: 99,
                                width: 132,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                  child: Icon(Icons.add_a_photo),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    divider(),
                    //----------------------------category------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "カテゴリー",
                          style: TextStyle(
                              color: (Colors.black),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            categoryPickerDialog(context,
                                createChariController: createChariController);
                          },
                          child: createChariController.category == ""
                              ? const Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text('必須'),
                                    Icon(Icons.chevron_right_outlined)
                                  ],
                                )
                              : Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(createChariController.category),
                                    const Icon(Icons.chevron_right_outlined)
                                  ],
                                ),
                        )
                      ],
                    ),
                    divider(),
                    //------------------------自転車の詳細-----------------=---------------------
                    const Text(
                      "自転車の詳細",
                      style: TextStyle(
                          color: (Colors.black),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("ブランド"),
                    TextFormField(
                      maxLength: 15,
                      controller:
                          createChariController.frameBrandEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "必須。15字まで"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("フレーム"),
                    TextFormField(
                      maxLength: 15,
                      controller:
                          createChariController.frameNameEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "必須。15字まで"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("自転車の説明"),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: const Text("任意"))
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLength: 100,
                      controller:
                          createChariController.captionEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.red,
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "こだわりポイントなど。100字まで。"),
                    ),

                    divider(),

                    //----------------------------    parts    -------------------------------------
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return bottomSheet(context: context);
                        },
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "構成パーツを追加",
                            style: TextStyle(
                                color: (Colors.black),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: createChariController
                              .partsTextEditingControllerList.length,
                          itemBuilder: (context, index) {
                            final partsFormTextEditingController =
                                createChariController
                                    .partsTextEditingControllerList[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      partsFormTextEditingController.part,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(children: [
                                            TextFormField(
                                              maxLength: 15,
                                              controller:
                                                  partsFormTextEditingController
                                                      .brandEditingController,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                  hintText: "brand"),
                                            ),
                                            TextFormField(
                                              maxLength: 15,
                                              controller:
                                                  partsFormTextEditingController
                                                      .nameEditingController,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                  hintText: "name"),
                                            )
                                          ]),
                                        ),
                                        Dismissible(
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (direction) {
                                            createChariController.removePartsForm(
                                                partsFormTextEditingController:
                                                    partsFormTextEditingController);
                                          },
                                          background: const Icon(
                                            Icons.delete_outlined,
                                            color: Colors.red,
                                          ),
                                          key: UniqueKey(),
                                          child: const Icon(
                                            Icons.arrow_left,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    divider(),
                    Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              createChariController.createChari(
                                  currentUserDoc:
                                      mainController.currentUserDoc);
                            },
                            child: const Text("投稿"))),
                    divider()
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
