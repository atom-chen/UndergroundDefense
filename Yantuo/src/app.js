
var MainMeunLayer = cc.Layer.extend({
    sprite:null,

    ctor:function () {
        //////////////////////////////
        // 1. super init first
        this._super();

        //        创建一个精灵作为背景[锚点-比例-默认为0.5，正中间], 以及坐标定位在屏幕中间
        //背景
        this._Bg = new cc.Sprite(res.Background_jpg);
        //指定位置
       /* this._Bg.x= Const.w/2;
        this._Bg.y=Const.h/2;*/
        this._Bg.attr({
            x: Const.w/2,
            y: Const.h/2
        });
        //默认值为0
        this.addChild(this._Bg);

        //----图片按钮
        this._title=new cc.Sprite(res.Title_png);
        this._title.x=Const.w/2;
        this._title.y=Const.h/2;
        this.addChild(this._title,1);

        //layer触屏监听---点击监听
        cc.eventManager.addListener({
            event: cc.EventListener.TOUCH_ALL_AT_ONCE,
            onTouchesEnded: function (touches, event) {
                var touch = touches[0];
                //获取点击的坐标
                var pos = touch.getLocation();

                //大概估计开始坐标
                if (pos.y < cc.winSize.height/5) {
                    cc.log(pos.y);
                    //场景跳转
                    cc.director.runScene(new cc.TransitionFade(1.2, new GameingSence()));
                }
            }
        }, this);

        return true;
    }
});

var MainMeunSence = cc.Scene.extend({
    onEnter:function () {
        this._super();
        var layer = new MainMeunLayer();
        this.addChild(layer);
    }
});

