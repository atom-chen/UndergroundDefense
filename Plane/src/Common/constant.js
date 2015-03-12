//定义常量类

var Const = Const || {};

//获取屏幕高宽--cc.winSize

Const.h =0;

Const.w = 0;

//游戏声音
Const.SOUND_ON = false;

// 游戏状态
Const.GAME_STATE_ENUM = {
    HOME : 0,
    PLAY : 1,
    OVER : 2
}

//初始化为0
Const.GAME_STATE = Const.GAME_STATE_ENUM.HOME;

//container--容器
Const.CONTAINER = {
    ENEMIES : [],
    ENEMY_BULLETS : [],
    PLAYER_BULLETS : [],
    SPARKS : [],
    EXPLOSIONS : []

};

//bullet speed
Const.BULLET_SPEED = {
    ENEMY : -200,
    SHIP : 900
};

//attack mode
Const.ENEMY_ATTACK_MODE = {
    NORMAL : 1,
    TSUIHIKIDAN : 2
};

//unit tag
Const.UNIT_TAG = {
    ENMEY_BULLET : 900,
    PLAYER_BULLET : 901,
    ENEMY : 1000,
    PLAYER : 1000
};

//enemy move type
Const.ENEMY_MOVE_TYPE = {
    ATTACK:0,
    VERTICAL:1,
    HORIZONTAL:2,
    OVERLAP:3
};
