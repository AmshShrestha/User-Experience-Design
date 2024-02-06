import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'package:travel_log/config/constants/api_endpoint.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/detail_entity.dart';
import '../../viewmodel/detail_view_model.dart';

class TripView extends ConsumerStatefulWidget {
  const TripView({Key? key}) : super(key: key);

  @override
  _TripViewState createState() => _TripViewState();
}

class _TripViewState extends ConsumerState<TripView> {
  void _onDeletePressed(DetailEntity tripDetail) {
    final viewModel = ref.read(detailViewModelProvider.notifier);
    viewModel.deleteDetails(context, tripDetail);
  }

  // Function to open the URL
  Future<void> _launchURL(String? url, BuildContext context) async {
    if (url != null) {
      try {
        Uri uri = Uri.parse(url);
        if (await canLaunch(uri.toString())) {
          await launch(uri.toString());
        } else {
          showSnackBar(message: 'Invalid URL', context: context);
        }
      } catch (e) {
        showSnackBar(message: 'Invalid URL', context: context);
      }
    } else {
      showSnackBar(message: 'URL is null', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailState = ref.watch(detailViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: detailState.details.length,
                itemBuilder: (context, index) {
                  var tripDetail = detailState.details[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Image Container
                          Container(
                            width: 80, // Adjust the width as needed
                            height: 80, // Adjust the height as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: tripDetail.image != null
                                    ? NetworkImage(ApiEndpoints.imageUrl +
                                        detailState.details[index].image!)
                                    : const AssetImage(
                                            'assets/images/placeholder_image.png')
                                        as ImageProvider<Object>,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Details Container
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tripDetail.title!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchURL(tripDetail.url, context);
                                    print('URL: $tripDetail.url');
                                  },
                                  child: Text(
                                    tripDetail.url ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Time : ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      (tripDetail.date!),
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Delete Button
                          IconButton(
                            onPressed: () {
                              _onDeletePressed(tripDetail);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
