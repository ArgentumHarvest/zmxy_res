package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener171Children.Monster104Hand;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster104 extends BaseMonster
   {
       
      
      private var m104BG:Bitmap;
      
      private var leftHand:Monster104Hand;
      
      private var rightHand:Monster104Hand;
      
      private var leftEye:MovieClip;
      
      private var rightEye:MovieClip;
      
      public function Monster104()
      {
         super();
         this.horizenSpeed = 0;
         this.normalAttackRate = 0.4;
         this._anti.def = 0;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.power = 40;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":800,
            "attackKind":"magic"
         };
         this.attackRange = 2000;
         this.alertRange = 2000;
         this.isFly = false;
         this.graity = 0;
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.setAction("wait");
         this._anti.fallProbability = 1;
         this._anti.fallList = [{
            "name":"ttlpsp1",
            "bigtype":"dj"
         }];
         this.skillCD1 = [[gc.frameClips * 3],[gc.frameClips * 6]];
         this.hide();
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster104");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(9,-15);
            bbdc.setFrameStopCount([[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]);
            bbdc.setFrameCount([20]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster104--BitmapData Error!");
      }
      
      private function show() : void
      {
         this.visible = true;
         TweenMax.delayedCall(10,function(_self:Monster104):*
         {
            _self.hide();
         },[this]);
      }
      
      private function hide() : void
      {
         this.setYourFather(gc.frameClips * 10);
         this.visible = false;
         TweenMax.delayedCall(10,function(_self:Monster104):*
         {
            _self.show();
         },[this]);
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster104ObjectSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.m104BG = AUtils.getImageObj("Monster104BG") as Bitmap;
         this.m104BG.x = this.x - 470;
         this.m104BG.y = this.y - 315;
         var idx1:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(this.m104BG,idx1);
         this.leftHand = new Monster104Hand(Monster104Hand.LEFT_HAND);
         this.leftHand.x = this.x - 200;
         this.leftHand.y = this.y - 50;
         this.leftHand.addEventListener("attack",__doAttack);
         gc.gameSence.addChild(this.leftHand);
         this.rightHand = new Monster104Hand(Monster104Hand.RIGHT_HAND);
         this.rightHand.x = this.x + 200;
         this.rightHand.y = this.y - 50;
         this.rightHand.addEventListener("attack",__doAttack);
         gc.gameSence.addChild(this.rightHand);
         this.rightEye = AUtils.getNewObj("Monster104Eyes") as MovieClip;
         this.rightEye.x = this.x + 15;
         this.rightEye.y = this.y - 170;
         gc.gameSence.addChild(this.rightEye);
         this.leftEye = AUtils.getNewObj("Monster104Eyes") as MovieClip;
         this.leftEye.x = this.x - 45;
         this.leftEye.y = this.y - 170;
         AUtils.flipHorizontal(this.leftEye,-1);
         gc.gameSence.addChild(this.leftEye);
      }
      
      private function __doAttack(evt:Event) : void
      {
         var target:Monster104Hand = evt.target as Monster104Hand;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster104Bullet1");
         b.setRole(this);
         b.setFollowDisplayObj(target);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(36);
         b.setDirect(0);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function setAction(str:String) : void
      {
         str = str;
         if(str != "dead" && str != "wait")
         {
            var str:String = "wait";
         }
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.dropAura();
               this.destroy();
               if(this.m104BG)
               {
                  TweenMax.to(this.m104BG,1,{
                     "alpha":0,
                     "onComplete":function(_bm:Bitmap):*
                     {
                        _bm = null;
                     },
                     "onCompleteParams":[this.m104BG]
                  });
               }
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "dead":
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         state;
      }
      
      override protected function turnLeft() : *
      {
      }
      
      override protected function turnRight() : *
      {
      }
      
      override protected function move() : void
      {
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         var i:* = 0;
         var nums:uint = 2 + RandomControllor.getIns().getRandom() * 4;
         for(i = uint(0); i < nums; )
         {
            this.doHit2_1();
            i++;
         }
      }
      
      private function doHit2_1() : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster104Bullet2_1");
         b.x = 100 + RandomControllor.getIns().getRandom() * 800;
         b.y = 500;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit2");
         b.setDisable();
         b.setFuncWhenDestroy(doHit2_2);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = bb.x;
         b.y = bb.y;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(this.leftHand)
         {
            this.leftHand.step();
         }
         if(this.rightHand)
         {
            this.rightHand.step();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.leftHand)
         {
            this.leftHand.removeEventListener("attack",__doAttack);
            this.leftHand.destroy();
            this.leftHand = null;
         }
         if(this.rightHand)
         {
            this.rightHand.removeEventListener("attack",__doAttack);
            this.rightHand.destroy();
            this.rightHand = null;
         }
         if(this.leftEye)
         {
            this.leftEye.parent.removeChild(this.leftEye);
            this.leftEye = null;
         }
         if(this.rightEye)
         {
            this.rightEye.parent.removeChild(this.rightEye);
            this.rightEye = null;
         }
         if(this.getHp() <= 0)
         {
            if(this.isBoss)
            {
               var ta:Array = gc.pWorld.getTransferDoorArray();
               for(var i:int = 0; i < ta.length; )
               {
                  var mc:MovieClip = ta[i];
                  mc.visible = true;
                  i++;
               }
            }
            TweenMax.delayedCall(5,function(_self:Monster104):*
            {
               _self.callMonster105();
            },[this]);
         }
      }
      
      private function callMonster105() : void
      {
         var i:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            mc = ta[i];
            mc.visible = false;
            i++;
         }
         MainGame.getInstance().createMonster(105,600,300);
      }
   }
}
