package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster3 extends BaseMonster
   {
       
      
      public function Monster3()
      {
         super();
         this.horizenSpeed = 3;
         this.setHp(160);
         this.setSHp(160);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 6;
         this._anti.exp = 7;
         this._anti.gxp = 4;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":14,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "power":7,
            "attackKind":"magic"
         };
         if(gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel == 1)
         {
            this.isBoss = true;
            this.monsterName = "巫鹰";
         }
         else
         {
            this.isBoss = false;
         }
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 3];
         this._anti.fallList = [];
         if(this.isBoss)
         {
            this._anti.fallProbability = 1;
            if(gc.player1.roleid > 0)
            {
               this.addEquipByRoleId(gc.player1.roleid);
            }
            if(gc.player2.roleid > 0)
            {
               this.addEquipByRoleId(gc.player2.roleid);
            }
         }
         else
         {
            this._anti.fallProbability = 0.05;
            this._anti.fallList = [{
               "name":"wptm",
               "bigtype":"dj"
            },{
               "name":"wpxt",
               "bigtype":"dj"
            },{
               "name":"wpsc",
               "bigtype":"dj"
            }];
         }
      }
      
      private function addEquipByRoleId(roleId:uint) : void
      {
         var arr:Array = this._anti.fallList;
         switch(int(roleId) - 1)
         {
            case 0:
               arr.push({
                  "name":"ptdxzg",
                  "bigtype":"zb"
               },{
                  "name":"ptdxzf",
                  "bigtype":"zb"
               });
               break;
            case 1:
               arr.push({
                  "name":"ptdcz",
                  "bigtype":"zb"
               },{
                  "name":"ptdjs",
                  "bigtype":"zb"
               });
               break;
            case 2:
               arr.push({
                  "name":"ptddp",
                  "bigtype":"zb"
               },{
                  "name":"ptdcs",
                  "bigtype":"zb"
               });
               break;
            case 3:
               arr.push({
                  "name":"ptdyyc",
                  "bigtype":"zb"
               },{
                  "name":"ptdcp",
                  "bigtype":"zb"
               });
         }
         this._anti.fallList = arr;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster3");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],180,180,new Point(0,0));
            bbdc.setOffsetXY(20,-5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[5],[2,2,2,2,2,5],[2,2,2,1,1,7],[2,2,1,26]]);
            bbdc.setFrameCount([6,4,1,6,6,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster3--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
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
            case "walk":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 26)
                  {
                     this.doHi2(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster3Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 105;
         }
         else
         {
            b.x = this.x + 105;
         }
         b.y = this.y - 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster3Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.isBoss)
         {
            ta = gc.pWorld.getTransferDoorArray();
            for(i = 0; i < ta.length; )
            {
               mc = ta[i];
               mc.visible = true;
               i++;
            }
         }
      }
   }
}
