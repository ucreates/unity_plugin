//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef BuildPlugin_h
#define BuildPlugin_h
class BuildPlugin {
   public:
    static const int N = 24;
    static const int M = 23;
    static const int LOLLIPOP_MR1 = 22;
    static const int LOLLIPOP = 21;
    static const int KITKAT_WATCH = 20;
    static const int KITKAT = 19;
    static const int JELLY_BEAN_MR2 = 18;
    static const int JELLY_BEAN_MR1 = 17;
    static const int JELLY_BEAN = 16;
    static const int ICE_CREAM_SANDWICH_MR1 = 15;
    static const int ICE_CREAM_SANDWICH = 14;
    static const int HONEYCOMB_MR2 = 13;
    static const int HONEYCOMB_MR1 = 12;
    static const int HONEYCOMB = 11;
    static const int GINGERBREAD_MR1 = 10;
    static const int GINGERBREAD = 9;
    static const int FROYO = 8;
    static const int ECLAIR_MR1 = 7;
    static const int ECLAIR_0_1 = 6;
    static const int ECLAIR = 5;
    static const int DONUT = 4;
    static const int CUPCAKE = 3;
    static const int BASE_1_1 = 2;
    static const int BASE = 1;
    static int getVersion();
};
#endif /* BuildPlugin_h */
