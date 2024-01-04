import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beauty_hub_admin/models/brand.dart';
import 'package:beauty_hub_admin/models/product.dart';
import 'package:beauty_hub_admin/models/product_detail.dart';
import 'package:beauty_hub_admin/shared/utils/app_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:beauty_hub_admin/modules/product_manage/controller/product_manage_controller.dart';



class AddProductController extends GetxController {
  final productController = Get.arguments as Product?;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController originController = TextEditingController();
  TextEditingController useController = TextEditingController();
  TextEditingController howToUseController = TextEditingController();

  Rxn<File> imageFile = Rxn(null);
  RxList<Category> chooseCategories = RxList<Category>();
  RxList<String> productUses = RxList<String>();
  RxList<String> howToUseList = RxList<String>();
  RxString title = RxString('');
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final productManageController = Get.find<ProductManageController>();
   Brand brand = Brand(
    "A9DVvInX9dcGFoTicW1TYYDJyCt1", "Phúc Mỹ Phẩm", 
    "https://firebasestorage.googleapis.com/v0/b/selling-food-store.appspot.com/o/brands%2FA9DVvInX9dcGFoTicW1TYYDJyCt1?alt=media&token=f8d8a1ad-fea5-4e9d-a447-305712e7d1b1");

  //Auth
  @override
  void onInit() {
    if (productController == null) {
      title.value = 'Thêm sản phẩm mới';
    } else {
      title.value = 'Chỉnh sửa sản phẩm';
      _fillProductData();
    }
    super.onInit();
  }

  void _fillProductData() {
    nameController.text = productController!.name;
    priceController.text = AppUtils.formatPrice(productController!.cost);
    descController.text = productController!.description;
    chooseCategories.addAll(productController!.categories);
    FirebaseService.fetchProductDetailInfoById(productController!.idProduct, (detail) {
      if (detail.introduce != null) {
        introController.text = detail.introduce!;
      }
      originController.text = detail.origin;
      productUses.value = detail.uses;
      howToUseList.value = detail.howToUse;
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
    if (productController == null) {
      if (globalKey.currentState!.validate()) {
        if (imageFile.value == null) {
          EasyLoading.showError('Ảnh sản phẩm là bắt buộc');
        } else if (productUses.isEmpty) {
          EasyLoading.showError('Công dụng sản phẩm là bắt buộc');
        } else if (howToUseList.isEmpty) {
          EasyLoading.showError('Chưa có hướng dẫn sử dụng sản phẩm');
        } else {
          EasyLoading.show(status: 'Đang upload hình ảnh');
        
            String idProduct = const Uuid().v4();
            double price = double.tryParse(priceController.text) ?? 0;
            FirebaseService.uploadImageProduct(idProduct, imageFile.value!,
                (image) {
              EasyLoading.dismiss();
              Product product = Product(
                  idProduct,
                  nameController.text,
                  image,
                  descController.text,
                  price,
                  1000,
                  brand,
                  chooseCategories,
                  1000);
              FirebaseService.writeProductToDb(product);
              ProductDetail productDetail = ProductDetail(
                  idProduct,
                  nameController.text,
                  image,
                  descController.text,
                  price,
                  1000,
                  introController.text,
                  ["san pham tot"],
                  productUses,
                  howToUseList,
                  originController.text,
                  ["use"],
                  brand,
                  chooseCategories,
                 1000);
              
              FirebaseService.writeDetailProductToDb(productDetail);
              productManageController.productList.add(product);
              EasyLoading.showSuccess('Đăng sản phẩm thành công');
            }, (error) {
              log('Error: $error');
              EasyLoading.showError('Đã có lỗi xảy ra');
            });
          
        }
      }
    }
    else{

       if (globalKey.currentState!.validate()) {
        if (imageFile.value == null) {
          EasyLoading.showError('Ảnh sản phẩm là bắt buộc');
        } else if (productUses.isEmpty) {
          EasyLoading.showError('Công dụng sản phẩm là bắt buộc');
        } else if (howToUseList.isEmpty) {
          EasyLoading.showError('Chưa có hướng dẫn sử dụng sản phẩm');
        } else {
          EasyLoading.show(status: 'Đang upload hình ảnh');
        
            String idProduct = const Uuid().v4();
            double price = double.tryParse(priceController.text) ?? 0;
          
              EasyLoading.dismiss();
              Product product = Product(
                  idProduct,
                  nameController.text,
                  productController!.image,
                  descController.text,
                  price,
                  1000,
                  brand,
                  chooseCategories,
                  10000);
              FirebaseService.writeProductToDb(product);
              ProductDetail productDetail = ProductDetail(
                  idProduct,
                  nameController.text,
                  productController!.image,
                  descController.text,
                  price,
                  10000,
                  introController.text,
                  ["san pham tot"],
                  productUses,
                  howToUseList,
                  originController.text,
                  ["san pham tot"],
                  brand,
                  chooseCategories,
                  100);
              
              FirebaseService.updateProduct(product.idProduct,product.convertToJson(),() {
                
              },(r) {
                
              },);
              FirebaseService.updateDetailProduct(productDetail.idProduct,productDetail.convertToJson(),() {
                
              },(r) {
                
              },);
              productManageController.productList.add(product);
              EasyLoading.showSuccess('Đăng sản phẩm thành công');
          
          
        }
      }

    }
  }
}
