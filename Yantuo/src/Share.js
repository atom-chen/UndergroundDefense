/**
 * Created by lingjianfeng on 14-8-31.
 */
    //继承的是LayerColor！！！！
var ShareLayer = cc.LayerColor.extend({

    ctor : function(){

        this._super(cc.color(0, 0, 0, 188), Const.w, Const.h);//黑屏

        this.initMeun();

    },

    initMeun : function(){

        var jiantou=new cc.Sprite(res.Allow_png);
        jiantou.anchorX = 0.5;
        jiantou.anchorY = 0.5;

        jiantou.x = Const.w - jiantou.getContentSize().width;
        jiantou.y = Const.h -jiantou.getContentSize().height;

        this.addChild(jiantou);

        //文字
        var label = new cc.LabelTTF("请点击右上角的菜单按钮\n再点\"分享到朋友圈\"\n让好友们挑战你的分数！", "宋体", 20);
        label.x =Const.w/2;
        label.y =Const.h/2+50;
        label.textAlign = cc.LabelTTF.TEXT_ALIGNMENT_CENTER;
        label.color = cc.color(255, 255, 255);
        this.addChild(label);
    }

});