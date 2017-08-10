#include <jni.h>
#include <android/log.h>
#include <dlfcn.h>
#include <stddef.h>
static JavaVM* mVm;
static void* mReserved;

int libs_loaded = 0;
static void* libHandle;

// JNI_OnLoad functions
jint (*al_jnionload)(JavaVM* vm, void* reserved);
jint (*sdl_jnionload)(JavaVM* vm, void* reserved);

// SDL Functions to wrap
int (*sdl_nativeInit)(JNIEnv* env, jclass jcls, jobject array);
void (*sdl_dropFile)(JNIEnv* env, jclass jcls, jstring filename);
void (*sdl_resize)(JNIEnv* env, jclass jcls, jint width, jint height, jint format, jfloat rate);
jint (*sdl_padDown)(JNIEnv* env, jclass jcls, jint device_id, jint keycode);
jint (*sdl_padUp)(JNIEnv* env, jclass jcls, jint device_id, jint keycode);
void (*sdl_joy)(JNIEnv* env, jclass jcls, jint device_id, jint axis, jfloat value);
void (*sdl_hat)(JNIEnv* env, jclass jcls, jint device_id, jint hat_id, jint x, jint y);
jint (*sdl_addJoystick)(JNIEnv* env, jclass jcls, jint device_id, jstring device_name, jint is_accelerometer, jint nbuttons, jint naxes, jint nhats, jint nballs);
jint (*sdl_removeJoystick)(JNIEnv* env, jclass jcls, jint device_id);
void (*sdl_surfaceChanged)(JNIEnv* env, jclass jcls);
void (*sdl_surfaceDestroyed)(JNIEnv* env, jclass jcls);
void (*sdl_keyDown)(JNIEnv* env, jclass jcls, jint keycode);
void (*sdl_keyUp)(JNIEnv* env, jclass jcls, jint keycode);
void (*sdl_keybFocus)(JNIEnv* env, jclass jcls);
void (*sdl_touch)(JNIEnv* env, jclass jcls, jint touch_device_id_in, jint pointer_finger_id_in, jint action, jfloat x, jfloat y, jfloat p);
void (*sdl_mouse)(JNIEnv* env, jclass jcls, jint button, jint action, jfloat x, jfloat y);
void (*sdl_accel)(JNIEnv* env, jclass jcls, jfloat x, jfloat y, jfloat z);
void (*sdl_lowmem)(JNIEnv* env, jclass jcls);
void (*sdl_quit)(JNIEnv* env, jclass jcls);
void (*sdl_pause)(JNIEnv* env, jclass jcls);
void (*sdl_resume)(JNIEnv* env, jclass jcls);
void (*sdl_commitText)(JNIEnv* env, jclass jcls, jstring text, jint newCursorPosition);
void (*sdl_setComposingText)(JNIEnv* env, jclass jcls, jstring text, jint newCursorPosition);
jstring (*sdl_getHint)(JNIEnv* env, jclass jcls, jstring name);

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

JNIEXPORT jint JNICALL Java_org_ancurio_mkxp_MKXPActivity_loadLibs(JNIEnv * env, jclass jcls, jstring path)
{
	if(!libs_loaded)
	{
		jboolean isCopy;
		char* libPath =(char*)(*env)->GetStringUTFChars(env, path, &isCopy); 
		dlerror();
		libHandle = dlopen(libPath, RTLD_NOW);
		(*env)->ReleaseStringUTFChars(env, path, libPath);
		// Grab OnLoad symbols
		al_jnionload = dlsym(libHandle, "al_JNI_OnLoad");
		sdl_jnionload = dlsym(libHandle, "JNI_OnLoad");
		(*al_jnionload)(mVm, mReserved);
		(*sdl_jnionload)(mVm, mReserved);

		// Grab SDL symbols
		sdl_nativeInit = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeInit");
		sdl_dropFile = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeDropFile");
		sdl_resize = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeResize");
		sdl_padDown = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativePadDown");
		sdl_padUp = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativePadUp");
		sdl_joy = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeJoy");
		sdl_hat = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeHat");
		sdl_addJoystick = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeAddJoystick");
	    sdl_removeJoystick = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeRemoveJoystick");
	    sdl_surfaceChanged = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeSurfaceChanged");
		sdl_surfaceDestroyed = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeSurfaceDestroyed");
		sdl_keyDown = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeKeyDown");
		sdl_keyUp = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeKeyUp");
		sdl_keybFocus = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeKeyboardFocusLost");
		sdl_touch = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeTouch");
		sdl_mouse = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeMouse");
		sdl_accel = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_onNativeAccel");
		sdl_lowmem = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeLowMemory");
		sdl_quit = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeQuit");
		sdl_pause = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativePause");
		sdl_resume = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeResume");
		sdl_commitText = dlsym(libHandle, "Java_org_libsdl_app_SDLInputConnection_nativeCommitText");
		sdl_setComposingText = dlsym(libHandle, "Java_org_libsdl_app_SDLInputConnection_nativeSetComposingText");
		sdl_getHint = dlsym(libHandle, "Java_org_libsdl_app_SDLActivity_nativeGetHint");
		checkLibError();
		libs_loaded = 1;
	}
	return 0;
}

JNIEXPORT int JNICALL Java_org_ancurio_mkxp_MKXPActivity_unloadLibs(JNIEnv * env, jclass jcls)
{
	if(libs_loaded && !libHandle)
	{
		return -1;
	}

	int libclose = dlclose(libHandle);
	if(libclose)
	{
		__android_log_print(ANDROID_LOG_ERROR, "mkxp", "Couldn't unload %d", libclose);
	} else {
		libs_loaded = 0;
	}
	checkLibError();
	return 0;
}

// SDL functions
JNIEXPORT int JNICALL Java_org_libsdl_app_SDLActivity_nativeInit(JNIEnv* env, jclass jcls, jobject array)
{
	if(libs_loaded)
		return (*sdl_nativeInit)(env, jcls, array);
	return -1;
}

void Java_org_libsdl_app_SDLActivity_onNativeDropFile(
                                    JNIEnv* env, jclass jcls,
                                    jstring filename)
{
	if(libs_loaded)
		(*sdl_dropFile)(env, jcls, filename);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeResize(
                                    JNIEnv* env, jclass jcls,
                                    jint width, jint height, jint format, jfloat rate)
{
	if(libs_loaded)
		(*sdl_resize)(env, jcls, width, height, format, rate);
}

JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_onNativePadDown(
                                    JNIEnv* env, jclass jcls,
                                    jint device_id, jint keycode)
{
	if(libs_loaded)
		return (*sdl_padDown)(env, jcls, device_id, keycode);
	return -1;
}

JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_onNativePadUp(
                                   JNIEnv* env, jclass jcls,
                                   jint device_id, jint keycode)
{
	if(libs_loaded)
		return (*sdl_padUp)(env, jcls, device_id, keycode);
	return -1;
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeJoy(
                                    JNIEnv* env, jclass jcls,
                                    jint device_id, jint axis, jfloat value)
{
	if(libs_loaded)
		(*sdl_joy)(env, jcls, device_id, axis, value);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeHat(
                                    JNIEnv* env, jclass jcls,
                                    jint device_id, jint hat_id, jint x, jint y)
{
	if(libs_loaded)
		(*sdl_hat)(env, jcls, device_id, hat_id, x, y);
}

JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_nativeAddJoystick(
    JNIEnv* env, jclass jcls,
    jint device_id, jstring device_name, jint is_accelerometer,
    jint nbuttons, jint naxes, jint nhats, jint nballs)
{
	if(libs_loaded)
		return (*sdl_addJoystick)(env, jcls, device_id, device_name, is_accelerometer, nbuttons, naxes, nhats, nballs);
	return -1;
}

JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_nativeRemoveJoystick(
    JNIEnv* env, jclass jcls, jint device_id)
{
	if(libs_loaded)
		return (*sdl_removeJoystick)(env, jcls, device_id);
	return -1;
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeSurfaceChanged(JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_surfaceChanged)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeSurfaceDestroyed(JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_surfaceDestroyed)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyDown(
                                    JNIEnv* env, jclass jcls, jint keycode)
{
	if(libs_loaded)
		(*sdl_keyDown)(env, jcls, keycode);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyUp(
                                    JNIEnv* env, jclass jcls, jint keycode)
{
	if(libs_loaded)
		(*sdl_keyUp)(env, jcls, keycode);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyboardFocusLost(
                                    JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_keybFocus)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeTouch(
                                    JNIEnv* env, jclass jcls,
                                    jint touch_device_id_in, jint pointer_finger_id_in,
                                    jint action, jfloat x, jfloat y, jfloat p)
{
	if(libs_loaded)
		(*sdl_touch)(env, jcls, touch_device_id_in, pointer_finger_id_in, action, x, y, p);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeMouse(
                                    JNIEnv* env, jclass jcls,
                                    jint button, jint action, jfloat x, jfloat y)
{
	if(libs_loaded)
		(*sdl_mouse)(env, jcls, button, action, x, y);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeAccel(
                                    JNIEnv* env, jclass jcls,
                                    jfloat x, jfloat y, jfloat z)
{
	if(libs_loaded)
		(*sdl_accel)(env, jcls, x, y, z);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeLowMemory(
                                    JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_lowmem)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeQuit(
                                    JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_quit)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativePause(
                                    JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_pause)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeResume(
                                    JNIEnv* env, jclass jcls)
{
	if(libs_loaded)
		(*sdl_resume)(env, jcls);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLInputConnection_nativeCommitText(
                                    JNIEnv* env, jclass jcls,
                                    jstring text, jint newCursorPosition)
{
	if(libs_loaded)
		(*sdl_commitText)(env, jcls, text, newCursorPosition);
}

JNIEXPORT void JNICALL Java_org_libsdl_app_SDLInputConnection_nativeSetComposingText(
                                    JNIEnv* env, jclass jcls,
                                    jstring text, jint newCursorPosition)
{
	if(libs_loaded)
		(*sdl_setComposingText)(env, jcls, text, newCursorPosition);
}

JNIEXPORT jstring JNICALL Java_org_libsdl_app_SDLActivity_nativeGetHint(JNIEnv* env, jclass jcls, jstring name)
{
	if(libs_loaded)
		return (*sdl_getHint)(env, jcls, name);
	return NULL;
}
