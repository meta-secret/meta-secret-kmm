// File: MyLibraryWrapper.cpp

#include <jni.h>
#include <string>
#include <stdio.h>
#include <cstdint>
#include <iostream>

extern "C" {

JNIEXPORT jstring JNICALL
Java_utils_rustLib_RustLibraryWrapper_generateSignedUser(JNIEnv *env, jobject /* this */, jbyteArray vault_name_bytes, jint json_len) {

//        char *result = generate_signed_user(vault_name_bytes, json_len);

        jbyte* bytes = env->GetByteArrayElements(vault_name_bytes, NULL);
        std::string result(reinterpret_cast<char*>(bytes), json_len);
        env->ReleaseByteArrayElements(vault_name_bytes, bytes, JNI_ABORT);
        jstring javaString = env->NewStringUTF(result.c_str());

        return javaString;
    }
}