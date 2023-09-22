import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:upload_file_practicle/core/utils/color_constants.dart';

class QuiltTextField extends StatefulWidget {
  final QuillEditorController controller;

  const QuiltTextField({super.key, required this.controller});

  @override
  State<QuiltTextField> createState() => _QuiltTextFieldState();
}

class _QuiltTextFieldState extends State<QuiltTextField> {
  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
    ToolBarStyle.blockQuote,
    ToolBarStyle.codeBlock,
    ToolBarStyle.link,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo,
    ToolBarStyle.listOrdered,
    ToolBarStyle.listBullet,
    ToolBarStyle.align,
    ToolBarStyle.size
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.greenAccent.shade400,
              controller: widget.controller,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              toolBarConfig: customToolBarList,
            ),
            QuillHtmlEditor(
              text: "",
              hintText: 'Hint text goes here',
              controller: widget.controller,
              isEnabled: true,
              minHeight: 300,
              textStyle: Theme.of(context).textTheme.bodySmall,
              hintTextStyle: Theme.of(context).textTheme.bodySmall,
              hintTextAlign: TextAlign.start,
              padding: const EdgeInsets.only(left: 10, top: 5),
              hintTextPadding: EdgeInsets.zero,
              backgroundColor: ColorConstants.white,
              autoFocus: false,
              inputAction: InputAction.send,
              onFocusChanged: (hasFocus) {
                if (hasFocus) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              onTextChanged: (text) => debugPrint('widget text change $text'),
              onEditorCreated: () => debugPrint('Editor has been loaded'),
              onEditingComplete: (s) => debugPrint('Editing completed $s'),
              onEditorResized: (height) => debugPrint('Editor resized $height'),
              onSelectionChanged: (sel) =>
                  debugPrint('${sel.index},${sel.length}'),
              loadingBuilder: (context) {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 0.4,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  /// method to un focus editor
  void unFocusEditor() => widget.controller.unFocus();
}
