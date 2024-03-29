import 'package:flutter/material.dart';
import 'package:snapfilm/models/model.dart';
import 'package:snapfilm/theme.dart';

class DetailFilm {
  Widget detailFilm({
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actors',
          style: AppTheme.textBodyBold,
        ),
        const SizedBox(height: 10),
        // photo and name of actors
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < dataList[index].actors.length; i++) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                              dataList[index].actors[i]['photoActor']!,
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dataList[index].actors[i]['nameActor']!,
                        style: AppTheme.textCaption,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Introduction',
          style: AppTheme.textBodyBold,
        ),
        // descriptions of film
        Text(
          dataList[index].introduction,
          style: AppTheme.textBody,
        ),
      ],
    );
  }
}
