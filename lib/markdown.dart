import 'package:flutter/material.dart';

class MarkDownPage extends StatefulWidget {
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
        title: Text('Markdown'),
        backgroundColor: Color(0xff55C500),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff55C500),
        child: Icon(Icons.post_add),
        onPressed: () {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
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
                  color: Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '知識に関連するタグをスペース区切りで5つまで入力（例: Dart Flutter）',
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
                        color: Color(0xffC2C2C3),
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
                        decoration: InputDecoration(
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
                      color: Color(0xffC2C2C3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_contents),
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
