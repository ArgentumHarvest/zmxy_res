package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import base.BasePet;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.bullet.StabBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   import user.User;
   
   public class Monster33 extends BaseMonster
   {
       
      
      private var isNotArrow:Boolean = false;
      
      private var role4Hit5:MonsterRole4Hit5;
      
      private var gxpCount:uint = 0;
      
      private var mm:MusicManager;
      
      private var shallowCount:uint = 4;
      
      public function Monster33()
      {
         super();
         mm = MusicManager.getInstance();
         this.horizenSpeed = 8;
         this.setHp(9000 + 0.5720000000000001 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.setSHp(9000 + 0.5720000000000001 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.normalAttackRate = 0.25;
         this.attackRange = 250;
         this.alertRange = 1000;
         this.normalAttackRate = 0.8;
         this._anti.def = 56 + gc.hero1.roleProperies.getDefense();
         this._anti.mDef = 0.2;
         this.gxpCount = gc.frameClips * 10;
         this._anti.exp = 500;
         this._anti.gxp = 200;
         var baseHurt:uint = gc.hero1.roleProperies.getHurt() * 0.9 + 120;
         this._anti.def = 0;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-3],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-2],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":4,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-30,-2],
            "attackInterval":gc.frameClips,
            "power":baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit8_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-22],
            "attackInterval":2,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[10,-4],
            "attackInterval":8,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-4],
            "attackInterval":7,
            "power":baseHurt * 1.5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-5],
            "attackInterval":7,
            "power":baseHurt * 0.5,
            "attackKind":"magic"
         };
         if(gc.curStageAndCurLevel.curStage != 60)
         {
            this.isBoss = true;
            this.monsterName = "邪.八戒";
         }
         this.setAction("wait");
         this._anti.fallProbability = 0.9;
         var kind:int = Math.ceil(RandomControllor.getIns().getRandom() * 4);
         this._anti.fallList = [{
            "name":"wpqhs1",
            "bigtype":"dj"
         },{
            "name":"lssp_" + kind,
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 6];
      }
      
      override public function doWhenStage13(hp:uint, def:uint, mDef:Number, mAtk:uint, exp:uint, round:uint) : void
      {
         super.doWhenStage13(hp,def,mDef,mAtk,exp,round);
         var baseHurt:uint = mAtk + mAtk * (0.25 * (round - 1));
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-3],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-2],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":4,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-30,-2],
            "attackInterval":gc.frameClips,
            "power":baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit8_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-22],
            "attackInterval":2,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[10,-4],
            "attackInterval":8,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-4],
            "attackInterval":7,
            "power":baseHurt * 1.5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-5],
            "attackInterval":7,
            "power":baseHurt * 0.5,
            "attackKind":"magic"
         };
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster33");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,200,new Point(0,0));
            bbdc.setOffsetXY(-15,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[3,3,3,9,5,9],[4,4,4,4],[2,2,2,2],[1,1,8,6,2,160],[2,2,2,2,2],[2,2,6],[2,2,6],[2,2,2,10],[24,2,8],[2,2,20],[2,2,2,20],[2,2,2,20],[4,3,25]]);
            bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,4,3,3,4,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster33--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         str = str;
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
            case "wait2":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               this.setAction("run");
               break;
            case "run":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "jump1":
               if(curPoint.x != 0 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "jump2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "jump3":
               if(curPoint.x != 1 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(str);
               break;
            case "hit11":
               if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11Frame2":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               this.bbdc.show();
               break;
            case "dead":
               this.setStatic();
               TweenMax.to(this,1,{
                  "alpha":0,
                  "onComplete":function(_self:BaseMonster):*
                  {
                     _self.dropAura();
                     _self.destroy();
                  },
                  "onCompleteParams":[this]
               });
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
               break;
            case "jump1":
               this.bbdc.setFramePointX(0);
               break;
            case "jump2":
               this.setAction("jump3");
               break;
            case "jump3":
               this.bbdc.setFramePointX(1);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               this.setAction("wait");
               break;
            case "hit7":
               this.setAction("wait");
               break;
            case "hit8":
               this.setAction("wait");
               break;
            case "hit9":
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("hit11Frame2");
               break;
            case "hit11Frame2":
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.getBBDC().show();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 130;
                     }
                     else
                     {
                        point.x = this.x + 130;
                     }
                     point.y = this.y - 72;
                     this.doHit1(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit2":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 140;
                     }
                     else
                     {
                        point.x = this.x + 140;
                     }
                     point.y = this.y - 30;
                     this.doHit2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit3":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 180;
                     }
                     else
                     {
                        point.x = this.x + 180;
                     }
                     point.y = this.y - 140;
                     this.doHit3(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit4":
               if(this.bbdc.getCurFrameCount() == 24)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 35;
                     }
                     else
                     {
                        point.x = this.x + 35;
                     }
                     point.y = this.y - 55;
                     this.doHit4(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit5":
               if(this.bbdc.getCurFrameCount() == 160)
               {
                  if(p.x == 5)
                  {
                     this.bbdc.setCurFrameCount(4);
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 70;
                     }
                     else
                     {
                        point.x = this.x + 70;
                     }
                     point.y = this.y - 110;
                     this.doHit5(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit6":
               if(this.bbdc.getCurFrameCount() == 6)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 120;
                     }
                     else
                     {
                        point.x = this.x + 120;
                     }
                     point.y = this.y - 115;
                     this.doHit6(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 140;
                     }
                     else
                     {
                        point.x = this.x + 140;
                     }
                     point.y = this.y - 160;
                     this.doHit7_1(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getCurFrameCount() == 8)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 135;
                     }
                     else
                     {
                        point.x = this.x + 135;
                     }
                     point.y = this.y - 145;
                     this.doHit7_2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit8":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 95;
                     }
                     else
                     {
                        point.x = this.x + 95;
                     }
                     point.y = this.y;
                     this.doHit8_1(this.getBBDC().getDirect(),point);
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x + 20;
                     }
                     else
                     {
                        point.x = this.x - 20;
                     }
                     point.y = this.y - 20;
                     this.doHit8_2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit9":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 195;
                     }
                     else
                     {
                        point.x = this.x + 195;
                     }
                     point.y = this.y - 160;
                     this.doHit9(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit10":
               if(this.bbdc.getCurFrameCount() == 25)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 55;
                     }
                     else
                     {
                        point.x = this.x + 55;
                     }
                     point.y = this.y - 25;
                     this.doHit10(this.getBBDC().getDirect(),point);
                  }
               }
               if(p.x == 2)
               {
                  if(this.getBBDC().getDirect() == 0)
                  {
                     this.speed.x = -15;
                  }
                  else
                  {
                     this.speed.x = 15;
                  }
               }
               break;
            case "hit11Frame2":
               if(this.bbdc.getCurFrameCount() == 160)
               {
                  if(p.x == 5)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 135;
                     }
                     else
                     {
                        point.x = this.x + 135;
                     }
                     point.y = this.y - 90;
                     this.doHit11(this.getBBDC().getDirect(),point);
                     this.bbdc.setCurFrameCount(28);
                  }
               }
               this.getBBDC().hide();
               break;
            case "hit12":
               if(this.bbdc.getCurFrameCount() == 160)
               {
                  if(p.x == 5)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y;
                     this.doHit12_1(this.getBBDC().getDirect(),point);
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 150)
               {
                  this.getBBDC().hide();
               }
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit4");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit5");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.curAddEffect)
         {
            this.curAddEffect.add([{
               "name":BaseAddEffect.BAJIE_DUNPAI_BUFF,
               "time":gc.frameClips * 10
            }]);
         }
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role3_hit6");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var bmLen:uint = gc.getPlayerArray().length;
         for(var i:uint = 0; i < bmLen; )
         {
            var bo:BaseObject = gc.getPlayerArray()[i] as BaseObject;
            bo.setLostGraity();
            TweenMax.to(bo,1,{
               "x":this.x,
               "y":this.y - 40,
               "onComplete":function(_bo:BaseObject):*
               {
                  _bo.resetGraity();
               },
               "onCompleteParams":[bo]
            });
            i++;
         }
      }
      
      private function doHit7_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit7");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet7_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet7_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet8_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet8_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit9");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet9");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit10");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet10");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit11(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit11");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet11");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit12_1");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet12_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit12");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_2(direct:*, point:*, targetPoint:Point = null, stabNum:uint = 10) : void
      {
         var stab:* = null;
         var source:* = null;
         var i:int = 0;
         var rota:Number = NaN;
         mm.play("Role3_hit12_2");
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role3Bullet12_1")
            {
               if(bb.getImgMc())
               {
                  bb.getImgMc().gotoAndPlay(140);
               }
            }
         }
         stabNum = 10;
         if(this.isGXP)
         {
            stabNum = 20;
         }
         var randObject:BaseObject = gc.getPlayerArray()[int(RandomControllor.getIns().getRandom() * gc.getPlayerArray().length)] as BaseObject;
         if(randObject)
         {
            targetPoint = !!randObject ? new Point(randObject.x,randObject.y) : new Point(this.x + 1,this.y + 300);
            for(i = 0; i < stabNum; )
            {
               rota = 360 / stabNum * i;
               source = new Point(point.x + Math.sin(rota * 3.141592653589793 / 180) * 100,point.y - Math.cos(rota * 3.141592653589793 / 180) * 100);
               stab = new StabBullet("Role3Bullet12_2",targetPoint,1,source);
               stab.setRole(this);
               stab.setDestroyWhenLastFrame(false);
               stab.setAction("hit12");
               stab.rotation = rota;
               stab.x = source.x;
               stab.y = source.y;
               gc.gameSence.addChild(stab);
               this.magicBulletArray.push(stab);
               i++;
            }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         var skillArray:Array = ["hit9","hit10","hit11","hit12"];
         if(!this.curAddEffect.getBuffByName(BaseAddEffect.BAJIE_DUNPAI_BUFF))
         {
            skillArray.push("hit5");
         }
         var randSkil:String = skillArray[int(RandomControllor.getIns().getRandom() * skillArray.length)];
         trace("释放技能：" + randSkil);
         this.faceToTarget();
         this.setYourFather(10);
         this.setAction(randSkil);
         this.lastHit = randSkil;
         if(randSkil == "hit12")
         {
            TweenMax.delayedCall(2,function(_self:Monster33):*
            {
               if(!_self.isDead())
               {
                  _self.getBBDC().setCurFrameCount(20);
                  _self.doHit12_2(_self.getBBDC().getDirect(),new Point(_self.x,_self.y));
               }
            },[this]);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(this.isGXP)
         {
            if(this.shallowCount > 0)
            {
               this.shallowCount--;
            }
            if(this.shallowCount == 0)
            {
               AUtils.shallowEffect(this);
               this.shallowCount = 4;
            }
         }
         if(this.gxpCount > 0)
         {
            this.gxpCount--;
            if(this.gxpCount == 0)
            {
               this.turnToGXP();
               this.gxpCount = gc.frameClips * 20;
               TweenMax.delayedCall(10,function(_self:Monster33):*
               {
                  _self.turnToNormal();
               },[this]);
            }
         }
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override protected function turnToGXP() : void
      {
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
      }
      
      protected function turnToNormal() : void
      {
         this.isGXP = false;
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var curBuff:* = null;
         var obj:* = null;
         var point:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         var hurt:int = 0;
         var isCrit:Boolean = false;
         var dis:Number = NaN;
         var lastint:int = 0;
         var eb:* = 0;
         var cureHpValue:* = 0;
         var eb2:Number = NaN;
         cureHpValue = 0;
         if(this.isYourFather())
         {
            return false;
         }
         if(force || this.colipse && AUtils.testIntersects(this.colipse,_target,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,_target))
         {
            if(RandomControllor.getIns().getRandom() < this.getMiss())
            {
               this.addMissMc();
               this.beAttackIdArray.push(_target.getAttackId());
               return false;
            }
            curBuff = this.curAddEffect.getBuffByName(BaseAddEffect.FLUTE_SLEEP);
            if(curBuff)
            {
               curBuff.time = 1;
            }
            User.batterNum++;
            this.curAttackTarget = sr;
            obj = _target.sourceRoleAttackInfoObject;
            if(obj)
            {
               point = this.getBeattackBackSpeed(_target,obj);
               if(_target.getImcName() != "Role1Bullet12")
               {
                  this.setAttackBack(point);
               }
               if(obj.addEffect)
               {
                  arr = AUtils.clone(obj.addEffect) as Array;
                  for(i = uint(0); i < arr.length; )
                  {
                     o = arr[i];
                     if(o.time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                     {
                        o.time = _target.getFrameLeft();
                     }
                     i++;
                  }
                  this.addCurAddEffect(arr);
               }
            }
            hurt = _target.hurt;
            isCrit = _target.isCrit;
            if(_target.getImcName() == "Role1Bullet12")
            {
               trace("--火眼晶晶--");
               dis = AUtils.GetDisBetweenTwoObj(this,sr);
               if(dis > 1000)
               {
                  dis = 1000;
               }
               hurt *= (1000 - dis) / 1000;
            }
            lastint = this.getRealHurt(hurt,obj);
            if(this.curAction == "hit12")
            {
               trace("反弹");
               if(sr is BaseHero)
               {
                  BaseHero(sr).reduceHp(hurt);
               }
            }
            if(sr is BaseHero)
            {
               if(obj && obj.attackKind == "physics")
               {
                  eb = uint(BaseHero(sr).roleProperies.getEatBlood());
                  cureHpValue = uint(int(eb / 100 * lastint));
                  if(cureHpValue > 0)
                  {
                     BaseHero(sr).cureHp(cureHpValue);
                  }
               }
            }
            else if(sr is BasePet)
            {
               if(obj && obj.attackKind == "physics")
               {
                  eb2 = BasePet(sr).petInfo.getEatBlood();
                  cureHpValue = uint(int(eb2 * lastint));
                  if(cureHpValue > 0)
                  {
                     BasePet(sr).cureHp(cureHpValue);
                  }
               }
            }
            if(RandomControllor.getIns().getRandom() <= 0.1)
            {
               this.cureHp(this.getSHp() * 0.001);
            }
            if(_target.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(lastint,false);
            }
            else
            {
               this.reduceHp(lastint,true);
            }
            this.showHpSlip();
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[hurt,this.curAttackTarget]));
            this.addBeAttackEffect(sr);
            mm.play("BeattackByRole1");
            return true;
         }
         return false;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12")
         {
            canHurt = false;
         }
         if(this.isGXP)
         {
            re *= 0.5;
         }
         super.reduceHp(re,canHurt);
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12"))
         {
            super.setAttackBack(p);
         }
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && this.getJumpCount() == 0 || this.curAction == "hit4" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit5" || this.curAction == "hit10";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(gc.curStageAndCurLevel.curStage == 4)
         {
            if(this.getHp() <= 0)
            {
               gc.bossChallenge[1] = 1;
            }
         }
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
