/**
 * Created by lingjianfeng on 14-8-31.
 */

var ABBackgroundLayer = cc.Layer.extend({

    ctor : function(){

        this._super();

        this.initBackground();
    },

    initBackground : function(){

        this._sptBg = cc.Sprite.create(res.mm_bg_png);
        this._sptBg.attr({
            x: Const.w/2,
            y: Const.h/2
        });
        this.addChild(this._sptBg);
    }
});
