package utils.rustLib

class RustLibraryWrapper {
    external fun generateSignedUser(vaultNameBytes: ByteArray?, jsonLen: Int): String?
    companion object {
        init {
            System.loadLibrary("meta-secret-kmm")
        }
    }
}