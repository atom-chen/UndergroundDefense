
//教程网址http://cn.cocos2d-x.org/tutorial/show?id=1729
cc.game.onStart = function(){
    cc.view.adjustViewPort(true);

    //调制屏幕适配
    var mode = cc.sys.isMobile && window.navigator.userAgent.indexOf("MicroMessenger") != -1 ? cc.ResolutionPolicy.FIXED_HEIGHT : cc.sys.isMobile ? cc.ResolutionPolicy.FIXED_WIDTH : cc.ResolutionPolicy.SHOW_ALL;
    cc.view.setDesignResolutionSize(640, 831, mode);
    cc.view.resizeWithBrowserSize(true);

    //获取屏幕高宽--cc.winSize
    var size = cc.winSize;
    //设置屏幕高宽
    Const.h=size.height;
    Const.w=size.width;
    Const.centre=cc.p(Const.w/2,Const.h/2);
    //load resources
    cc.LoaderScene.preload(g_resources, function () {
        cc.director.runScene(new MainScene ());
    }, this);
};
cc.game.run();