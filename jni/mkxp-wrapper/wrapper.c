#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
static JavaVM* mVm;
static void* mReserved;

int libs_loaded = 0;
static void* libHandle;

jint (*al_jnionload)(JavaVM* vm, void* reserved);
jint (*sdl_jnionload)(JavaVM* vm, void* reserved);

extern jint JNI_OnLoad(JavaVM* vm, void* reserved)
{
	mVm = vm;
	mReserved = reserved;
	return JNI_VERSION_1_4;
}

int checkLibError()
{
	const char* error = dlerror();
	if(error)
	{
		__android_log_print(ANDROID_LOG_ERROR, "mkxp", "%s", error);
		return 1;
	}
	return 0;
}

JNIEXPORT jint JNICALL Java_org_ancurio_mkxp_MKXPActivity_loadLibs(JNIEnv * env, jobject obj, jstring path)
{
	if(!libs_loaded)
	{
		jboolean isCopy;
		char* libPath =(char*)(*env)->GetStringUTFChars(env, path, &isCopy); 
		dlerror();
		libHandle = dlopen(libPath, RTLD_NOW);

		al_jnionload = dlsym(libHandle, "al_JNI_OnLoad");
		sdl_jnionload = dlsym(libHandle, "JNI_OnLoad");
		(*al_jnionload)(mVm, mReserved);
		(*sdl_jnionload)(mVm, mReserved);

		libs_loaded = 1;
		(*env)->ReleaseStringUTFChars(env, path, libPath);
		return 0;
	}
	return 0;
}
