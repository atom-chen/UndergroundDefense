/**
 * Created by lingjianfeng on 14-8-31.
 */

var GamePlayLayer = cc.Layer.extend({

    _backgroundLayer : null,
    _touchLayer : null,
    ctor : function(){
        this._super();

        this.addCache();//        将plist添加到缓存

        this.addBackgroundLayer();//背景

        this.addTouchLayer();//控制层--难点
    },

    //        将plist添加到缓存
    addCache : function(){

//        将plist添加到缓存
        cc.spriteFrameCache.addSpriteFrames(res.gp_TextureOpaquePack_plist);
        cc.spriteFrameCache.addSpriteFrames(res.gp_b01_plist);
        cc.spriteFrameCache.addSpriteFrames(res.gp_Explosion_plist);
    },


    addBackgroundLayer : function(){
        this._backgroundLayer = new GPBackgroundLayer();
        this.addChild(this._backgroundLayer);
    },
    addTouchLayer : function(){
        this._touchLayer = new GPTouchLayer();
        this.addChild(this._touchLayer);
    }
});

var GamePlayScene  = cc.Scene.extend({
    onEnter:function () {
        this._super();

        var layer = new GamePlayLayer();
        this.addChild(layer);

    }
});