//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service.sns;
public class LineServicePlugin {
    private Boolean loggedIn = false;
    private String userId = "";
    public boolean isLoggedIn() {
        return this.loggedIn;
    }
    public String getUserId() {
        return this.userId;
    }
}
