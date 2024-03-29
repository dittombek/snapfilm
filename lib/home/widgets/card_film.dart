import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapfilm/home/bloc/animation_bloc.dart';
import 'package:snapfilm/home/widgets/detail_film.dart';
import 'package:snapfilm/models/model.dart';
import 'package:snapfilm/theme.dart';
import 'package:video_player/video_player.dart';

class CardFilm {
  double totalOverscroll = 0.0;

  Widget cardFilm({
    required BuildContext context,
    required ScrollController scrollController,
    required List<VideoPlayerController> videoPlayerControllers,
    required bool startAnimation,
    required bool boolShowTrailer,
    required int index,
    required double valueOpacity,
    required double isShowPage,
    required Animation<double> posterMarginAnimation,
    required Animation<double> cardSideOpacityTranslateAnimation,
    required Animation<double> posterHeightAnimation,
    required List<Animation<Alignment>> rateStarAnimation,
    required Animation<double> posterSideTranslateOpacityAnimation,
    required Animation<double> cardMarginAnimation,
    required Animation<double> heightDetailAnimation,
    required Animation<double> infoDetailAnimation,
  }) {
    return Container(
      margin: startAnimation
          ? EdgeInsets.symmetric(horizontal: cardMarginAnimation.value)
          : const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          // translate and opacity only the poster film
          Transform.translate(
            offset: Offset(
                isShowPage.toInt() *
                    -(50 -
                        (posterSideTranslateOpacityAnimation.value * 100) / 2),
                0),
            child: Container(
              height: 330, // because there is 10 bottom padding
              width: 240,
              margin: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                dataList[index].posterImage,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                opacity: posterSideTranslateOpacityAnimation,
              ),
            ),
          ),
          // translate and opacity the card film
          Transform.translate(
            offset: isShowPage.toInt() == 0
                ? const Offset(0, 0)
                : Offset(
                    0,
                    -(35 -
                        (cardSideOpacityTranslateAnimation.value * 100) / 2)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 96),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * 2),
                color: isShowPage.toInt() != 0
                    ? Colors.grey[50]!
                        .withOpacity(cardSideOpacityTranslateAnimation.value)
                    : Colors.grey[50]!.withOpacity(1 - valueOpacity),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // show poster or video trailer of film
                    Container(
                      height:
                          isShowPage == 0 ? posterHeightAnimation.value : 340,
                      width: isShowPage == 0
                          ? (posterHeightAnimation.value - 100)
                              .clamp(0, posterHeightAnimation.value)
                          : 240,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: posterMarginAnimation.value != 144
                          ? GestureDetector(
                              onTap: () {
                                videoPlayerControllers[index].pause();

                                BlocProvider.of<AnimationBloc>(context)
                                    .add(StartAnimationPageViewEvent());
                              },
                              child: Container(
                                margin: isShowPage == 0
                                    ? EdgeInsets.symmetric(
                                        horizontal: posterMarginAnimation.value,
                                        vertical:
                                            posterMarginAnimation.value * 1.5,
                                      )
                                    : EdgeInsets.zero,
                                padding: boolShowTrailer
                                    ? const EdgeInsets.symmetric(vertical: 81)
                                    : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromARGB(255, 16, 17, 16)),
                                clipBehavior: Clip.hardEdge,
                                child: boolShowTrailer
                                    ? FittedBox(
                                        fit: BoxFit.cover,
                                        child: SizedBox(
                                          height: videoPlayerControllers[index]
                                              .value
                                              .size
                                              .height,
                                          width: videoPlayerControllers[index]
                                              .value
                                              .size
                                              .width,
                                          child: VideoPlayer(
                                            videoPlayerControllers[index],
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        dataList[index].posterImage,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter,
                                      ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    // title of film
                    Text(
                      dataList[index].title,
                      style: AppTheme.textTitleBold,
                    ),
                    const SizedBox(height: 10),
                    // genre of film
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (String genre in dataList[index].genres) ...[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.lightBlue,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              genre,
                              style: AppTheme.textCaption,
                            ),
                          )
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: heightDetailAnimation.value,
                      child: Stack(
                        children: [
                          // rate of film
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: rateStarAnimation[0].value,
                                height: double.infinity,
                                child: Text(
                                  dataList[index].rate.toString(),
                                  style: AppTheme.textBodyBold
                                      .copyWith(color: Colors.green),
                                ),
                              ),
                              const SizedBox(width: 8),
                              for (int i = 0; i < 5; i++) ...[
                                if (i + 1 <=
                                    (dataList[index].rate * 5) ~/ 10) ...[
                                  Container(
                                    alignment: rateStarAnimation[i].value,
                                    height: double.infinity,
                                    child: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                ] else ...[
                                  Container(
                                    alignment: rateStarAnimation[i].value,
                                    height: double.infinity,
                                    child: const Icon(
                                      Icons.star_border_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]
                              ],
                            ],
                          ),
                          // detail information of film
                          Transform.translate(
                            offset: Offset(0, infoDetailAnimation.value),
                            child: Opacity(
                              opacity:
                                  1 - (infoDetailAnimation.value / 10 * 0.1),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: Column(
                                  children: [
                                    Text(
                                      'Director / ${dataList[index].director}',
                                      style: AppTheme.textCaption,
                                    ),
                                    const SizedBox(height: 35),
                                    DetailFilm().detailFilm(index: index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
