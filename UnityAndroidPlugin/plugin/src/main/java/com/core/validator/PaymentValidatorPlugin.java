//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.core.validator;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.service.response.PaymentServiceResponsePlugin;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import org.json.JSONException;
import org.json.JSONObject;
public class PaymentValidatorPlugin {
    public static boolean isValid(String skuName, Bundle skuDetailsList) throws JSONException {
        if (false == skuDetailsList.containsKey("DETAILS_LIST")) {
            int response = PaymentServiceResponsePlugin.getResponse(skuDetailsList);
            if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                return false;
            } else {
                return false;
            }
        }
        boolean ret = false;
        ArrayList<String> detailList = skuDetailsList.getStringArrayList("DETAILS_LIST");
        for (String detail : detailList) {
            JSONObject jsonObject = new JSONObject(detail);
            String productId = jsonObject.optString("productId");
            if (productId.equals(skuName)) {
                ret = true;
                break;
            }
        }
        return ret;
    }
    public static boolean isValid(String base64EncordedPublickKey, String signedData, String signatureData) {
        byte[] signatureBytes;
        String errorMessage = null;
        try {
            signatureBytes = Base64.decode(signatureData, Base64.DEFAULT);
            byte[] decodedKey = Base64.decode(base64EncordedPublickKey, Base64.DEFAULT);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            PublicKey pubickKey = keyFactory.generatePublic(new X509EncodedKeySpec(decodedKey));
            Signature signature = Signature.getInstance("SHA1withRSA");
            signature.initVerify(pubickKey);
            signature.update(signedData.getBytes());
            if (!signature.verify(signatureBytes)) {
                return false;
            }
            return true;
        } catch (IllegalArgumentException e) {
            errorMessage = e.getMessage();
        } catch (NoSuchAlgorithmException e) {
            errorMessage = e.getMessage();
        } catch (InvalidKeySpecException e) {
            errorMessage = e.getMessage();
        } catch (InvalidKeyException e) {
            errorMessage = e.getMessage();
        } catch (SignatureException e) {
            errorMessage = e.getMessage();
        }
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, errorMessage);
        return false;
    }
}