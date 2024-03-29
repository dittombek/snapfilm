import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapfilm/home/bloc/animation_bloc.dart';
import 'package:snapfilm/home/widgets/card_film.dart';
import 'package:snapfilm/models/model.dart';
import 'package:snapfilm/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnimationBloc(),
      child: const HomePageExtend(),
    );
  }
}

class HomePageExtend extends StatefulWidget {
  const HomePageExtend({super.key});

  @override
  State<HomePageExtend> createState() => _HomePageExtendState();
}

class _HomePageExtendState extends State<HomePageExtend>
    with TickerProviderStateMixin {
  // below is for declare all variables

  final double heightPageViewCard = 580;
  final List<VideoPlayerController> videoPlayerControllers = [];
  final ScrollController scrollController = ScrollController();

  PageController pageController = PageController();

  int imageBottomIndex = 0;
  int imageTopIndex = 1;
  double valueSwipeCard = 1.0;
  int lastIndexSwipeCard = 1;
  double diffValueSwipeCard = 0.0;
  double valueWidth = 411.0;
  double tempValueSwipeCard = 0.0;
  double maxWidth = 0.0;
  int durationRateAnimation = 2000;
  double durationStartRate = 0.5;
  bool firstInitHomePage = true;
  bool startAnimation = false;
  int durationCardPopupAnimation = 3000;
  double durationStartCardPopup = 0.7;
  double valueZoomMainCard = 0.0;
  bool boolShowTrailer = false;

  late AnimationController backgroundOpacityController;
  late AnimationController posterMarginController;
  late AnimationController cardSideOpacityTranslateController;
  late AnimationController posterHeightController;
  final List<AnimationController> rateStarController = [];
  late AnimationController posterSideTranslateOpacityController;
  late AnimationController cardMarginController;
  late AnimationController buttonWidthController;
  late AnimationController heightDetailController;
  late AnimationController infoDetailController;
  final List<AnimationController> cardPopupTranslateController = [];

  late Tween<double> backgroundOpacityTween;
  late Tween<double> posterMarginTween;
  late Tween<double> cardSideOpacityTranslateTween;
  late Tween<double> posterHeightTween;
  final List<Tween<Alignment>> rateStarTween = [];
  late Tween<double> posterSideTranslateOpacityTween;
  late Tween<double> cardMarginTween;
  late Tween<double> buttonWidthTween;
  late Tween<double> heightDetailTween;
  late Tween<double> infoDetailTween;
  final List<Tween<double>> cardPopupTranslateTween = [];

  late Animation<double> backgroundOpacityAnimation;
  late Animation<double> posterMarginAnimation;
  late Animation<double> cardSideOpacityTranslateAnimation;
  late Animation<double> posterHeightAnimation;
  final List<Animation<Alignment>> rateStarAnimation = [];
  late Animation<double> posterSideTranslateOpacityAnimation;
  late Animation<double> cardMarginAnimation;
  late Animation<double> buttonWidthAnimation;
  late Animation<double> heightDetailAnimation;
  late Animation<double> infoDetailAnimation;
  final List<Animation<double>> cardPopupTranslateAnimation = [];

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 1, viewportFraction: 0.8);

    // listen any change when swipe page view card
    pageController.addListener(() {
      // send value swipe card using bloc
      BlocProvider.of<AnimationBloc>(context)
          .add(ValueSwipeCardEvent(value: pageController.page!));
    });

    // listen any scroll in detail film
    scrollController.addListener(() {
      // send value zoom main card using bloc
      BlocProvider.of<AnimationBloc>(context)
          .add(ValueZoomMainCardEvent(value: scrollController.position.pixels));
    });

    // init video controller at first time
    initVideoControllers();

    // below is to input value of all animation controllers ====================

    backgroundOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    posterMarginController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    cardSideOpacityTranslateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    posterHeightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    for (var i = 0; i < 5; i++) {
      rateStarController.add(AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationRateAnimation),
      ));

      durationRateAnimation += 200;
    }

    posterSideTranslateOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    cardMarginController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    buttonWidthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    heightDetailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );

    infoDetailController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    cardPopupTranslateController.add(AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationCardPopupAnimation + 200),
    ));

    cardPopupTranslateController.add(AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationCardPopupAnimation),
    ));

    cardPopupTranslateController.add(AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationCardPopupAnimation + 200),
    ));

    // below is to input value of all animation tweens =========================

    backgroundOpacityTween = Tween(begin: 1.0, end: 0.0);

    posterMarginTween = Tween(begin: 0, end: 144);

    cardSideOpacityTranslateTween = Tween(begin: 0.7, end: 0.0);

    posterHeightTween = Tween(begin: 340, end: 0);

    for (var i = 0; i < 5; i++) {
      rateStarTween.add(
        Tween(begin: Alignment.bottomCenter, end: Alignment.topCenter),
      );
    }

    posterSideTranslateOpacityTween = Tween(begin: 1.0, end: 0.0);

    cardMarginTween = Tween(begin: 48.0, end: 0.0);

    buttonWidthTween = Tween(begin: 200, end: 350);

    heightDetailTween = Tween(begin: 20, end: 500);

    infoDetailTween = Tween(begin: 100, end: 0);

    for (var i = 0; i < 3; i++) {
      cardPopupTranslateTween.add(
        Tween(begin: 300.0, end: 0.0),
      );
    }

    // below is to input value of all animations ===============================

    backgroundOpacityTween.chain(CurveTween(curve: Curves.ease));
    backgroundOpacityAnimation =
        backgroundOpacityController.drive(backgroundOpacityTween);

    posterMarginTween.chain(CurveTween(curve: Curves.ease));
    posterMarginAnimation = posterMarginController.drive(posterMarginTween);

    cardSideOpacityTranslateAnimation =
        cardSideOpacityTranslateController.drive(cardSideOpacityTranslateTween);

    posterHeightAnimation = CurvedAnimation(
      parent: posterHeightController,
      curve: const Interval(
        0.5,
        1,
        curve: Curves.easeInOut,
      ),
    ).drive(posterHeightTween);

    for (var i = 0; i < 5; i++) {
      rateStarAnimation.add(
        CurvedAnimation(
          parent: rateStarController[i],
          curve: Interval(
            durationStartRate,
            1,
            curve: Curves.easeInOut,
          ),
        ).drive(rateStarTween[i]),
      );

      durationStartRate += 0.1;
    }

    posterSideTranslateOpacityAnimation = CurvedAnimation(
      parent: posterSideTranslateOpacityController,
      curve: const Interval(
        0.3,
        1,
        curve: Curves.easeInOut,
      ),
    ).drive(posterSideTranslateOpacityTween);

    cardMarginAnimation = CurvedAnimation(
      parent: cardMarginController,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.easeInOut,
      ),
    ).drive(cardMarginTween);

    buttonWidthAnimation = CurvedAnimation(
      parent: buttonWidthController,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.easeInOut,
      ),
    ).drive(buttonWidthTween);

    heightDetailAnimation = heightDetailController.drive(heightDetailTween);

    infoDetailAnimation = CurvedAnimation(
      parent: infoDetailController,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.easeInOut,
      ),
    ).drive(infoDetailTween);

    for (var i = 0; i < 3; i++) {
      cardPopupTranslateAnimation.add(
        CurvedAnimation(
          parent: cardPopupTranslateController[i],
          curve: Interval(
            durationStartCardPopup,
            1,
            curve: Curves.easeInOutBack,
          ),
        ).drive(cardPopupTranslateTween[i]),
      );

      durationStartCardPopup += 0.1;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();

    for (var i = 0; i < dataList.length; i++) {
      videoPlayerControllers[i].dispose();
    }

    super.dispose();
  }

  Future<void> initVideoControllers() async {
    // set each of video controller film
    for (var i = 0; i < dataList.length; i++) {
      final VideoPlayerController controller =
          VideoPlayerController.asset(dataList[i].trailer);

      controller.addListener(() {
        setState(() {});
      });

      controller.setVolume(1.0);

      controller.initialize().then((_) => setState(() {}));

      // play video of main page view card after hold 3500 miliseconds
      if (i == 1) {
        await Future.delayed(
          const Duration(milliseconds: 3500),
          () {
            controller.play();
            boolShowTrailer = true;
          },
        );
      }

      videoPlayerControllers.add(controller);
    }
  }

  // function to set animation of each pageview card
  Widget cardAnimation(int index) {
    return AnimatedBuilder(
      // merge all controllers of animation
      animation: Listenable.merge([
        pageController,
        backgroundOpacityController,
        posterMarginController,
        cardSideOpacityTranslateController,
        posterHeightController,
        for (var i = 0; i < 5; i++) ...[
          rateStarController[i],
        ],
        posterSideTranslateOpacityController,
        cardMarginController,
        heightDetailController,
        infoDetailController,
      ]),
      builder: (context, child) {
        // declare variable of values below
        double value = 0.0;
        double valueTranslate = 0.0;
        double valueOpacity = 0.0;

        // set translate and opacity  when first time run the app
        if (firstInitHomePage && index != 1) {
          valueTranslate = 40;
          valueOpacity = 0.3;
        }

        // set translate and opacity of each page view card if the dimension is showing
        if (pageController.position.haveDimensions) {
          firstInitHomePage = false;

          value = index.toDouble() - (pageController.page ?? 0);

          valueTranslate = value.abs() * 40;
          valueOpacity = (value.abs() * 0.3).clamp(0.0, 1.0);
        }

        return Transform.translate(
          offset: Offset(0, valueTranslate),
          child: CardFilm().cardFilm(
            context: context,
            scrollController: scrollController,
            videoPlayerControllers: videoPlayerControllers,
            startAnimation: startAnimation,
            boolShowTrailer: boolShowTrailer,
            isShowPage: value,
            index: index,
            valueOpacity: valueOpacity,
            posterMarginAnimation: posterMarginAnimation,
            cardSideOpacityTranslateAnimation:
                cardSideOpacityTranslateAnimation,
            posterHeightAnimation: posterHeightAnimation,
            rateStarAnimation: rateStarAnimation,
            posterSideTranslateOpacityAnimation:
                posterSideTranslateOpacityAnimation,
            cardMarginAnimation: cardMarginAnimation,
            heightDetailAnimation: heightDetailAnimation,
            infoDetailAnimation: infoDetailAnimation,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationBloc, AnimationState>(
      listener: (context, listenAnimationState) async {
        if (listenAnimationState is ValueSwipeCardState) {
          valueSwipeCard = listenAnimationState.value;

          // get the different value when swipe from one card to another card
          diffValueSwipeCard = (valueSwipeCard - lastIndexSwipeCard).abs();

          // set imageBottomIndex from valueSwipeCard
          if (valueSwipeCard < dataList.length) {
            imageBottomIndex = valueSwipeCard.toInt();
          }

          // detect if user swipe to the right
          if (valueSwipeCard > lastIndexSwipeCard) {
            imageTopIndex = lastIndexSwipeCard + 1;

            // set valueWidth to avoid glitch when swipe
            if (diffValueSwipeCard > 0.1) {
              valueWidth = (diffValueSwipeCard * maxWidth).clamp(0.0, maxWidth);
            } else {
              valueWidth = 0.0;
            }

            // set last index at the of page view card swipe
            if (diffValueSwipeCard > 0.5) {
              lastIndexSwipeCard = valueSwipeCard.toInt() + 1;
            }

            // detect if user swipe to the left
          } else if (valueSwipeCard < lastIndexSwipeCard) {
            imageTopIndex = lastIndexSwipeCard;

            // set valueWidth to avoid glitch when swipe
            if (diffValueSwipeCard > 0.1) {
              valueWidth = (maxWidth - (diffValueSwipeCard * maxWidth))
                  .clamp(0.0, maxWidth);
            } else {
              valueWidth = maxWidth;
            }

            // set last index at the of page view card swipe
            if (diffValueSwipeCard > 0.5) {
              lastIndexSwipeCard = valueSwipeCard.toInt();
            }
          }

          // play or pause video trailer
          if (valueSwipeCard.toString().split('.')[1].length == 1) {
            // turn poster and play the video after hold 1500 miliseconds
            await Future.delayed(
              const Duration(milliseconds: 1500),
              () {
                videoPlayerControllers[valueSwipeCard.toInt()].play();
                boolShowTrailer = true;
              },
            );
          } else {
            // pause video and change back to poster when user swipe
            boolShowTrailer = false;

            videoPlayerControllers[lastIndexSwipeCard].pause();
          }
        } else if (listenAnimationState is StartAnimationPageViewState) {
          // pause video trailer
          Future.delayed(
            const Duration(seconds: 3),
            () {
              videoPlayerControllers[lastIndexSwipeCard].pause();
            },
          );

          // set viewportFraction to default 1.0
          Future.delayed(
            const Duration(milliseconds: 1500),
            () {
              startAnimation = true;

              pageController = PageController(
                  initialPage: valueSwipeCard.toInt(), viewportFraction: 1.0);
            },
          );

          firstInitHomePage = true;

          // play animation controllers when user click poster film
          backgroundOpacityController.forward();
          posterMarginController.forward();
          cardSideOpacityTranslateController.forward();
          posterHeightController.forward();
          for (var i = 0; i < 5; i++) {
            rateStarController[i].forward();
          }
          posterSideTranslateOpacityController.forward();
          cardMarginController.forward();
          heightDetailController.forward();
          infoDetailController.forward();
          buttonWidthController.forward();
          for (var i = 0; i < 3; i++) {
            cardPopupTranslateController[i].forward();
          }
        } else if (listenAnimationState is EndAnimationPageViewState) {
          startAnimation = false;

          // set viewportFraction to default 0.8
          pageController = PageController(
              initialPage: valueSwipeCard.toInt(), viewportFraction: 0.8);

          // reverse animation controllers when user click top dismiss area
          backgroundOpacityController.reverse();
          posterMarginController.reverse();
          cardSideOpacityTranslateController.reverse();
          posterHeightController.reverse();
          for (var i = 0; i < 5; i++) {
            rateStarController[i].reverse();
          }
          posterSideTranslateOpacityController.reverse();
          cardMarginController.reverse();
          heightDetailController.reverse();
          infoDetailController.reverse();
          buttonWidthController.reverse();
          for (var i = 0; i < 3; i++) {
            cardPopupTranslateController[i].reverse();
          }

          // set listen again any change when swipe page view card
          pageController.addListener(() {
            // send value swipe card using bloc
            BlocProvider.of<AnimationBloc>(context)
                .add(ValueSwipeCardEvent(value: pageController.page!));
          });
        } else if (listenAnimationState is ValueZoomMainCardState) {
          // set valueZoomMainCard
          if (listenAnimationState.value.isNegative) {
            valueZoomMainCard = listenAnimationState.value;
          }
        }
      },
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.systemUiOverlayStyle,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                maxWidth = boxConstraints.maxWidth;

                // declare animation controller
                return AnimatedBuilder(
                  animation: Listenable.merge([
                    buttonWidthController,
                    for (var i = 0; i < 3; i++) ...[
                      cardPopupTranslateController[i],
                    ],
                  ]),
                  builder: (context, state) {
                    return Scaffold(
                      body: SizedBox(
                        height: boxConstraints.maxHeight,
                        child: Stack(
                          children: [
                            // background base page view card
                            Container(
                              height: boxConstraints.maxHeight,
                              width: boxConstraints.maxWidth,
                              color: const Color.fromARGB(255, 13, 14, 13),
                            ),
                            // 3 posters show up
                            if (backgroundOpacityAnimation.value == 0.0) ...[
                              SizedBox(
                                height: boxConstraints.maxHeight / 3,
                                width: boxConstraints.maxWidth,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // left poster
                                    if (valueSwipeCard.toInt() - 1 >= 0) ...[
                                      Positioned(
                                        top: 100 +
                                            cardPopupTranslateAnimation[0]
                                                .value +
                                            valueZoomMainCard.abs(),
                                        left: 0,
                                        child: Container(
                                          height: 280,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                dataList[
                                                        valueSwipeCard.toInt() -
                                                            1]
                                                    .backgroundImage,
                                              ),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    // right poster
                                    if (valueSwipeCard.toInt() + 1 <=
                                        dataList.length - 1) ...[
                                      Positioned(
                                        top: 100 +
                                            cardPopupTranslateAnimation[2]
                                                .value +
                                            valueZoomMainCard.abs(),
                                        right: 0,
                                        child: Container(
                                          height: 280,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                dataList[
                                                        valueSwipeCard.toInt() +
                                                            1]
                                                    .backgroundImage,
                                              ),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    // middle poster
                                    Positioned(
                                      top: 20 +
                                          cardPopupTranslateAnimation[1].value -
                                          valueZoomMainCard.abs(),
                                      child: Container(
                                        height: 280 - valueZoomMainCard * 2,
                                        width: 200 - valueZoomMainCard * 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              dataList[valueSwipeCard.toInt()]
                                                  .backgroundImage,
                                            ),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            // each poster full show
                            GestureDetector(
                              onTap: () {
                                // reverse animation by trigger end animation bloc
                                if (startAnimation) {
                                  BlocProvider.of<AnimationBloc>(context)
                                      .add(EndAnimationPageViewEvent());
                                }
                              },
                              child: Opacity(
                                opacity: backgroundOpacityAnimation.value,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      dataList[imageBottomIndex]
                                          .backgroundImage,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: valueWidth,
                                      child: Stack(
                                        clipBehavior: Clip.hardEdge,
                                        children: [
                                          Positioned(
                                            width: boxConstraints.maxWidth,
                                            child: Image.asset(
                                              dataList[imageTopIndex]
                                                  .backgroundImage,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // background half height screen bottom white
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: boxConstraints.maxHeight / 2.5,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            for (int i = 0; i < 10; i++) ...[
                                              Colors.grey[100]!
                                                  .withOpacity(1.0 - (i * 0.1)),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // page view card film
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: heightPageViewCard,
                                    child: PageView.builder(
                                      controller: pageController,
                                      physics: startAnimation
                                          ? const NeverScrollableScrollPhysics()
                                          : const AlwaysScrollableScrollPhysics(),
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        return cardAnimation(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // button "BUY TICKET"
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        width: buttonWidthAnimation.value,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 68, 81, 69),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Text('BUY TICKET'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
