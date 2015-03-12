
var logoY;
var startY,endY;

var state=false;
var MainLayer = cc.Layer.extend({

    //构造函数
    ctor:function () {
        this._super();
        //背景
        this.backfground=new cc.Sprite(res.background_png);
        this.backfground.setPosition(Const.centre);
        this.addChild(this.backfground);

        cc.spriteFrameCache.addSpriteFrames(res.firstPage_plist);//加载plist包含了图片

        //----界面
        this.initUI=new FirstLayer();
        this.addChild(this.initUI);

        //添加音乐和向上按钮
        this.music=new MusicLayer();
        this.addChild(this.music);

        //触控
        var listener1 = cc.EventListener.create({
            event: cc.EventListener.TOUCH_ONE_BY_ONE,
            swallowTouches: true,        // 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞掉事件，不再向下传递。
            onTouchBegan: this.onTouchBegan,
            onTouchMoved:this.onTouchMoved,
            onTouchEnded:this.onTouchEnded
        });
        cc.eventManager.addListener(listener1, this);//为整个layer添加监听，也可只为一个精灵添加监听
        return true;
    },

    onTouchBegan:function(touch,event)
    {
        var target = event.getCurrentTarget();
        var position= touch.getLocation()//位置
        //cc.log("position.x: "+position.x+"  position.y: "+position.y);
        startY=position.y;
        return true;
    },
    onTouchMoved:function(touch,event)
    {
        var target = event.getCurrentTarget();
        var position= touch.getLocation()//位置
        //cc.log("position.x: "+position.x+"  position.y: "+position.y);
    },
    onTouchEnded:function(touch,event)
    {
        var target = event.getCurrentTarget();
        var position= touch.getLocation()//位置

        endY=position.y;
        if(endY-startY>Const.dy&&state)
        {
            cc.log("上一页");
            target.initUI.removeFromParent();
            target.initUI=new SecondLayer();
            target.addChild(target.initUI);

        }
        if(startY-endY>Const.dy&&state)
        {
            cc.log("下一页");
        }
    }



});

var MainScene  = cc.Scene.extend({
    onEnter:function () {
        this._super();
        var layer = new MainLayer();
        this.addChild(layer);
    }
});

