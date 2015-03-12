//定义常量类

var Const = Const || {};

//获取屏幕高宽--cc.winSize

Const.h =0;

Const.w = 0;

//游戏声音
Const.SOUND_ON = false;


//根号3
Const.gene=1.73205;



// 游戏状态
Const.GAME_STATE_ENUM = {
    WIN : 0,
    PLAY : 1,
    OVER : 2,
    SHARE: 3
};

//记录游戏状态--初始化为1
Const.GAME_STATE = Const.GAME_STATE_ENUM.PLAY;
