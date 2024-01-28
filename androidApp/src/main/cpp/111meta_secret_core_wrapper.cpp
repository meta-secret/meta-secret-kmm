//// File: MyLibraryWrapper.cpp
//
//#include <jni.h>
//#include <string>
//#include <stdio.h>
//#include <cstdint>
//#include <iostream>
//
//extern "C" {
////JNIEXPORT jstring JNICALL
////Java_utils_rustLib_RustLibraryWrapper_stringFromJNI(JNIEnv *env, jobject /* this */) {
////    char *result = "c";
////    return reinterpret_cast<jstring>(result);
////}
//
//
//JNIEXPORT jstring JNICALL
//Java_utils_rustLib_RustLibraryWrapper_generateSignedUser(
//        JNIEnv *env,
//        jobject /* this */,
//        jbyteArray vault_name_bytes,
//        jint json_len) {
//
////        char *result = generate_signed_user(vault_name_bytes, json_len);
////        char str[sizeof(vault_name_bytes) + 1];
////        memcpy(str, vault_name_bytes, sizeof(vault_name_bytes));
////        str[sizeof(vault_name_bytes)] = '\0';
//
////        printf("%s\n", str);
////        printf("%d\n", json_len);
//
//    // Получаем указатель на байты из jbyteArray
//    jbyte* bytes = env->GetByteArrayElements(vault_name_bytes, NULL);
//
//    // Преобразуем байты в строку
//    std::string result(reinterpret_cast<char*>(bytes), json_len);
//
//    // Освобождаем байты (важно для избежания утечек памяти)
//    env->ReleaseByteArrayElements(vault_name_bytes, bytes, JNI_ABORT);
//
//    // Создаем Java строку из строки C++
//    jstring javaString = env->NewStringUTF(result.c_str());
//
//    return javaString;
////        std::cout << "Длина: " << json_len << std::endl;
//
////        delete[] result;
////        char *result = "c";
////        return reinterpret_cast<jstring>(result);
//    }
//}