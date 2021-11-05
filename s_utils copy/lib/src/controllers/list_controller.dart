import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/pagination_model.dart';
import '../commons/common.dart';

abstract class ListController<T> extends GetxController {
  final RefreshController refreshController = RefreshController();
  final listViewStatus = ViewStatus.init.obs;
  final keyword = "".obs;
  final pagination = PaginationModel().obs;
  String searchedKeyword = "";

  final data = <T>[].obs;

  @protected
  Future<Response> request([Map<String, dynamic>? params]);

  @protected
  List<T> transformData(List data);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData([bool? update]) async {
    if (listViewStatus.value != ViewStatus.init && update != null && update) listViewStatus.value = ViewStatus.init;
    try {
      searchedKeyword = keyword.value;
      Response res = await request();
      data.value = transformData(res.data['data']);
      pagination(PaginationModel.fromJson(res.data));
      refreshController.refreshCompleted();
      refreshController.resetNoData();
      if (pagination.value.links!.next == null) {
        refreshController.loadNoData();
      }
      listViewStatus.value = ViewStatus.loaded;
    } catch (e) {
      refreshController.refreshCompleted();
      listViewStatus.value = ViewStatus.error;
      print("ERROR: $e");
      throw e;
    }
  }

  void fetchMoreData() async {
    if (pagination.value.links == null) return refreshController.loadComplete();
    if (pagination.value.links!.next == null) {
      refreshController.loadNoData();
      return;
    }
    if (pagination.value.meta!.currentPage == pagination.value.meta!.lastPage) {
      refreshController.loadNoData();
    } else {
      try {
        Uri u = Uri.parse(pagination.value.links!.next!);
        final Map<String, String> p = u.queryParameters;
        Response res = await request(p);
        List<T> _d = transformData(res.data['data']);
        pagination.value = PaginationModel.fromJson(res.data);
        data.addAll(_d);
        refreshController.loadComplete();
        listViewStatus.value = ViewStatus.loaded;
      } catch (e) {
        refreshController.loadComplete();
        listViewStatus.value = ViewStatus.error;
        throw e;
      }
    }
  }
}
