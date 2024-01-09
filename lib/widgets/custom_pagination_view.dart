import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/empty_container.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import '../core/app_export.dart';

// ignore: must_be_immutable
class CustomPaginationView extends StatelessWidget {
  CustomPaginationView(
      {super.key,
      required PagingController<int, dynamic> pagingController,
      required this.itemBuilder,
      this.onRefresh,
      this.noDataFound})
      : _pagingController = pagingController;

  final PagingController<int, dynamic> _pagingController;
  final Widget Function(BuildContext, dynamic, int) itemBuilder;
  Future<void> Function()? onRefresh;
  void Function()? noDataFound;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh ??
            () => Future.sync(() {
                  _pagingController.refresh();
                }),
        color: appTheme.orange,
        child: PagedListView<int, dynamic>.separated(
          // padding: const EdgeInsets.only(top: 10),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
            animateTransitions: true,
            transitionDuration: const Duration(milliseconds: 500),
            firstPageProgressIndicatorBuilder: (context) =>
                const CustomLoading(),
            newPageProgressIndicatorBuilder: (context) => const CustomLoading(),
            noItemsFoundIndicatorBuilder: (context) => EmptyContainer(
              msg: 'No Data Found',
              onTap: noDataFound!,
            ),
            noMoreItemsIndicatorBuilder: (context) {
              return SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(
                      "No More Data",
                      style: TextStyle(
                        color: appTheme.black900,
                      ),
                    ),
                  ));
            },
            firstPageErrorIndicatorBuilder: (_) {
              print(
                  "PPPPPPjhs zxcgzhdv hxgvz hxzgcvgc yxcgfzjPPP ${_pagingController.error.toString()}");
              return ElevatedButton(
                  onPressed: () => _pagingController.refresh(),
                  child: Text(_pagingController.error.toString()));
            },
            newPageErrorIndicatorBuilder: (_) {
              print("Kkkkkkkkkkkkk ${_pagingController.error.toString()}");
              return ElevatedButton(
                  onPressed: () => _pagingController.retryLastFailedRequest(),
                  child: Text(_pagingController.error.toString()));
            },
            itemBuilder: itemBuilder,
          ),
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        ));
  }
}
