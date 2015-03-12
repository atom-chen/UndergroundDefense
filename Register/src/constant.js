//定义常量类
var Const = Const || {};

//获取屏幕高宽--cc.winSize

Const.h =0;

Const.w = 0;

Const.centre=0;//中心点

//游戏声音
Const.SOUND_ON = false;

//换页最低y轴滑动距离
Const.dy=40;

// 游戏状态
Const.GAME_STATE_ENUM = {
    first : 1,
    second :2,
    third : 3
};
//记录游戏状态--初始化为1
Const.GAME_STATE = Const.GAME_STATE_ENUM.first
