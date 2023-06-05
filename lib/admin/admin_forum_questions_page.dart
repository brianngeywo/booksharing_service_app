import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/question.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';

class ForumQuestionsPage extends StatefulWidget {
  List<Question> list;

  ForumQuestionsPage({super.key, required this.list});

  @override
  State<ForumQuestionsPage> createState() => _ForumQuestionsPageState();
}

class _ForumQuestionsPageState extends State<ForumQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Questions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 10,
            // margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'Id',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Posted By',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Question',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Time Uploaded',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
              rows: widget.list
                  .map((question) => DataRow(cells: [
                        DataCell(Text(question.id)),
                        DataCell(Text(question.postedBy.name)),
                        DataCell(Text(question.title)),
                        DataCell(Text(formatter.format(question.timeUploaded))),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
