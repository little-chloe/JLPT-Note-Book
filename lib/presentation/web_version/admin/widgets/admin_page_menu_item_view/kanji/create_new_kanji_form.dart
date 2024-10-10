import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_kanji/create_kanji_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji/kanji_manager_button.dart';

class CreateNewKanjiForm extends StatefulWidget {
  final String levelId;

  const CreateNewKanjiForm({super.key, required this.levelId});

  @override
  State<CreateNewKanjiForm> createState() => _CreateNewKanjiFormState();
}

class _CreateNewKanjiFormState extends State<CreateNewKanjiForm> {
  late TextEditingController _kanjiController;
  late TextEditingController _kunController;
  late TextEditingController _onController;
  late TextEditingController _hanVietController;
  late List<TextEditingController> _sampleKunyomiController;
  late List<TextEditingController> _sampleOnyomiController;
  late List<TextEditingController> _transformKunyomiController;
  late List<TextEditingController> _transformOnyomiController;
  late List<TextEditingController> _meaningKunyomiController;
  late List<TextEditingController> _meaningOnyomiController;

  @override
  void initState() {
    _kanjiController = TextEditingController();
    _kunController = TextEditingController();
    _onController = TextEditingController();
    _hanVietController = TextEditingController();
    _sampleKunyomiController = [];
    _sampleOnyomiController = [];
    _transformKunyomiController = [];
    _transformOnyomiController = [];
    _meaningKunyomiController = [];
    _meaningOnyomiController = [];
    super.initState();
  }

  @override
  void dispose() {
    _kanjiController.dispose();
    _kunController.dispose();
    _onController.dispose();
    _hanVietController.dispose();
    for (var element in _sampleKunyomiController) {
      element.dispose();
    }
    for (var element in _sampleOnyomiController) {
      element.dispose();
    }
    for (var element in _transformKunyomiController) {
      element.dispose();
    }
    for (var element in _transformOnyomiController) {
      element.dispose();
    }
    for (var element in _meaningKunyomiController) {
      element.dispose();
    }
    for (var element in _meaningOnyomiController) {
      element.dispose();
    }
    super.dispose();
  }

  Widget _dataField({
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: _yomiField(
                hintText: hintText,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yomiField(
      {required String hintText, required TextEditingController controller}) {
    return TextField(
      cursorColor: AppColors.black,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kDFD3C3,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.black.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        hintText: hintText,
      ),
    );
  }

  Widget _dialogHandleActionFormButton(
      {required void Function() onPressed, required String text}) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 18,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.kF8EDE3),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.04)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  void _handleConfirmCreateKanji() {
    context.read<CreateKanjiCubit>().createKanji(
          levelId: widget.levelId,
          kanji: _kanjiController.text,
          viet: _hanVietController.text,
          kun: _kunController.text,
          on: _onController.text,
          sampleKunyomi: _sampleKunyomiController
              .map((e) => e.text)
              .toList(growable: false),
          transformKunyomi: _transformKunyomiController
              .map((e) => e.text)
              .toList(growable: false),
          meaningKunyomi: _meaningKunyomiController
              .map((e) => e.text)
              .toList(growable: false),
          sampleOnyomi: _sampleOnyomiController
              .map((e) => e.text)
              .toList(growable: false),
          transformOnyomi: _transformOnyomiController
              .map((e) => e.text)
              .toList(growable: false),
          meaningOnyomi: _meaningOnyomiController
              .map((e) => e.text)
              .toList(growable: false),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
      child: BlocBuilder<CreateKanjiCubit, CreateKanjiState>(
        builder: (context, state) {
          if (state is CreateKanjiLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _dataField(
                        title: 'Chữ Kanji',
                        controller: _kanjiController,
                        hintText: "Nhập chữ Kanji",
                      ),
                      _dataField(
                        title: 'Âm Hán Việt',
                        controller: _hanVietController,
                        hintText: "Nhập âm Hán Việt",
                      ),
                      _dataField(
                        title: 'Âm Kun',
                        controller: _kunController,
                        hintText: "Nhập âm Kun",
                      ),
                      _dataField(
                        title: 'Âm On',
                        controller: _onController,
                        hintText: "Nhập âm On",
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: BlocBuilder<CreateKanjiCubit,
                                    CreateKanjiState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        if (state is CreateKanjiLoaded)
                                          ...state.kunyomis
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: AppColors.black
                                                        .withOpacity(0.4),
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập Kunyomi Kanji",
                                                    controller:
                                                        _sampleKunyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập Kunyomi Hiragana",
                                                    controller:
                                                        _transformKunyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập nghĩa Kunyomi",
                                                    controller:
                                                        _meaningKunyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              _dialogHandleActionFormButton(
                                                            onPressed: () {
                                                              final sampleRemoved =
                                                                  _sampleKunyomiController
                                                                      .removeAt(
                                                                          index);
                                                              final transformRemoved =
                                                                  _transformKunyomiController
                                                                      .removeAt(
                                                                          index);
                                                              final meaningRemoved =
                                                                  _meaningKunyomiController
                                                                      .removeAt(
                                                                          index);
                                                              context
                                                                  .read<
                                                                      CreateKanjiCubit>()
                                                                  .removeKunyomi(
                                                                      index:
                                                                          index);
                                                              sampleRemoved
                                                                  .dispose();
                                                              transformRemoved
                                                                  .dispose();
                                                              meaningRemoved
                                                                  .dispose();
                                                            },
                                                            text: 'Huỷ Kunyomi',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            );
                                          }),
                                        const SizedBox(height: 8),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child:
                                                    _dialogHandleActionFormButton(
                                                  onPressed: () {
                                                    _sampleKunyomiController.add(
                                                        TextEditingController());
                                                    _transformKunyomiController.add(
                                                        TextEditingController());
                                                    _meaningKunyomiController.add(
                                                        TextEditingController());
                                                    context
                                                        .read<
                                                            CreateKanjiCubit>()
                                                        .addKunyomi();
                                                  },
                                                  text: 'Thêm ví dụ Kunyomi',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: BlocBuilder<CreateKanjiCubit,
                                    CreateKanjiState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        if (state is CreateKanjiLoaded)
                                          ...state.onyomis
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: AppColors.black
                                                        .withOpacity(0.4),
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập Onyomi Kanji",
                                                    controller:
                                                        _sampleOnyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập Onyomi Hiragana",
                                                    controller:
                                                        _transformOnyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  _yomiField(
                                                    hintText:
                                                        "Nhập nghĩa Onyomi",
                                                    controller:
                                                        _meaningOnyomiController[
                                                            index],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              _dialogHandleActionFormButton(
                                                            onPressed: () {
                                                              final sampleRemoved =
                                                                  _sampleOnyomiController
                                                                      .removeAt(
                                                                          index);
                                                              final transformRemoved =
                                                                  _transformOnyomiController
                                                                      .removeAt(
                                                                          index);
                                                              final meaningRemoved =
                                                                  _meaningOnyomiController
                                                                      .removeAt(
                                                                          index);
                                                              context
                                                                  .read<
                                                                      CreateKanjiCubit>()
                                                                  .removeOnyomi(
                                                                      index:
                                                                          index);
                                                              sampleRemoved
                                                                  .dispose();
                                                              transformRemoved
                                                                  .dispose();
                                                              meaningRemoved
                                                                  .dispose();
                                                            },
                                                            text: 'Huỷ Onyomi',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            );
                                          }),
                                        const SizedBox(height: 8),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child:
                                                    _dialogHandleActionFormButton(
                                                  onPressed: () {
                                                    _sampleOnyomiController.add(
                                                        TextEditingController());
                                                    _transformOnyomiController.add(
                                                        TextEditingController());
                                                    _meaningOnyomiController.add(
                                                        TextEditingController());
                                                    context
                                                        .read<
                                                            CreateKanjiCubit>()
                                                        .addOnyomi();
                                                  },
                                                  text: 'Thêm ví dụ Onyomi',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: KanjiManagerButton(
                          text: 'Xác nhận',
                          onPressed: _handleConfirmCreateKanji,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: KanjiManagerButton(
                          text: 'Huỷ bỏ',
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
