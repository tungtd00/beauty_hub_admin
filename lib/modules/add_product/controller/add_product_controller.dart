import 'dart:developer';
import 'dart:io';

import 'package:beauty_hub_admin/models/product.dart';
import 'package:beauty_hub_admin/models/product_detail.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:beauty_hub_admin/shared/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/category.dart';

class AddProductController extends GetxController {
  final product = Get.arguments as Product?;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController originController = TextEditingController();

  Rxn<File> imageFile = Rxn(null);
  RxList<Category> categories = RxList<Category>();
  RxList<Category> chooseCategories = RxList<Category>();
  RxString title = RxString('');
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void onInit() {
    FirebaseService.fetchCategories((dataList) {
      categories.value = dataList;
    });
    if (product == null) {
      title.value = 'Thêm sản phẩm mới';
    } else {
      title.value = 'Chỉnh sửa sản phẩm';
      _fillProductData();
    }
    super.onInit();
  }

  void _fillProductData() {
    nameController.text = product!.name;
    priceController.text = AppUtils.formatPrice(product!.cost);
    descController.text = product!.description;
    FirebaseService.fetchProductDetailInfoById(product!.idProduct, (detail) {
      if (detail.introduce != null) {
        introController.text = detail.introduce!;
      }
      originController.text = detail.origin;
      chooseCategories.value = product!.categories;
    }, (error) {
      log('Error: $error');
      EasyLoading.showError('Đã có lỗi xảy ra');
    });
  }

  void chooseImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((data) {
      if (data == null) {
      } else {
        imageFile.value = File(data.path);
      }
    });
  }

  void onConfirmAddProduct() {
    EasyLoading.show(status: 'Đang upload hình ảnh');
    FirebaseService.fetchBrandInfo((branInfo) {
      String idProduct = const Uuid().v4();
      double price = double.tryParse(priceController.text) ?? 0;
      FirebaseService.uploadImageProduct(idProduct, imageFile.value!, (image) {
        EasyLoading.dismiss();
        Product product = Product(idProduct, nameController.text, image,
            descController.text, price, null, branInfo, categories, null);
        FirebaseService.writeProductToDb(product);
        ProductDetail productDetail = ProductDetail(
            idProduct,
            nameController.text,
            image,
            descController.text,
            price,
            null,
            introController.text,
            null,
            [],
            [],
            originController.text,
            null,
            branInfo,
            chooseCategories,
            null);
        FirebaseService.writeDetailProductToDb(productDetail);
        EasyLoading.showSuccess('Đăng sản phẩm thành công');
      }, (error) {
        log('Error: $error');
        EasyLoading.showError('Đã có lỗi xảy ra');
      });
    });
  }
}
