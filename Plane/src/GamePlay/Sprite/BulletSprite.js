/**
 * Created by lingjianfeng on 14-8-31.
 */

var BulletSprite = cc.Sprite.extend({

    active : true,
    yVelocity : 200,
    HP : 1,

    /**
     * create a Bullet
     * @param bulletSpeed
     * @param weaponType
     * @param attackMode
     */
    ctor : function(bulletSpeed, weaponType, attackMode){
        this._super("#"+weaponType);
        this.yVelocity = -bulletSpeed;
        this.attackMode = attackMode;
        this.setBlendFunc(cc.SRC_ALPHA, cc.ONE);

    },
    update:function (dt) {

//        cc.log("这里。。。");
        var y = this.y;
        this.y = y - this.yVelocity * dt;
        if (y < 0 || y > Const.h + 10 || this.HP <= 0) {
            this.destroy();
        }
    },
    destroy : function(){
        this.active = false;
        this.visible = false;
    },
    hurt:function () {
        this.HP--;
        cc.log("BulletSprite hurt ...");
    },
    collideRect:function (x, y) {
        return cc.rect(x - 3, y - 3, 6, 6);
    }
});

BulletSprite.getOrCreateBullet = function (bulletSpeed, weaponType, attackMode, zOrder, mode) {
    /**/
    var selChild = null;
    if (mode == Const.UNIT_TAG.PLAYER_BULLET) {
        for (var j = 0; j < Const.CONTAINER.PLAYER_BULLETS.length; j++) {
            selChild = Const.CONTAINER.PLAYER_BULLETS[j];
            if (selChild.active == false) {
                selChild.visible = true;
                selChild.active = true;
                selChild.HP = 1;
                return selChild;
            }
        }
    }
    else {
        for (var j = 0; j < Const.CONTAINER.ENEMY_BULLETS.length; j++) {
            selChild = Const.CONTAINER.ENEMY_BULLETS[j];
            if (selChild.active == false) {
                selChild.visible = true;
                selChild.HP = 1;
                selChild.active = true;
                return selChild;
            }
        }
    }
    selChild = BulletSprite.create(bulletSpeed, weaponType, attackMode, zOrder, mode);
    return selChild;
};

BulletSprite.create = function (bulletSpeed, weaponType, attackMode, zOrder, mode) {
    var bullet = new BulletSprite(bulletSpeed, weaponType, attackMode);

    g_GPTouchLayer.addBullet(bullet, zOrder, mode);

    if (mode == Const.UNIT_TAG.PLAYER_BULLET) {
        Const.CONTAINER.PLAYER_BULLETS.push(bullet);
    } else {
        Const.CONTAINER.ENEMY_BULLETS.push(bullet);
    }
    return bullet;
};

BulletSprite.preSet = function () {
    var bullet = null;
    for (var i = 0; i < 10; i++) {
        var bullet = BulletSprite.create(Const.BULLET_SPEED.SHIP, "W1.png", Const.ENEMY_ATTACK_MODE.NORMAL, 3000, Const.UNIT_TAG.PLAYER_BULLET);
        bullet.visible = false;
        bullet.active = false;
    }
    for (var i = 0; i < 10; i++) {
        bullet = BulletSprite.create(Const.BULLET_SPEED.ENEMY, "W2.png", Const.ENEMY_ATTACK_MODE.NORMAL, 3000, Const.UNIT_TAG.ENMEY_BULLET);
        bullet.visible = false;
        bullet.active = false;
    }
};