import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import '../../models/brand.dart';
import '../../models/order.dart';
import '../../models/product_detail.dart';
import '../../models/user_info.dart' as models;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beauty_hub_admin/models/product.dart';
import 'package:beauty_hub_admin/models/category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:beauty_hub_admin/models/user_admin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:beauty_hub_admin/models/detail_brand.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _database = FirebaseDatabase.instance;
  static final _storage = FirebaseStorage.instance;

  static final _dbRef = _database.refFromURL(AppConstants.dbUrl);
  static final _storeRef = _storage.refFromURL(AppConstants.stoRef);
  Brand brand = Brand(
    "A9DVvInX9dcGFoTicW1TYYDJyCt1", "Phúc Mỹ Phẩm", 
    "https://firebasestorage.googleapis.com/v0/b/selling-food-store.appspot.com/o/brands%2FA9DVvInX9dcGFoTicW1TYYDJyCt1?alt=media&token=f8d8a1ad-fea5-4e9d-a447-305712e7d1b1");

  //Auth
  static Future<UserAdmin?> loginWithEmailPassword(
    String email,
    String password,
    Function(String) onError,
  ) async {
    try {
      _dbRef.child('UserAdmin').get().then((snapshot) {
        for (DataSnapshot dataSnapshot in snapshot.children) {
          final data = jsonDecode(jsonEncode(dataSnapshot.value))
              as Map<String, dynamic>;
          UserAdmin userAdminTest = UserAdmin.fromJson(data);
          if (userAdminTest.email == email &&
              userAdminTest.password == password) {
            return userAdminTest;
          }
        }
        return null;
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          onError('Email không hợp lệ');
          break;
        case 'invalid-credential':
          onError('Tài khoản không tồn tại');
          break;
        case 'wrong-password':
          onError('Mật khẩu không đúng');
          break;
        default:
          onError('Đã có lỗi xảy ra. Vui lòng đăng nhập lại');
          break;
      }
      return null;
    }
  }

  static void signOut(Function() onSuccess, Function(String) onFailure) {
    _auth.signOut().then((value) {
      onSuccess();
    }).onError((error, stackTrace) => onFailure(error.toString()));
  }

  static Future<void> fetchUserAdmin(
    Function(List<UserAdmin>) onComplete,
    Function(String) onError,
  ) async {
    List<UserAdmin> userAdmin = [];
    final prefs = Get.find<SharedPreferences>();
    // String idUser = prefs.getString(AppConstants.idUser) ?? '';
    _dbRef.child('UserAdmin').get().then((snapshot) {
      for (DataSnapshot dataSnapshot in snapshot.children) {
        final data =
            jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
        UserAdmin product = UserAdmin.fromJson(data);
        if (product.role == "2") {
          userAdmin.add(product);
        }
      }
      onComplete(userAdmin);
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  //Product Manage
  static Future<void> fetchProducts(
    Function(List<Product>) onComplete,
    Function(String) onError,
  ) async {
    List<Product> products = [];
    final prefs = Get.find<SharedPreferences>();
    String idUser = prefs.getString(AppConstants.idUser) ?? '';
    _dbRef.child('Products').get().then((snapshot) {
      for (DataSnapshot dataSnapshot in snapshot.children) {
        final data =
            jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
        Product product = Product.fromJson(data);
          products.add(product);
        
      }
      onComplete(products);
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void deleteProduct(String idProduct) async {
    _dbRef.child('Products').child(idProduct).remove();
    EasyLoading.showToast('Xóa sản phẩm thành công');
  }

  static Future<void> deleteUserAdmin(String idAccount) async {
    DataSnapshot snapshot = await _dbRef
        .child('UserAdmin')
        .orderByChild('idAccount')
        .equalTo(idAccount)
        .get();

    Map<dynamic, dynamic>? values = snapshot.value as Map<Object?, Object?>;
    var convertedMap = values.cast<String, dynamic>();
    if (values != null) {
      convertedMap.forEach((key, value) {
        _dbRef.child('UserAdmin').child(key).remove();
      });
    }
     EasyLoading.showToast('Xóa tài khoản thành công');
  }
   static Future<void> updateUserAdmin(UserAdmin userAdmin) async {
    DataSnapshot snapshot = await _dbRef
        .child('UserAdmin')
        .orderByChild('idAccount')
        .equalTo(userAdmin.idAccount)
        .get();

    Map<dynamic, dynamic>? values = snapshot.value as Map<Object?, Object?>;
    var convertedMap = values.cast<String, dynamic>();
    if (values != null) {
      convertedMap.forEach((key, value) {
        _dbRef.child('UserAdmin').child(key).update(userAdmin.toJson());
      });
    }
     EasyLoading.showSuccess('Cập nhập thành công');
   
  }

  static void uploadImageProduct(
    String id,
    File imageFile,
    Function(String) onSuccess,
    Function(String) onFailure,
  ) {
    _storeRef
        .child('products')
        .child(id)
        .putFile(imageFile)
        .then((taskSnapshot) async {
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      if (imageUrl.isNotEmpty) {
        onSuccess(imageUrl);
      }
    }).onError((error, stackTrace) => onFailure(error.toString()));
  }

  static void writeProductToDb(Product product) {
    _dbRef
        .child('Products')
        .child(product.idProduct)
        .set(product.convertToJson());
  }

  static void writeUserAdminToDb(
    UserAdmin userAdmin,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef
        .child('UserAdmin')
        .push()
        .set(userAdmin.toJson())
        .then((value) => onComplete())
        .onError((error, stackTrace) => onError(error.toString()));
  }

  static void writeDetailProductToDb(ProductDetail detail) {
    _dbRef
        .child('DetailProducts')
        .child(detail.idProduct)
        .set(detail.convertToJson());
  }

  //Order Manage
  static Future<void> fetchOrders(Function(List<Order>) onComplete) async {
    List<Order> orders = [];
    _dbRef.child('Orders').get().then((snapshot) {
      for (DataSnapshot dataSnapshot in snapshot.children) {
        final data =
            jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
        Order order = Order.fromJson(data);
        orders.add(order);
      }
      onComplete(orders);
    });
  }

  static void fetchProductInfoById(
      String id, Function(Product) onComplete, Function(String) onError) {
    _dbRef.child('Products').child(id).get().then((snapshot) {
      final data =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      onComplete(product);
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void fetchProductDetailInfoById(
      String id, Function(ProductDetail) onComplete, Function(String) onError) {
    _dbRef.child('DetailProducts').child(id).get().then((snapshot) {
      final data =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      ProductDetail detail = ProductDetail.fromJson(data);
      onComplete(detail);
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void fetchUserInfo(String id, Function(models.UserInfo) onComplete,
      Function(String) onError) {
    _dbRef.child('Users').child(id).get().then((snapshot) {
      final data =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      models.UserInfo userInfo = models.UserInfo.fromJson(data);
      onComplete(userInfo);
    }).onError((error, stackTrace) => onError(error.toString()));
  }

  static void confirmOrder(String id, Function(String) onError) {
    _dbRef.child('Orders').child(id).update({"status": "SUCCESS"}).onError(
        (error, stackTrace) => onError(error.toString()));
  }

  static void cancelOrder(String id, Function(String) onError) {
    _dbRef.child('Orders').child(id).update({"status": "CANCEL"}).onError(
        (error, stackTrace) => onError(error.toString()));
  }

  static Future<void> fetchCategories(
      Function(List<Category>) onComplete) async {
    List<Category> categories = [];
    _dbRef.child('Categories').get().then((snapshot) {
      for (DataSnapshot dataSnapshot in snapshot.children) {
        final data =
            jsonDecode(jsonEncode(dataSnapshot.value)) as Map<String, dynamic>;
        Category order = Category.fromJson(data);
        categories.add(order);
      }
      onComplete(categories);
    });
  }

  static void fetchBrandWithAccount(
    Function(bool) onComplete,
    Function(String) onError,
  ) {
    final prefs = Get.find<SharedPreferences>();
    final idBrand = prefs.getString(AppConstants.idUser);
    if (idBrand != null) {
      _dbRef.child('Brands').child(idBrand).get().then((snapshot) {
        onComplete(snapshot.exists);
      }).onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static Future<void> fetchBrandInfo(Function(Brand) onComplete) async {
    final prefs = Get.find<SharedPreferences>();
    final idBrand = prefs.getString(AppConstants.idUser);
    if (idBrand != null) {
      _dbRef.child('Brands').child(idBrand).get().then((snapshot) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        Brand brand = Brand.fromJson(data);
        onComplete(brand);
      });
    }
  }

  static void updateProduct(
    String id,
    Map<String, dynamic> data,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('Products').child(id).update(data);
  }

  static void updateDetailProduct(
    String id,
    Map<String, dynamic> data,
    Function() onComplete,
    Function(String) onError,
  ) {
    _dbRef.child('DetailProducts').child(id).update(data);
  }

  static void createStore(
    Brand brand,
    Function() onComplete,
    Function(String) onError,
  ) {
    final prefs = Get.find<SharedPreferences>();
    final idBrand = prefs.getString(AppConstants.idUser);
    if (idBrand != null) {
      _dbRef
          .child('Brands')
          .child(idBrand)
          .set(brand.toJson())
          .then((value) => onComplete())
          .onError((error, stackTrace) => onError(error.toString()));
    }
  }

  static void writeDetailToStore(DetailBrand detailBrand) {
    final prefs = Get.find<SharedPreferences>();
    final idBrand = prefs.getString(AppConstants.idUser);
    if (idBrand != null) {
      _dbRef.child('DetailBrands').child(idBrand).set(detailBrand.toJson());
    }
  }

  static void uploadLogoBrand(
    File imageFile,
    Function(String) onSuccess,
    Function(String) onFailure,
  ) {
    EasyLoading.show(status: 'Đang upload hình ảnh cửa hàng');
    final prefs = Get.find<SharedPreferences>();
    final idBrand = prefs.getString(AppConstants.idUser);
    if (idBrand != null) {
      _storeRef
          .child('brands')
          .child(idBrand)
          .putFile(imageFile)
          .then((taskSnapshot) async {
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        if (imageUrl.isNotEmpty) {
          EasyLoading.dismiss();
          onSuccess(imageUrl);
        }
      }).onError((error, stackTrace) => onFailure(error.toString()));
    }
  }
}
