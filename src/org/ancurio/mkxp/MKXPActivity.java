package org.ancurio.mkxp;
import android.content.Context;
import android.os.Build;

import org.libsdl.app.SDLActivity;

import java.io.File;

public class MKXPActivity extends SDLActivity
{
    /*static {
		System.loadLibrary("mkxp");
    }*/
    public static String getLibDir(Context c) {
        String s = c.getApplicationInfo().nativeLibraryDir;
        if (!s.endsWith(File.separator)) {
            s += File.separator;
        }
        return s;
    }
    public static native void loadLibs(String path);
}
