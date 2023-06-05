import 'package:booksharing_service_app/client/discussion_group_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/test_datas.dart';
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
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          // search
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a group',
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
              onChanged: (value) {
                // Code to filter books based on search query
              },
            ),
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: test_genres
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
                                    Colors.black.withOpacity(0.5),
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
