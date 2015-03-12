/**
 * Created by lingjianfeng on 14-8-31.
 */

var GPBackgroundLayer = cc.Layer.extend({

    ctor : function(){

        this._super();

        this.initBackground();

        //定时器，移动背景
        this.schedule(this.moveBackground, 1 / 6);
    },

    initBackground : function(){

        //从内存中拿出bg01.png
        this._sptBg = new cc.Sprite("#bg01.png");
        this._sptBg.attr({
            x: Const.w/2,
            y:  Const.h/2
        });
        this.addChild(this._sptBg);

        this._sptBg1 = new cc.Sprite("#bg01.png");
        this._sptBg1.attr({
            x:Const.w/2,
            y:  Const.h+(Const.h/2)
        });
        this.addChild(this._sptBg1);

        //奇怪---两个sprite用同一个动作之后面的运行

        /*答案：要想一个 CCNode 跑一个action，就要对每个CCnode定制特定的action，你在调用的runAction的时候，其实不是在修改CCnode的属性，
        而是在CCActionManager中注册你的Action，而且每个Action在manager中是惟一的，也只能对一个CCNode服务！
        所以楼主的调用顺序是：首先你把action1在CCActionManager中注册给对象smallchuck,紧接着，你又把action1注册给了对象bg，
        然后第一次注册就会失效，他只能为bg对象服务！*/

       // var actionTo = cc.MoveTo.create();
        var easeMove = cc.moveBy(3,cc.p(0,-200));//1秒钟往y移动10
        var easeMove1 = cc.moveBy(3,cc.p(0,-200));//1秒钟往y移动10

        var reAction=easeMove.repeatForever();//此运动永远执行

        var reAction1=easeMove1.repeatForever();//此运动永远执行

        //2张背景添加运动
        this._sptBg.runAction(reAction);

        this._sptBg1.runAction(reAction);

        //Action测试
       /* var easeMove = cc.moveBy(3,cc.p(0,-200));//1秒钟往y移动10
        var faneaseMove=easeMove.reverse();//去反动作

        //按顺序执行一组动作
        var seqAction = cc.sequence(easeMove,faneaseMove);

        //永远执行
        var reAction=seqAction.repeatForever();
        this._sptBg.runAction(reAction);*/
    },

    //移动背景函数
    moveBackground:function()
    {
        cc.log("_sptBy: "+this._sptBg.y+"  _sptBy1: "+this._sptBg1.y);
        if(this._sptBg.y<=-Const.h/2)
            this._sptBg.y=Const.h/2+Const.h;

        if(this._sptBg1.y<=-Const.h/2)
            this._sptBg1.y=Const.h/2+Const.h;
    }
});
