
cc.game.onStart = function(){
    cc.view.adjustViewPort(true);
    if (cc.sys.isMobile) {
        //分辨率不变--不随大小改变
        cc.view.setDesignResolutionSize(320, 480, cc.ResolutionPolicy.FIXED_WIDTH);
        cc.log("Mobile");
    }
    else {
        cc.view.setDesignResolutionSize(320, 480, cc.ResolutionPolicy.SHOW_ALL);
        cc.log("Web");
    }
    //获取屏幕高宽--cc.winSize
    var size = cc.winSize;
    //设置屏幕高宽
    Const.h=size.height;
    Const.w=size.width;

    cc.log("屏幕宽度: "+Const.w+" 屏幕高度: "+Const.h);

    cc.view.resizeWithBrowserSize(true);
    //load resources
    cc.LoaderScene.preload(g_resources, function () {
        cc.director.runScene(new MainMeunSence());
    }, this);
};
cc.game.run();