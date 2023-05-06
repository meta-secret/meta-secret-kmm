class RustBridge {
    companion object {
        @JvmStatic
        private external fun doSomething(pattern: String): String
    }

    fun justAnotherFunction(to: String): String {
        return doSomething(to)
    }
}