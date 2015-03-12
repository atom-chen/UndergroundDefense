
//自定义block类
var block=function(x,y,s)
{
    this.x=x;//x坐标
    this.y=y;//y坐标
    this.s=s;//block颜色，1为红

}

var BLOCK_W = 32;
var BLOCK_H = 36;

var PLAYER_W = 66;
var PLAYER_H = 118;

var BLOCK1_RECT = cc.rect(0, 0, BLOCK_W, BLOCK_H);

var BLOCK2_RECT = cc.rect(BLOCK_W, 0, BLOCK_W, BLOCK_H);

//定义存放block数组
var Storeblock = new Array()


var GameingLayer = cc.Layer.extend({
    player:null,

    _success:null,
    ctor:function () {
        //////////////////////////////
        // 1. super init first
        this._super();



        this.DrawGame();

        //定时器。。监听游戏状态
        //this.schedule(this.listAction, 1/6);
        /* listAction:function(dt)//dt就是时间1/6s
         {

         }
         }*/

        //取消定时器
        //this.unschedule(this.listAction,1/6);

        //屏幕点击监听
        cc.eventManager.addListener({
            event: cc.EventListener.TOUCH_ALL_AT_ONCE,
            onTouchesEnded: this.hit   //触屏函数
        }, this);


        return true;
    },

    //分享页面
    Share:function()
    {
        this.share=new ShareLayer();
        this.addChild(this.share,10);
    },

    DrawGame:function(){


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


        //绘制方块和神经猫
        this.initLayer = new initGameingLayer();
        this.addChild(this.initLayer, 2);

    },


    /**
     * 触屏函数里面不能用this。。用 var target = event.getCurrentTarget();//获取当前对象代替
     * @param touches
     * @param event
     */
    hit:function (touches, event) {
        var target = event.getCurrentTarget();//获取当前对象
        var touch = touches[0];
        //获取点击的坐标
        var pos = touch.getLocation();

        //游戏中
        if(Const.GAME_STATE==Const.GAME_STATE_ENUM.PLAY) {
            for (var i = 0; i < Storeblock.length; i++) {
                var Isin = ((pos.x - Storeblock[i].x) * (pos.x - Storeblock[i].x)) + ((pos.y - Storeblock[i].y) * (pos.y - Storeblock[i].y)) - (BLOCK_W / 2 * BLOCK_W / 2);

                //点中灰色方块
                if (Isin <= 0 && Storeblock[i].s == 0) {

                    //处理函数
                    target.change(i);//this.change(i)会报错 --

                    break;
                }
            }
        }

        //游戏胜利
        else if(Const.GAME_STATE==Const.GAME_STATE_ENUM.WIN)
        {
            //通知好友按钮
            if(pos.x>(Const.w/2-buttonW)&&pos.x<(Const.w/2-10)&&pos.y>(buttonY-buttonH/2)&&pos.y<(buttonY+buttonH/2))
            {


                Const.GAME_STATE=Const.GAME_STATE_ENUM.SHARE;//分享状态

                target.Share();

            }

            //再来一局按钮
            if(pos.x<(Const.w/2+buttonW)&&pos.x>(Const.w/2+5)&&pos.y>(buttonY-buttonH/2)&&pos.y<(buttonY+buttonH/2))
            {
                //target代替this
                cc.log("Again");
                //移去场景
               /* target._success.removeFromParent();
                target.initLayer.removeFromParent();
                for(var i=0;i<Storeblock.length;i++) {

                    Storeblock[i].block.removeFromParent();
                }*/
                target.removeAllChildren();//直接移除所有节点


                //重新开始
                target.DrawGame();

                //更改游戏状态
                Const.GAME_STATE=Const.GAME_STATE_ENUM.PLAY;

            }
        }

        else if(Const.GAME_STATE==Const.GAME_STATE_ENUM.SHARE)
        {
            target.share.removeFromParent();//移除
            Const.GAME_STATE=Const.GAME_STATE_ENUM.WIN;
        }


    },


    change:function(i){

        Storeblock[i].s=1;
        Storeblock[i].block.removeFromParent();//移除方块
        Storeblock[i].block = new cc.Sprite(res.Block_png, BLOCK1_RECT);
        Storeblock[i].block.attr({
            x: Storeblock[i].x,
            y: Storeblock[i].y
        });
        this.addChild(Storeblock[i].block, 1);

        if (hitnum < 3) {
            while (true) {

                //this.initLayer.player.x可以多层调用
                var ram = parseInt(Math.random() * Storeblock.length);//----包含0，不含1
                if (Storeblock[ram].s == 0&&Storeblock[ram].x!=this.initLayer.player.x) {
                    this.initLayer.player.x = Storeblock[ram].x;
                    this.initLayer.player.y = Storeblock[ram].y;
                    hitnum++;
                    break;
                }
            }

        }
        else {

            hitnum = 0;
            //添加成功layer
            this._success = new SuccessLayer();
            this.addChild(this._success, 4);
            //游戏胜利
            Const.GAME_STATE=Const.GAME_STATE_ENUM.WIN;
        }
    }


});

var GameingSence = cc.Scene.extend({
    onEnter:function () {
        this._super();
        var layer = new GameingLayer();
        this.addChild(layer);
    }
});

