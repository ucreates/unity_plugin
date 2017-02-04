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
import android.annotation.TargetApi;
import android.app.Activity;
import android.graphics.ImageFormat;
import android.hardware.Camera;
import android.graphics.PixelFormat;
import android.graphics.Point;
import android.os.Build;
import android.view.Gravity;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import com.frontend.activity.ActivityPlugin;
import com.frontend.notify.NotifierPlugin;
import com.gateway.UnityAndroidPlugin;
import java.io.IOException;
import java.util.List;
public class CameraViewPlugin {
    private final static int PREVIEW_WIDTH = 640;
    private final static int PREVIEW_HEIGHT = 480;
    private final static int PIXEL_PER_BYTE = 8;
    private final static int DISPLAY_ORIENTATION = 0;
    private final static int PREVIEW_FRAMERATE = 30;
    private final static String COMPLETE_DESTROY_MESSAGE = "complete destroy camera";
    private Camera camera;
    private SurfaceHolder.Callback callback;
    private boolean created;
    private FrameLayout layout;
    private int previewBufferSize;
    private String callbackGameObjectName;
    private String showCallbackName;
    private String hideCallbackName;
    private SurfaceView view;
    public CameraViewPlugin() {
        this.callback = null;
        this.camera = null;
        this.created = false;
        this.layout = null;
        this.view = null;
        this.callbackGameObjectName = null;
        this.showCallbackName = null;
        this.hideCallbackName = null;
    }
    public void create(final String gameObjectName, final String onShowCallbackName, final String onHideCallbackName) {
        if (false != this.created) {
            return;
        }
        this.callbackGameObjectName = gameObjectName;
        this.showCallbackName = onShowCallbackName;
        this.hideCallbackName = onHideCallbackName;
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                final Camera.PreviewCallback previewCallBack = new Camera.PreviewCallback() {
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    @Override
                    public void onPreviewFrame(byte[] bytes, Camera camera) {
                        Camera.Parameters cameraParameters = camera.getParameters();
                        Camera.Size previewSize = cameraParameters.getPreviewSize();
                        UnityAndroidPlugin.setPreviewFrameCameraViewPlugin(bytes, previewBufferSize, previewSize.width, previewSize.height);
                        camera.addCallbackBuffer(bytes);
                        return;
                    }
                };
                callback = new SurfaceHolder.Callback() {
                    private boolean surfaceCreated = false;
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    public void surfaceCreated(SurfaceHolder holder) {
                        try {
                            if (null != camera) {
                                return;
                            }
                            camera = Camera.open(Camera.CameraInfo.CAMERA_FACING_BACK);
                            if (null == camera) {
                                return;
                            }
                            Camera.Parameters cameraParameters = camera.getParameters();
                            cameraParameters.setPreviewFormat(ImageFormat.NV21);
                            Point previewSize = this.getPreviewSize(cameraParameters);
                            int previewWidth = previewSize.x;
                            int previewHeight = previewSize.y;
                            byte[] buffer = this.allocatePixelBuffer(ImageFormat.NV21, previewWidth, previewHeight);
                            previewBufferSize = previewWidth * previewHeight + (previewWidth * previewHeight / 2);
                            camera.addCallbackBuffer(buffer);
                            camera.setParameters(cameraParameters);
                            camera.setPreviewCallbackWithBuffer(previewCallBack);
                            camera.setPreviewDisplay(holder);
                            String parameter = String.valueOf(previewWidth) + "x" + String.valueOf(previewHeight);
                            NotifierPlugin.notify(gameObjectName, onShowCallbackName, parameter);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        return;
                    }
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    public void surfaceDestroyed(SurfaceHolder holder) {
                        if (null == camera) {
                            return;
                        }
                        camera.stopPreview();
                        camera.addCallbackBuffer(null);
                        camera.setPreviewCallbackWithBuffer(null);
                        camera.release();
                        camera = null;
                        holder.removeCallback(callback);
                        this.surfaceCreated = false;
                        NotifierPlugin.notify(callbackGameObjectName, hideCallbackName, CameraViewPlugin.COMPLETE_DESTROY_MESSAGE);
                        return;
                    }
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
                        if (null == camera) {
                            return;
                        }
                        if (false != this.surfaceCreated) {
                            camera.stopPreview();
                        }
                        byte[] buffer = this.allocatePixelBuffer(ImageFormat.NV21, width, height);
                        Camera.Parameters cameraParameters = camera.getParameters();
                        Point previewSize = this.getPreviewSize(cameraParameters);
                        int previewWidth = previewSize.x;
                        int previewHeight = previewSize.y;
                        cameraParameters.setPreviewSize(previewWidth, previewHeight);
                        cameraParameters.setPreviewFrameRate(CameraViewPlugin.PREVIEW_FRAMERATE);
                        camera.addCallbackBuffer(buffer);
                        camera.setDisplayOrientation(CameraViewPlugin.DISPLAY_ORIENTATION);
                        camera.setParameters(cameraParameters);
                        camera.setPreviewCallbackWithBuffer(previewCallBack);
                        camera.startPreview();
                        this.surfaceCreated = true;
                        return;
                    }
                    private byte[] allocatePixelBuffer(int previewFormat, int width, int height) {
                        PixelFormat pixelFormat = new PixelFormat();
                        PixelFormat.getPixelFormatInfo(previewFormat, pixelFormat);
                        int bufferSize = width * height * pixelFormat.bitsPerPixel / CameraViewPlugin.PIXEL_PER_BYTE;
                        byte[] buffer = new byte[bufferSize];
                        return buffer;
                    }
                    private Point getPreviewSize(Camera.Parameters cameraParameters) {
                        int previewWidth = 0;
                        int previewHeight = 0;
                        List<Camera.Size> sizeList = cameraParameters.getSupportedPreviewSizes();
                        for (int i = 0; i < sizeList.size(); i++) {
                            Camera.Size previewSize = sizeList.get(i);
                            if (CameraViewPlugin.PREVIEW_WIDTH == previewSize.width && CameraViewPlugin.PREVIEW_HEIGHT == previewSize.height) {
                                previewWidth = CameraViewPlugin.PREVIEW_WIDTH;
                                previewHeight = CameraViewPlugin.PREVIEW_HEIGHT;
                                break;
                            }
                        }
                        if (0 == previewWidth && 0 == previewHeight) {
                            int index = sizeList.size() - 1;
                            Camera.Size previewSize = sizeList.get(index);
                            previewWidth = previewSize.width;
                            previewHeight = previewSize.height;
                        }
                        return new Point(previewWidth, previewHeight);
                    }
                };
                FrameLayout.LayoutParams frameLayoutParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, Gravity.NO_GRAVITY);
                ViewGroup.LayoutParams viewGroupLayoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                view = new SurfaceView(activity);
                SurfaceHolder holder = view.getHolder();
                holder.setFixedSize(0, 0);
                holder.addCallback(callback);
                holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
                view.setVisibility(View.VISIBLE);
                layout = new FrameLayout(activity);
                layout.addView(view, frameLayoutParams);
                activity.addContentView(layout, viewGroupLayoutParams);
                created = true;
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    public void show() {
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if (null == camera) {
                    return;
                }
                camera.startPreview();
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    public void update(boolean suspend) {
        if (false != suspend) {
            this.hide();
            this.destroy();
        } else {
            this.create(this.callbackGameObjectName, this.showCallbackName, this.hideCallbackName);
        }
        return;
    }
    public void hide() {
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if (null == camera) {
                    return;
                }
                camera.stopPreview();
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    public void destroy() {
        this.hide();
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @TargetApi(Build.VERSION_CODES.FROYO)
            @Override
            public void run() {
                if (false == created) {
                    return;
                }
                view.setVisibility(View.INVISIBLE);
                layout.removeView(view);
                layout = null;
                view = null;
                created = false;
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
}
