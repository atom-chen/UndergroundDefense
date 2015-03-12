
var SecondLayer = cc.Layer.extend({

    //构造函数
    ctor:function () {
        this._super();

        cc.spriteFrameCache.addSpriteFrames(res.thirdPage_plist);

        this.leftup=new cc.Sprite("#block_left_up2.png");
        this.leftup.attr({
            x:0,
            y:Const.h,
            anchorY : 1,
            anchorX:0
        });
        this.addChild(this.leftup);

        this.rightdown=new cc.Sprite("#block_right_down2.png");
        this.rightdown.attr({
            x:Const.w,
            y:0,
            anchorY : 0,
            anchorX:1
        });
        this.addChild(this.rightdown);


        this.rightup=new cc.Sprite("#block_right_up2.png");
        this.rightup.attr({
            x:Const.w-20,
            y:Const.h-35,
            anchorY :1,
            anchorX:1
        });
        this.addChild(this.rightup);


        this.line = new cc.ProgressTimer(new cc.Sprite(res.line_png));
        this.line.type = cc.ProgressTimer.TYPE_BAR;
        this.line.midPoint = cc.p(0, 1);
        this.line.barChangeRate = cc.p(0,1);
        this.line.percentage = 0;
        this.line.setPosition(cc.p(cc.winSize.width / 2 - 30, cc.winSize.height - this.line.height / 2));
        this.addChild(this.line);

        this.line.runAction(cc.progressTo(3,20));
        return true;
    }


});
