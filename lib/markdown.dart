import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDownPage extends StatefulWidget {
  const MarkDownPage({Key? key}) : super(key: key);

  @override
  State<MarkDownPage> createState() => _MarkDownPageState();
}

class _MarkDownPageState extends State<MarkDownPage> {
  TextEditingController? _contentController;
  String _contents = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown'),
        backgroundColor: const Color(0xff55C500),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff55C500),
        child: const Icon(Icons.post_add),
        onPressed: () {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'タイトル',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'タグを追加（例: Dart Flutter）',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffC2C2C3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _contentController,
                        onChanged: (value) {
                          setState(() {
                            _contents = value;
                          });
                        },
                        maxLines: 100,
                        minLines: 31,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 710,
                  height: 625,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffC2C2C3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(data: _contents),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
