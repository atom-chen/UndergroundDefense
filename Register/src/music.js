
var MusicLayer = cc.Layer.extend({

    //构造函数
    ctor:function () {
        this._super();

        this.initUI();
        //播放音乐
        this.playBgMusic();

        return true;
    },

    initUI:function()
    {

        //向上的箭头
        this.test=new cc.Sprite("#arrow.png");
        this.test.attr({
            x:Const.w/2,
            y:5,
            anchorY : 0
        });
        var action=cc.spawn(cc.moveBy(1,cc.p(0,40)),cc.fadeOut(1));
        var seqaction=cc.sequence(action,cc.delayTime(0.5),cc.callFunc(function()
        {
            this.test.y=5;
            this.test.opacity=255;//显示箭头
        },this)).repeatForever();//永远执行
        this.test.runAction(seqaction,2);
        this.addChild(this.test);


        this.music=new cc.MenuItemToggle(
            // new cc.Sprite("#music.png")错误
            //变化的文字用--- new cc.MenuItemFont("On"),
            new cc.MenuItemImage("#music.png"),
            new cc.MenuItemImage("#music_sel.png")
        );
        //        设置函数回调
        this.music.setCallback(this.MusicCallback );
        //设置显示图片
        //（条件表达式）？（条件为真时的表达式）：（条件为假时的表达式）
        this.music.setSelectedIndex(Const.SOUND_ON ? 0 : 1);//文字显示选择--0.1下标
        var menu = new cc.Menu(this.music);
        menu.x=Const.w-this.music.width;
        menu.y=logoY;
        this.addChild(menu);

    },

    MusicCallback:function()
    {
        Const.SOUND_ON = !Const.SOUND_ON;
        cc.log(Const.SOUND_ON);
        if(Const.SOUND_ON)
        {
            if (cc.audioEngine.isMusicPlaying()){
                return;
            }
            cc.audioEngine.playMusic(res.bg_music_mp3, true);
        }
        else
        {
            cc.audioEngine.stopMusic();//背景音乐
        }
    },


    playBgMusic:function(){

        if (Const.SOUND_ON){
            if (cc.audioEngine.isMusicPlaying()){
                return;
            }
            cc.audioEngine.playMusic(res.bg_music_mp3, true);
        }

    }
});
