
var FirstLayer = cc.Layer.extend({

    //构造函数
    ctor:function () {
        this._super();

        //----界面
        this.initUI();

        return true;
    },

    initUI:function()
    {
        this.logo=new cc.Sprite("#logo.png")
        //this.logo.setPosition(Const.centre);
        this.logo.setPositionX(Const.w/2);
        logoY=Const.h/2+this.logo.height/2;
        this.logo.setPositionY(logoY);
        this.logo.setScale(0.1);
        //logo加载好再加载别的UI
        var seqAction=cc.sequence(cc.scaleBy(1,10),cc.callFunc(this.loadUI,this),cc.delayTime(1),cc.callFunc(function(){
            state=true;//可以触屏
        },this))
        this.logo.runAction(seqAction);
        this.addChild(this.logo);



    },

    loadUI:function()
    {
        //
        this.rightup=new cc.Sprite("#block_right up.png")
        this.rightup.attr({
            x:Const.w,
            y:Const.h,
            anchorY : 0,
            anchorX:0
        });
        this.rightup.runAction(cc.moveBy(1,cc.p(-this.rightup.width-30,-this.rightup.height-30)));
        this.addChild(this.rightup);


        this.leftup=new cc.Sprite("#block_left up.png")
        this.leftup.attr({
            x:0,
            y:Const.h,
            anchorY : 0,
            anchorX:1
        });
        this.leftup.runAction(cc.moveBy(1,cc.p(320,-250)));
        this.addChild(this.leftup);


        this.leftdown=new cc.Sprite("#block_left down.png")
        this.leftdown.attr({
            x:0,
            y:0,
            anchorY : 1,
            anchorX:1
        });
        this.leftdown.runAction(cc.moveBy(1,cc.p(this.leftdown.width,this.leftdown.height)));
        this.addChild(this.leftdown);


        this.rightdown=new cc.Sprite("#block_right down.png")
        this.rightdown.attr({
            x:Const.w,
            y:0,
            anchorY : 1,
            anchorX:0
        });
        this.rightdown.runAction(cc.moveBy(1,cc.p(-this.rightdown.width,this.rightdown.height)));
        this.addChild(this.rightdown);


        this.leftdown_text=new cc.Sprite("#font_left.png")
        this.leftdown_text.attr({
            x:0,
            y:0,
            anchorY : 1,
            anchorX:1
        });
        this.leftdown_text.runAction(cc.moveBy(1,cc.p(this.leftdown_text.width,3*this.leftdown_text.height)));
        this.addChild(this.leftdown_text);


        this.rightdown_text=new cc.Sprite("#font_right.png")
        this.rightdown_text.attr({
            x:Const.w,
            y:0,
            anchorY : 1,
            anchorX:0
        });
        this.rightdown_text.runAction(cc.moveBy(1,cc.p(-this.rightdown_text.width,logoY-this.logo.height/2-20)));
        this.addChild(this.rightdown_text);


    }



});
