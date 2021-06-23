import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

void main() => runApp(HtmlEditorExampleApp());

class HtmlEditorExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HtmlEditorExample(
                        title: 'Flutter HTML Editor Example',
                      )),
            );
          },
        ),
      ),
    );
  }
}

class HtmlEditorExample extends StatefulWidget {
  HtmlEditorExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<HtmlEditorExample> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toggleCodeView();
          },
          child: Text(r'<\>',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                    adjustHeightForKeyboard: false,
                    hint: 'enther text ..',
                    initialText: '',
                    shouldEnsureVisible: true,
                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.aboveEditor,
                    //by default
                    toolbarType: ToolbarType.nativeScrollable,
                    initiallyExpanded: true,
                    defaultToolbarButtons: [
                      const FontButtons(
                        strikethrough: false,
                        superscript: false,
                        subscript: false,
                      ),
                      const ListButtons(
                        listStyles: false,
                      ),
                      const ParagraphButtons(
                        alignLeft: false,
                        alignCenter: false,
                        alignRight: false,
                        alignJustify: false,
                        textDirection: false,
                        lineHeight: false,
                        caseConverter: false,
                      ),
                      const OtherButtons(
                        fullscreen: false,
                        codeview: false,
                        help: false,
                        copy: false,
                        paste: false,
                      ),
                    ],
                  ),
                  otherOptions: OtherOptions(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0))),
                  callbacks: Callbacks(
                    onBeforeCommand: (String? currentHtml) {},
                    onChangeContent: (String? changed) {},
                    onChangeCodeview: (String? changed) {
                      print('code changed to $changed');
                    },
                    onChangeSelection: (EditorSettings settings) {
                      print('parent element is ${settings.parentElement}');
                      print('font name is ${settings.fontName}');
                    },
                    onDialogShown: () {
                      print('dialog shown');
                    },
                    onEnter: () {
                      print('enter/return pressed');
                    },
                    onFocus: () {
                      print('editor focused');
                    },
                    onBlur: () {
                      print('editor unfocused');
                    },
                    onBlurCodeview: () {
                      print('codeview either focused or unfocused');
                    },
                    onInit: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
