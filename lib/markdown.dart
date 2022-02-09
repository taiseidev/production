import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDownPage extends StatefulWidget {
  const MarkDownPage({Key? key}) : super(key: key);

  @override
  State<MarkDownPage> createState() => _MarkDownPageState();
}

class _MarkDownPageState extends State<MarkDownPage> {
  final _contesController = TextEditingController();
  String _contents = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(size),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Markdown'),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.post_add),
        ),
      ],
      backgroundColor: const Color(0xff55C500),
    );
  }

  Widget _buildBody(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width * 0.8,
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffC2C2C3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'タグを追加（例: Dart Flutter）',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffC2C2C3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _contesController,
                      onChanged: (value) {
                        setState(
                          () {
                            _contents = value;
                          },
                        );
                      },
                      maxLines: 100,
                      minLines: 30,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffC2C2C3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(
                      data: _contents,
                      styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(color: Colors.amber),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xff55C500),
      child: const Icon(Icons.delete),
      onPressed: () {
        _contesController.clear();
        setState(
          () {
            _contents = '';
          },
        );
      },
    );
  }
}
