

var MMBackgroundLayer = cc.Layer.extend({

    _sptBg     : null,
    _sptLogo   : null,
    _ship      : null,

    ctor : function(){

        //        调用父类ctor方法。结合下面MainMenuScene中的onEnter 可以得出：this._super() 调用父类当前方法。
        this._super()

//        将plist资源加载到内存中
        cc.spriteFrameCache.addSpriteFrames(res.TextureTransparentPack_plist);

        this.initBackground();//背景图片

        this.initShip();//飞行的敌机

        this.initLogo();//加载标题

        return true;

    },

    initBackground : function(){

//        创建一个精灵作为背景[锚点默认为0.5], 以及坐标定位在屏幕中间
        this._sptBg = new cc.Sprite(res.mm_bg_png);
        //指定位置
        this._sptBg.attr({
            x: Const.w/2,
            y: Const.h/2
        });
        //默认值为0
        this.addChild(this._sptBg);
    },

    initLogo : function(){
        this._sptLogo = new cc.Sprite(res.mm_logo_png);
        this._sptLogo.attr({
            x: Const.w/2,
            y: Const.h/2+60
        });
        //在0之后加载，在0层的上面
        this.addChild(this._sptLogo,1);
    },

    initShip : function(){

//        (#)号代表从内存中去获取一张纹理(图片)，因为我们前面有把那个plist加载到内存中
        this._ship = new cc.Sprite("#ship01.png");
        this.addChild(this._ship);

        //随机产生飞机位置
        this._ship.x = Math.random() * Const.w;
        this._ship.y = 0;

//        运行一个moveBy类型的动作
//        moveTo是在指定时间移动指定点，而XXBy则表示向量-改变值。
        this._ship.runAction(cc.moveBy(2, cc.p(Math.random() * Const.w, this._ship.y + Const.h + 100)));


//        定时器，每隔0.1秒去执行this.update()方法
        this.schedule(this.update, 0.1);

    },
    update:function () {
        if (this._ship.y > 480) {
            this._ship.x = Math.random() * Const.w;
            this._ship.y = 10;
            this._ship.runAction(cc.moveBy(
                parseInt(5 * Math.random(), 10),
                cc.p(Math.random() * Const.w, this._ship.y + 480)
            ));
        }
    }
});