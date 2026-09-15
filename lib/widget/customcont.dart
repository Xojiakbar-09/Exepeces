import 'dart:io';
import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/main.dart'; // main.dart dagi global audioHandler ni olish uchun
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/screens/fullscreen.dart';
import 'package:expensiv/utils/category.dart';
import 'package:expensiv/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:audio_service/audio_service.dart';

class Customcont extends StatefulWidget {
  const Customcont({super.key, required this.expenseModel});

  final ExpenseModel expenseModel;

  @override
  State<Customcont> createState() => _CustomcontState();
}

class _CustomcontState extends State<Customcont> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAudio =
        widget.expenseModel.image != null &&
        path
            .basename(widget.expenseModel.image!)
            .toLowerCase()
            .endsWith('.mp3');

    return Material(
      color: Colors.white,
      child: isAudio
          ? StreamBuilder<PlaybackState>(
              // Pleyer holatini kuzatib borish uchun stream
              stream: audioHandler.playbackState,
              builder: (context, snapshot) {
                final playbackState = snapshot.data;
                final isPlaying = playbackState?.playing ?? false;

                // Hozirgi o'ynalayotgan media elementni tekshiramiz
                final currentMediaItem = audioHandler.mediaItem.value;
                final bool isThisFileCurrent =
                    currentMediaItem?.id == widget.expenseModel.image;

                // Shu musiqa o'ynalyaptimi yoki yo'q
                final bool isThisFilePlaying = isThisFileCurrent && isPlaying;

                // Animatsiyani boshqarish
                if (isThisFilePlaying) {
                  if (!_animationController.isAnimating &&
                      !_animationController.isCompleted) {
                    _animationController.forward();
                  }
                } else {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  }
                }

                // Vaqtni hisoblash
                final position = playbackState?.position ?? Duration.zero;
                final duration = currentMediaItem?.duration ?? Duration.zero;

                final bool isFinished =
                    duration > Duration.zero && position >= duration;
                final currentPosition = isFinished ? Duration.zero : position;

                // Silliq yurishi uchun millisekunddan foydalanamiz
                final double maxDurationMs = duration.inMilliseconds > 0
                    ? duration.inMilliseconds.toDouble()
                    : 1.0;
                final double currentPositionMs = currentPosition.inMilliseconds
                    .toDouble()
                    .clamp(0.0, maxDurationMs);

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return StreamBuilder<PlaybackState>(
                          stream: audioHandler.playbackState,
                          builder: (context, bottomSnapshot) {
                            final bottomPlaybackState = bottomSnapshot.data;
                            final bottomIsPlaying =
                                bottomPlaybackState?.playing ?? false;

                            final bMediaItem = audioHandler.mediaItem.value;
                            final bIsCurrent =
                                bMediaItem?.id == widget.expenseModel.image;
                            final bIsPlaying = bIsCurrent && bottomIsPlaying;

                            final bPos =
                                bottomPlaybackState?.position ?? Duration.zero;
                            final bDur = bMediaItem?.duration ?? Duration.zero;

                            final bFinished =
                                bDur > Duration.zero && bPos >= bDur;
                            final bCurrentPos = bFinished
                                ? Duration.zero
                                : bPos;

                            final double bMaxMs = bDur.inMilliseconds > 0
                                ? bDur.inMilliseconds.toDouble()
                                : 1.0;
                            final double bCurMs = bCurrentPos.inMilliseconds
                                .toDouble()
                                .clamp(0.0, bMaxMs);

                            return Container(
                              height: context.height * 0.7,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Container(
                                    height: context.height * 0.35,
                                    width: context.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Cols.lgrey,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.music_note, size: 90),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Text(
                                    path.basename(widget.expenseModel.image!),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),

                                  Slider.adaptive(
                                    thumbColor: Cols.black,
                                    activeColor: Cols.grey,
                                    inactiveColor: Cols.lgrey,
                                    value: bCurMs,
                                    min: 0.0,
                                    max: bMaxMs,
                                    onChanged: (v) async {
                                      await audioHandler.seek(
                                        Duration(milliseconds: v.toInt()),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDuration(bCurrentPos),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          _formatDuration(bDur),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(width: context.width * 0.18),
                                      IconButton(
                                        onPressed: () async {
                                          final targetPos =
                                              bCurrentPos -
                                              const Duration(seconds: 5);
                                          final newPos =
                                              targetPos < Duration.zero
                                              ? Duration.zero
                                              : targetPos;

                                          await audioHandler.seek(newPos);
                                        },
                                        icon: Icon(Icons.replay_5, size: 30),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        iconSize: 60,
                                        onPressed: () async {
                                          if (bIsPlaying) {
                                            _animationController.reverse();
                                            await audioHandler.pause();
                                          } else {
                                            _animationController.forward();

                                            if (!bIsCurrent) {
                                              await audioHandler.playFile(
                                                widget.expenseModel.image!,
                                                widget.expenseModel.note ??
                                                    "Audio",
                                                "Expense App",
                                                "Audio Album",
                                              );
                                            } else {
                                              await audioHandler.play();
                                            }
                                          }
                                        },
                                        icon: AnimatedIcon(
                                          icon: AnimatedIcons.play_pause,
                                          progress: _animationController,
                                          size: 60,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        onPressed: () async {
                                          final targetPos =
                                              bCurrentPos +
                                              const Duration(seconds: 5);
                                          final newPos = targetPos > bDur
                                              ? bDur
                                              : targetPos;

                                          await audioHandler.seek(newPos);
                                        },
                                        icon: Icon(Icons.forward_5, size: 30),
                                      ),
                                      Spacer(),
                                      PopupMenuButton<double>(
                                        icon: const Icon(
                                          Icons.speed,
                                          color: Colors.black,
                                        ),
                                        onSelected: (double newSpeed) async {
                                          // Tanlangan tezlikni audio handler'ga yuboramiz
                                          await audioHandler.setSpeed(newSpeed);
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<double>>[
                                              const PopupMenuItem<double>(
                                                value: 1.0,
                                                child: Text('1.0x (Normal)'),
                                              ),
                                              const PopupMenuItem<double>(
                                                value: 1.25,
                                                child: Text('1.25x'),
                                              ),
                                              const PopupMenuItem<double>(
                                                value: 1.5,
                                                child: Text('1.5x'),
                                              ),
                                              const PopupMenuItem<double>(
                                                value: 2.0,
                                                child: Text('2.0x'),
                                              ),
                                            ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Cols.lgrey,
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () async {
                          await Share.shareXFiles([
                            XFile(widget.expenseModel.image!),
                          ], text: path.basename(widget.expenseModel.image!));
                        },
                        icon: const Icon(Icons.share),
                      ),
                      subtitle: Slider.adaptive(
                        value: currentPositionMs,
                        min: 0.0,
                        max: maxDurationMs,
                        onChanged: (v) async {
                          await audioHandler.seek(
                            Duration(milliseconds: v.toInt()),
                          );
                        },
                      ),
                      title: Text(path.basename(widget.expenseModel.image!)),
                      leading: IconButton.outlined(
                        onPressed: () async {
                          if (isThisFilePlaying) {
                            _animationController.reverse();
                            await audioHandler.pause();
                          } else {
                            _animationController.forward();

                            if (!isThisFileCurrent) {
                              await audioHandler.playFile(
                                widget.expenseModel.image!,
                                widget.expenseModel.note ?? "Audio",
                                "Expense App",
                                "Audio Album",
                              );
                            } else {
                              await audioHandler.play();
                            }
                          }
                        },
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _animationController,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Cols.lgrey,
                        child: SvgPicture.asset(
                          widget.expenseModel.type.name.checkcategory,
                        ),
                      ),
                      const SizedBox(width: 10),
                      widget.expenseModel.image != null &&
                              path
                                  .basename(widget.expenseModel.image!)
                                  .toLowerCase()
                                  .endsWith('.png')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Fullscreen(
                                        rasm: File(widget.expenseModel.image!),
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'rasm1',
                                  child: Image.file(
                                    File(widget.expenseModel.image!),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : widget.expenseModel.image != null
                          ? InkWell(
                              onTap: () =>
                                  OpenFile.open(widget.expenseModel.image!),
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Cols.lgrey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.insert_drive_file,
                                  size: 30,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.expenseModel.note ?? 'EMPTY',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.expenseModel.type.name.toUpperCase(),
                                  style: TextStyle(
                                    color: Cols.lightgrey,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyle(color: Cols.lightgrey),
                                ),
                                Text(
                                  widget.expenseModel.formattedCreatedAt,
                                  style: TextStyle(
                                    color: Cols.lightgrey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.expenseModel.income == true ? '+\$' : '-\$'}${widget.expenseModel.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: widget.expenseModel.income == true
                              ? Cols.green
                              : Cols.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(height: 1, color: Cols.lightgrey),
                ],
              ),
            ),
    );
  }
}
