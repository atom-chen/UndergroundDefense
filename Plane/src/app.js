
var MainMeunLayer = cc.Layer.extend({
    //    属性声明
    _backgroundLayer : null,
    _touchLayer      : null,

    ctor:function () {
        //        调用父类ctor方法。结合下面MainMenuScene中的onEnter 可以得出：this._super() 调用父类当前方法。
        this._super();

        cc.log(Const.w/2,Const.h/2);

        //包装成函数
        this.addBackgroundLayer();//背景

        this.addTouchLayer();//按钮



        return true;
    },
    //    定义方法----添加背景
    addBackgroundLayer : function(){

        //layer添加layer
//        创建一个背景层，并且添加到当前层中
        this._backgroundLayer = new MMBackgroundLayer();
        this.addChild(this._backgroundLayer);
    },

    //----------添加按钮
    addTouchLayer : function(){
        this._touchLayer = new MMTouchLayer();
        this.addChild(this._touchLayer);
    }
});



//创建一个场景，继承自cc.Scene
var MainMeunSence = cc.Scene.extend({
    onEnter:function () {
        //        调用父类的onEnter()方法。
        this._super();
        var layer = new MainMeunLayer();
        this.addChild(layer);
    }
});

