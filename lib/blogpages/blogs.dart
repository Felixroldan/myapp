import 'package:flutter/material.dart';
import 'package:myapp/models/Blog.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog Example'),
          actions: [
            IconButton(onPressed: (){
              final blog = Blog(name: "TestBLog");
            }, icon: const Icon(Icons.add))
          ],
        ),
        body: const Center(
          child: Text('Hello World'),
        ),

    );
  }
}