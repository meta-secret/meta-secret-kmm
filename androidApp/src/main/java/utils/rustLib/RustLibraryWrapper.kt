package utils.rustLib

class RustLibraryWrapper {
//    external fun stringFromJNI(): String
    external fun generateSignedUser(vaultNameBytes: ByteArray?, jsonLen: Int): String?
    companion object {
        init {
            System.loadLibrary("meta-secret-kmm")
        }
    }
}

//public class RustLibraryWrapper {
//    external fun generateSignedUser(): String

//    companion object {
//        // Used to load the 'hworld' library on application startup.
//        init {
//            System.loadLibrary("meta_secret_core_swift")
//        }
//    }

//    external fun generateSignedUser(vaultNameBytes: ByteArray, jsonLen: Int): String

//    init {
//        System.loadLibrary("meta_secret_core_swift")
//    }
//}