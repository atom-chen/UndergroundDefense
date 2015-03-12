/**
 * Created by lingjianfeng on 14-8-31.
 */

var buttonW;
var buttonH;
var buttonY;


var SuccessLayer = cc.Layer.extend({

    ctor : function(){

        this._super();

        this.initMenu();

        //屏幕点击监听
       /* cc.eventManager.addListener({
            event: cc.EventListener.TOUCH_ALL_AT_ONCE,
            onTouchesEnded: this.hit   //触屏函数
        }, this);
*/

    },

    initMenu : function(){

        this.winPanel = new cc.Sprite(res.Success_png);
        this.winPanel.x = Const.w/2;
        this.winPanel.y = Const.h/2+80;
        this.addChild(this.winPanel);

        var w = this.winPanel.width, h = this.winPanel.height;
        var label = new cc.LabelTTF("继续刷屏！\n"+"6步推倒我的小羊驼\n打败99%朋友圈的人！\n你能超过我吗？", "宋体", 20);
        label.x = w/2;
        label.y = h/4+5;
        label.textAlign = cc.LabelTTF.TEXT_ALIGNMENT_CENTER;
        //label.boundingWidth = w;
        label.width = w;
        //label.setString("hahahahah");
        label.color = cc.color(0, 0, 0);
        //面板上面加文字
        this.winPanel.addChild(label,1);

        //按钮
        buttonY=this.winPanel.y-w/2-40;

        this.notyfy=new cc.Sprite(res.Notify_png);
        this.notyfy.attr({
            x:Const.w/2,
            y:buttonY,
            anchorX:1

        })
        this.addChild(this.notyfy);
        buttonW=this.notyfy.getContentSize().width;
        buttonH=this.notyfy.getContentSize().height;

        this.replay=new cc.Sprite(res.Reply_png);
        this.replay.attr({
            x:Const.w/2,
            y:buttonY,
            anchorX:0
        })
        this.addChild(this.replay);

    }


});