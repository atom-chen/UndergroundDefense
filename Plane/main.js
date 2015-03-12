
cc.game.onStart = function(){
    cc.view.adjustViewPort(true);
    cc.view.enableAutoFullScreen(false);
    var mode = cc.sys.isMobile && window.navigator.userAgent.indexOf("MicroMessenger") != -1 ? cc.ResolutionPolicy.FIXED_HEIGHT : cc.sys.isMobile ? cc.ResolutionPolicy.FIXED_WIDTH : cc.ResolutionPolicy.SHOW_ALL;
    cc.view.setDesignResolutionSize(320, 480, mode);
    cc.view.resizeWithBrowserSize(true);
    //获取屏幕高宽--cc.winSize
    var size = cc.winSize;
    //设置屏幕高宽
    Const.h=size.height;
    Const.w=size.width;

    //load resources
    cc.LoaderScene.preload(g_resources, function () {
        cc.director.runScene(new MainMeunSence());
    }, this);
};
cc.game.run();