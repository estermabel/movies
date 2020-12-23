import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

class CashedImage extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final double border;

  const CashedImage({
    Key key,
    this.url,
    this.height,
    this.width,
    this.border,
  }) : super(key: key);
  @override
  _CashedImageState createState() => _CashedImageState();
}

class _CashedImageState extends State<CashedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: CachedNetworkImage(
        imageUrl: widget.url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: SALMON,
            borderRadius: BorderRadius.circular(widget.border),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
  /*
  BoxDecoration(
                    color: SALMON,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                      ),
                    ),
                  ),*/
}
