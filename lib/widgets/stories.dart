import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/palette.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/widgets/profile_avatar.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({Key key, @required this.currentUser, @required this.stories})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          scrollDirection: Axis.horizontal,
          itemCount: stories.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: _StoryCard(isAddStory: true, currentUser: currentUser),
              );
            }
            final Story story = stories[index - 1];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: _StoryCard(isAddStory: false, story: story),
            );
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final Story story;
  final User currentUser;

  const _StoryCard(
      {Key key, this.isAddStory = false, this.story, this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
              imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl,
              height: double.infinity,
              width: 110,
              fit: BoxFit.cover),
        ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12.0)),
        ),
        Positioned(
          child: isAddStory
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add),
                    iconSize: 30,
                    color: Palette.facebookBlue,
                    onPressed: () => print('on add story'),
                  ))
              : ProfileAvatar(
                  imageUrl: story.user.imageUrl,
                  hasBorder: !story.isViewed,
                ),
          top: 8,
          left: 8,
          right: 8,
        ),
        Positioned(
          child: Text(
            isAddStory ? 'Add to story' : story.user.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: 8,
          left: 8,
        )
      ],
    );
  }
}
