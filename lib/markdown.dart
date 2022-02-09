import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDownPage extends StatefulWidget {
  const MarkDownPage({Key? key}) : super(key: key);

  @override
  State<MarkDownPage> createState() => _MarkDownPageState();
}

class _MarkDownPageState extends State<MarkDownPage> {
  final _subjectController = TextEditingController();
  final _contesController = TextEditingController();
  final _mailController = TextEditingController();
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
      title: const Text('Markdownメール'),
      backgroundColor: const Color(0xff55C500),
    );
  }

  Widget _buildBody(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              right: 8.0,
              left: 8.0,
            ),
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
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    hintText: '件名',
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
                        hintText: '内容',
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
                    child: Markdown(
                      data: _contents,
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

  Column _buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          backgroundColor: const Color(0xff55C500),
          child: const Icon(Icons.post_add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("メールを送信"),
                  content: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
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
                          controller: _mailController,
                          decoration: const InputDecoration(
                            hintText: 'sample@sample.com',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    // ボタン領域
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff55C500),
                      ),
                      child: const Text("閉じる"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff55C500),
                      ),
                      child: const Text("送信"),
                      onPressed: () async {
                        final email = Email(
                          recipients: [(_mailController.text)],
                          body: _contesController.text,
                          subject: _subjectController.text,
                          isHTML: true,
                        );
                        await FlutterEmailSender.send(email);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
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
        ),
      ],
    );
  }
}
