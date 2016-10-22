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
import android.hardware.Camera;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.YuvImage;
import android.os.Build;
import android.view.Display;
import android.view.Gravity;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import com.frontend.activity.ActivityPlugin;
public class CameraViewPlugin {
    private final static int CAPTURE_QUALITY = 25;
    private final static int PIXEL_PER_BYTE = 8;
    private Camera camera;
    private FrameLayout layout;
    private SurfaceView view;
    private SurfaceHolder.Callback callback;
    private boolean created;
    private byte[] texture;
    public CameraViewPlugin() {
        this.callback = null;
        this.camera = null;
        this.created = false;
        this.layout = null;
        this.texture = null;
        this.view = null;
    }
    public void create() {
        if (false != this.created) {
            return;
        }
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                final Camera.PreviewCallback previewCallBack = new Camera.PreviewCallback() {
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    @Override
                    public void onPreviewFrame(byte[] bytes, Camera camera) {
                        Camera.Parameters cameraParameters = camera.getParameters();
                        List<Camera.Size> sizeList = cameraParameters.getSupportedPreviewSizes();
                        Camera.Size previewSize = sizeList.get(0);
                        int previewFormat = cameraParameters.getPreviewFormat();
                        int width = previewSize.width;
                        int height = previewSize.height;
                        try {
                            YuvImage image = new YuvImage(bytes, previewFormat, width, height, null);
                            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                            Rect imageSize = new Rect(0, 0, width, height);
                            image.compressToJpeg(imageSize, CameraViewPlugin.CAPTURE_QUALITY, outputStream);
                            texture = outputStream.toByteArray();
                            outputStream.reset();
                            outputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
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
                            List<Camera.Size> sizeList = cameraParameters.getSupportedPreviewSizes();
                            Camera.Size previewSize = sizeList.get(0);
                            int previewFormat = cameraParameters.getPreviewFormat();
                            int orientation = this.getOrientation();
                            byte[] buffer = this.allocatePixelBuffer(previewFormat, previewSize.width, previewSize.height);
                            camera.addCallbackBuffer(buffer);
                            camera.setDisplayOrientation(orientation);
                            camera.setPreviewCallbackWithBuffer(previewCallBack);
                            camera.setPreviewDisplay(holder);
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
                        return;
                    }
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
                        if (null == camera) {
                            return;
                        }
                        Camera.Parameters cameraParameters = camera.getParameters();
                        WindowManager windowManager = (WindowManager)activity.getSystemService(activity.WINDOW_SERVICE);
                        Display display = windowManager.getDefaultDisplay();
                        if (false != this.surfaceCreated) {
                            camera.stopPreview();
                        }
                        int currentOrientation = display.getRotation();
                        if (currentOrientation == Surface.ROTATION_0) {
                            cameraParameters.setPreviewSize(width, height);
                        } else if (currentOrientation == Surface.ROTATION_90) {
                            cameraParameters.setPreviewSize(height, width);
                        } else if (currentOrientation == Surface.ROTATION_180) {
                            cameraParameters.setPreviewSize(width, height);
                        } else if (currentOrientation == Surface.ROTATION_270) {
                            cameraParameters.setPreviewSize(height, width);
                        }
                        byte[] buffer = this.allocatePixelBuffer(format, width, height);
                        int orientation = this.getOrientation(currentOrientation);
                        camera.setDisplayOrientation(orientation);
                        camera.addCallbackBuffer(buffer);
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
                    @TargetApi(Build.VERSION_CODES.FROYO)
                    private int getOrientation() {
                        WindowManager windowManager = (WindowManager)activity.getSystemService(activity.WINDOW_SERVICE);
                        Display display = windowManager.getDefaultDisplay();
                        int orientation = display.getRotation();
                        return this.getOrientation(orientation);
                    }
                    private int getOrientation(int currentOrientation) {
                        int ret = 0;
                        if (currentOrientation == Surface.ROTATION_0) {
                            ret = 0;
                        } else if (currentOrientation == Surface.ROTATION_90) {
                            ret = 90;
                        } else if (currentOrientation == Surface.ROTATION_180) {
                            ret = 180;
                        } else if (currentOrientation == Surface.ROTATION_270) {
                            ret = 270;
                        }
                        return ret;
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
        });
        return;
    }
    public void show() {
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (null == camera) {
                    return;
                }
                camera.startPreview();
                return;
            }
        });
        return;
    }
    public void update(boolean suspend) {
        if (false != suspend) {
            this.hide();
            this.destroy();
        } else {
            this.create();
            this.show();
        }
        return;
    }
    public void hide() {
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (null == camera) {
                    return;
                }
                camera.stopPreview();
                return;
            }
        });
        return;
    }
    public void destroy() {
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @TargetApi(Build.VERSION_CODES.FROYO)
            @Override
            public void run() {
                if (false == created) {
                    return;
                }
                view.setVisibility(View.INVISIBLE);
                layout.removeView(view);
                layout = null;
                texture = null;
                view = null;
                created = false;
                return;
            }
        });
        return;
    }
    public byte[] getTexture() {
        return this.texture;
    }
}
