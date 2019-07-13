//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.view;
import android.app.Activity;
import android.graphics.Rect;
import android.os.Build;
import android.util.Log;
import android.graphics.Point;
import android.view.View;
import android.view.Gravity;
import android.view.ViewGroup;
import android.view.Display;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import com.frontend.activity.ActivityPlugin;
import com.core.identifier.TagPlugin;
import com.frontend.notify.UnityNotifierPlugin;
public class WebViewPlugin {
    private final static int TRANSPARENT_BACK_GROUND_COLOR = 0x00000000;
    private WebView view;
    private FrameLayout layout;
    public void create(String requestUrl, int left, int top, int right, int bottom, int baseWidth, int baseHeight) {
        final Activity activity = ActivityPlugin.getInstance();
        final String url = requestUrl;
        Display display = activity.getWindowManager().getDefaultDisplay();
        Point point = new Point();
        display.getSize(point);
        float leftMarginRate = (float)left / baseWidth;
        float rightMarginRate = (float)right / baseWidth;
        float topMarginRate = (float)top / baseHeight;
        float bottomMarginRate = (float)bottom / baseHeight;
        float leftMargin =  leftMarginRate * (float)point.x;
        float rightMargin =  rightMarginRate * (float)point.x;
        float topMargin =  topMarginRate * (float)point.y;
        float bottomMargin =  bottomMarginRate * (float)point.y;
        final Rect margin = new Rect((int)leftMargin, (int)topMargin, (int)rightMargin, (int)bottomMargin);
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                view = new WebView(activity);
                WebSettings settings = view.getSettings();
                settings.setJavaScriptEnabled(true);
                view.setBackgroundColor(WebViewPlugin.TRANSPARENT_BACK_GROUND_COLOR);
                if (Integer.parseInt(Build.VERSION.SDK) >= Build.VERSION_CODES.HONEYCOMB) {
                    view.setLayerType(WebView.LAYER_TYPE_SOFTWARE, null);
                }
                WebViewClient client = new WebViewClient() {
                    @Override
                    public void onPageFinished(WebView view, String url) {
                        return;
                    }
                    @Override
                    public boolean shouldOverrideUrlLoading(WebView view, String url) {
                        return false;
                    }
                };
                view.setWebViewClient(client);
                view.loadUrl(url);
                FrameLayout.LayoutParams frameLayoutParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, Gravity.NO_GRAVITY);
                frameLayoutParams.setMargins(margin.left, margin.top, margin.right, margin.bottom);
                ViewGroup.LayoutParams viewLayoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                layout = new FrameLayout(activity);
                layout.setFocusable(true);
                layout.setFocusableInTouchMode(true);
                layout.addView(view, frameLayoutParams);
                activity.addContentView(layout, viewLayoutParams);
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    public void show() {
        this.setVisible(true);
        return;
    }
    public void hide() {
        this.setVisible(false);
        return;
    }
    public void setVisible(boolean visible) {
        final Activity activity = ActivityPlugin.getInstance();
        final boolean visibleView = visible;
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if (null == view) {
                    return;
                }
                if (false != visibleView) {
                    view.setVisibility(View.VISIBLE);
                } else {
                    view.setVisibility(View.GONE);
                }
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    public void destroy() {
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if (view == null || layout == null) {
                    return;
                }
                layout.removeView(view);
                view = null;
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
}
