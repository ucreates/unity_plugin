//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin;
using UnityPlugin.Frontend.Controller;
using UnityPlugin.Core.Preference;
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
public class PaymentControllerPluginEventHandler : MonoBehaviour {
    private PaymentControllerPlugin paymentControllerPlugin {
        get;
        set;
    }
    void Start() {
        this.paymentControllerPlugin = PluginFactory.GetPlugin<PaymentControllerPlugin>();
    }
    public void OnPayment() {
        this.paymentControllerPlugin.Payment("userId", "paymentProductId");
    }
}
