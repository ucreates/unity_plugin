// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
package com.frontend.notify;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Notification;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.NotificationManagerCompat;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import com.core.identifier.TagPlugin;
import com.frontend.activity.ActivityPlugin;
import com.unity3d.player.UnityPlayerActivity;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Timer;
import java.util.TimerTask;
public abstract class BaseNotifierPlugin {
    private static final int HEADS_UP_REQUESTED = 2;
    protected boolean enable;
    protected Context context;
    public BaseNotifierPlugin() {
        this.enable = false;
    }
    public void register() {
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Window window = activity.getWindow();
                window.setFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN, WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
                return;
            }
        };
        activity.runOnUiThread(runnable);
        this.context = activity;
        this.enable = true;
        return;
    }
    public void register(Context context, Intent intent) {
        return;
    }
    public void notify(String title, String body, long timeInterval) {
        Activity activity = ActivityPlugin.getInstance();
        Intent nextIntent = new Intent(activity, UnityPlayerActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(activity, 777, nextIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        this.notify(title, body, timeInterval, pendingIntent);
        return;
    }
    public void notify(final String title, final String body, final long timeInterval, final PendingIntent intent) {
        final Activity activity = ActivityPlugin.getInstance();
        final BaseNotifierPlugin notifier = this;
        if (null != activity) {
            Runnable runnable = new Runnable() {
                @Override
                public void run() {
                    notifier.notify(title, body, timeInterval, intent, activity);
                }
            };
            activity.runOnUiThread(runnable);
        } else {
            notifier.notify(title, body, timeInterval, intent, this.context);
        }
        return;
    }
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void notify(String title, String body, long timeInterval, PendingIntent intent, final Context context) {
        if (false == enable) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "LocalNotifierPlugin is not granted.");
            return;
        }
        String packageName = context.getPackageName();
        PackageManager packageManager = context.getPackageManager();
        ApplicationInfo appInfo = null;
        try {
            appInfo = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
            return;
        }
        int iconId = appInfo.icon;
        Resources resrouces = context.getResources();
        Bitmap icon = BitmapFactory.decodeResource(resrouces, iconId);
        long when = System.currentTimeMillis();
        long timeIntervalSecond = timeInterval * 1000;
        Notification.Builder builder = new Notification.Builder(context);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            Bundle bundle = new Bundle();
            bundle.putInt("headsup", BaseNotifierPlugin.HEADS_UP_REQUESTED);
            try {
                Class<?> clazz = builder.getClass();
                Method method = clazz.getMethod("setExtras", Bundle.class);
                method.invoke(builder, bundle);
            } catch (NoSuchMethodException e) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
                return;
            } catch (IllegalArgumentException e) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
                return;
            } catch (IllegalAccessException e) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
                return;
            } catch (InvocationTargetException e) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
                return;
            }
            builder.setAutoCancel(true)
            .setContentTitle(title)
            .setContentText(body)
            .setTicker(title)
            .setWhen(when)
            .setSmallIcon(iconId)
            .setLargeIcon(icon)
            .setContentIntent(intent)
            .setDefaults(Notification.DEFAULT_SOUND | Notification.DEFAULT_VIBRATE)
            .setPriority(Notification.PRIORITY_HIGH)
            .setFullScreenIntent(intent, true)
            .setOngoing(true);
        } else {
            builder.setAutoCancel(true)
            .setContentTitle(title)
            .setContentText(body)
            .setTicker(title)
            .setWhen(when)
            .setSmallIcon(iconId)
            .setLargeIcon(icon)
            .setContentIntent(intent)
            .setDefaults(Notification.DEFAULT_SOUND | Notification.DEFAULT_VIBRATE);
        }
        final Notification notification = builder.build();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                NotificationManagerCompat manager = NotificationManagerCompat.from(context);
                manager.notify(0, notification);
                return;
            }
        };
        Timer timer = new Timer();
        timer.schedule(task, timeIntervalSecond);
        return;
    }
    public boolean isEnabled() {
        return this.enable;
    }
}
