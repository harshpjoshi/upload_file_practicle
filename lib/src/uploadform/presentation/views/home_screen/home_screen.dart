import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:upload_file_practicle/core/utils/app_contants.dart';
import 'package:upload_file_practicle/core/utils/color_constants.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/bloc/upload_form_bloc.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/views/home_screen/widgets/headline_title.dart';
import 'package:upload_file_practicle/src/uploadform/presentation/views/home_screen/widgets/quilt_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late QuillEditorController controller;
  String desc = "";
  ValueNotifier<bool> isDownloadable = ValueNotifier(false);

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) async {
      desc = await controller.getPlainText();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadFormBloc, UploadFormState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorConstants.violet,
            title: Text(
              AppConstants.uploadForm,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorConstants.white,
                  ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const HeadlineTitle(title: AppConstants.content),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppConstants.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              QuiltTextField(controller: controller),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: AppConstants.contentUpload,
                    ),
                    TextSpan(
                        text: "*",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.red)),
                  ],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  if (state.file == null) {
                    context.read<UploadFormBloc>().add(GetFile());
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: ColorConstants.violet,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.lightBlue,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf,
                            color: ColorConstants.violet,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            state.file?.path != null
                                ? basename(state.file?.path ?? "")
                                : AppConstants.dropYourDocument,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorConstants.violet,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ValueListenableBuilder(
                valueListenable: isDownloadable,
                builder: (context, bool isDownLoadable, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.allowUserToDownloadContent,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: isDownLoadable,
                          onChanged: (value) {
                            isDownloadable.value = !isDownloadable.value;
                          },
                          activeColor: ColorConstants.violet,
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  File? file = state.file;
                  if (file != null) {
                    context.read<UploadFormBloc>().add(
                          UploadFormData(
                            file: file,
                            description: desc,
                            isDownloadable: isDownloadable.value,
                          ),
                        );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      state.file == null
                          ? ColorConstants.gray
                          : ColorConstants.violet),
                ),
                child: Text(
                  AppConstants.submit,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
