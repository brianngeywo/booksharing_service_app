import 'package:booksharing_service_app/client/discussion_group_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:flutter/material.dart';

class DiscussionGroupDashboard extends StatefulWidget {
  const DiscussionGroupDashboard({super.key});

  @override
  _DiscussionGroupDashboardState createState() =>
      _DiscussionGroupDashboardState();
}

class _DiscussionGroupDashboardState extends State<DiscussionGroupDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discussion groups',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: genres
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscussionGroupPage(
                                    genre: e,
                                  ))),
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(e.image_url),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.7),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
