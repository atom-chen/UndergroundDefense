/**
 * Created by lingjianfeng on 14-8-31.
 */

var hitnum=0;//点击次数

var initGameingLayer = cc.Layer.extend({

    ctor : function(){

        this._super();

        Storeblock.length=0;//清空数组

        this.GetPosition();//生成block的坐标和颜色

        this._drawGame();//绘制游戏画面


    },

    //方块生成坐标
    GetPosition: function()
    {
        var tempY=40;//底下留白
        var i=0;
        while(tempY<275)
        {
            if(i%2)
            {
                var tempX=4+BLOCK_W;
            }
            else
                var tempX=BLOCK_W/2+4
            while((tempX+BLOCK_W/2)<Const.w)
            {
                Storeblock.push(new block(tempX,tempY,0));
                tempX=tempX+BLOCK_W;

            }
            i++;
            tempY=tempY+(Const.gene*(BLOCK_W/2));
        }



    },

    _drawGame:function()
    {
        var mimdel=parseInt(Storeblock.length/2);//中间值

        //随机生成颜色方块
        for(var i=0;i<15;i++) {
            var ram =parseInt(Math.random()*Storeblock.length);//----包含0，不含1
            if(ram!=mimdel)
                Storeblock[ram].s=1;
        }

        //精灵表绘制方块---绘制同一图片且多数量时效率高
        this.batch = new cc.SpriteBatchNode(res.Block_png);
        this.addChild(this.batch);
        for(var i=0;i<Storeblock.length;i++){
            if( Storeblock[i].s==0)
                Storeblock[i].block=new cc.Sprite(this.batch.texture,BLOCK2_RECT);
            else
                Storeblock[i].block=new cc.Sprite(this.batch.texture,BLOCK1_RECT);
            Storeblock[i].block.attr({
                x: Storeblock[i].x,
                y: Storeblock[i].y
            });
            this.batch.addChild(Storeblock[i].block);//添加到精灵表中
        }
        //方块绘制
        /*for(var i=0;i<Storeblock.length;i++) {

            if( Storeblock[i].s==0)
                Storeblock[i].block=new cc.Sprite(res.Block_png,BLOCK2_RECT);
            else
                Storeblock[i].block=new cc.Sprite(res.Block_png,BLOCK1_RECT);
            Storeblock[i].block.attr({
                x: Storeblock[i].x,
                y: Storeblock[i].y
            });
            this.addChild(Storeblock[i].block);
        }
*/
        //神经猫绘制

        var tex = cc.textureCache.addImage(res.Player_png);//把图片添加到缓存
        var moveFrames=[];//移动精灵帧
        var rect = cc.rect(0, 0, PLAYER_W, PLAYER_H);
        rect.y = PLAYER_H;
        for (var i = 0; i < 4; i++) {
            rect.x = 0 + i * PLAYER_W;
            frame = new cc.SpriteFrame(tex, rect);//一定要rect。。不然会报错
            moveFrames.push(frame);
        }

        this.player = new cc.Sprite(moveFrames[0]);
        this.player.attr({
            anchorX : 0.5,
            anchorY : 0.16,
            x : Storeblock[mimdel].x,
            y : Storeblock[mimdel].y
        });
        this.addChild(this.player,5);

        var animation = new cc.Animation(moveFrames, 0.2);
        var animate = cc.animate(animation);
        var action = animate.repeatForever();//永远执行
        this.player.runAction(action);

    }


});