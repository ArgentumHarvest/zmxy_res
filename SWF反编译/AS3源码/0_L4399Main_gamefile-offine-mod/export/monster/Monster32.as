package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   
   public class Monster32 extends BaseMonster
   {
       
      
      private var isNotArrow:Boolean = false;
      
      private var role4Hit5:MonsterRole4Hit5;
      
      private var gxpCount:uint = 0;
      
      private var mm:MusicManager;
      
      private var shallowCount:uint = 4;
      
      public function Monster32()
      {
         super();
         mm = MusicManager.getInstance();
         this.horizenSpeed = 8;
         this.setHp(6000 + 0.44 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.setSHp(6000 + 0.44 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.normalAttackRate = 0.25;
         this.attackRange = 250;
         this.alertRange = 1000;
         this.normalAttackRate = 0.8;
         this._anti.def = 28 + gc.hero1.roleProperies.getDefense();
         this._anti.mDef = 0.2;
         var baseHurt:uint = gc.hero1.roleProperies.getHurt() * 0.6 + 80;
         this.gxpCount = gc.frameClips * 10;
         this._anti.exp = 500;
         this._anti.gxp = 200;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[2,-3],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1Arrow"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
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
         this.attackBackInfoDict["hit2Arrow"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":12,
            "power":baseHurt * 1.2,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit4Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":999,
            "power":baseHurt * 1.2,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 0.5,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":gc.hero1.roleProperies.getSHHP() * 0.005
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-25],
            "attackInterval":999,
            "power":baseHurt * 0.75,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "power":baseHurt * 0.75,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":8,
            "power":baseHurt * 4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":999,
            "power":baseHurt * 4,
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
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":20,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12Arrow"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":10,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "邪.沙僧";
         this.setAction("wait");
         this._anti.fallProbability = 1;
         var kind:int = Math.ceil(RandomControllor.getIns().getRandom() * 4);
         this._anti.fallList = [{
            "name":"lssp_" + kind,
            "bigtype":"dj"
         },{
            "name":"sms1",
            "bigtype":"dj"
         },{
            "name":"fys1",
            "bigtype":"dj"
         },{
            "name":"gjs1",
            "bigtype":"dj"
         },{
            "name":"mfs1",
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
            "attackBackSpeed":[2,-3],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1Arrow"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
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
         this.attackBackInfoDict["hit2Arrow"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":7,
            "power":baseHurt * 1,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":12,
            "power":baseHurt * 1.2,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit4Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-3],
            "attackInterval":999,
            "power":baseHurt * 1.2,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 8,
               "power":10
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 0.5,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 4,
               "power":gc.hero1.roleProperies.getSHHP() * 0.005
            },{
               "name":BaseAddEffect.POISON_TIMES,
               "time":gc.frameClips * 8
            }]
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-2],
            "attackInterval":999,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-25],
            "attackInterval":999,
            "power":baseHurt * 0.75,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "power":baseHurt * 0.75,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":8,
            "power":baseHurt * 4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10Arrow"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-2],
            "attackInterval":999,
            "power":baseHurt * 4,
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
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":20,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12Arrow"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,-2],
            "attackInterval":10,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster32");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(15,-13);
            if(this.isNotArrow)
            {
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,6,10,4],[2,2,2,2,2],[2,2,6],[2,2,11],[1,1,1,2],[2,19],[2,2,30],[2,2,2,15],[2,2,16],[2,2,14]]);
               bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,12,2,3,4,3,3]);
            }
            else
            {
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,13,2,24],[4,4,4,4],[2,2,2,2],[1,1,8,10,20,4],[2,2,2,2,2],[2,2,1,1,12],[2,2,2,2,2,10],[2,4,1,1,10],[2,2,30],[2,2,1,1,12],[2,2,2,2,2,20],[2,7,1,1,25],[2,18,2,2,2,24]]);
               bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,5,6,5,3,5,6,5,6]);
            }
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster32--BitmapData Error!");
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
               if(this.isNotArrow)
               {
                  if(curPoint.y != 6)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(6);
                  }
               }
               else if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 7)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(7);
                  }
               }
               else if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 8)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(8);
                  }
               }
               else if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 9)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(9);
                  }
               }
               else if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(curPoint.x != 4 || curPoint.y != 4)
                  {
                     this.bbdc.setFramePointX(4);
                     this.bbdc.setFramePointY(4);
                  }
               }
               else if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 11)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(11);
                  }
               }
               else if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 12)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(12);
                  }
               }
               else if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(curPoint.y != 10)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(10);
                  }
               }
               else if(curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit11":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
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
               this.setStatic();
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
               this.speed.y = 0;
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("wait");
               break;
            case "hit11Frame2":
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var target:* = null;
         var minDis:* = NaN;
         var dis:Number = NaN;
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 20;
                        }
                        else
                        {
                           point.x = this.x + 20;
                        }
                        point.y = this.y + 30;
                        this.doHit1(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 90;
                     }
                     else
                     {
                        point.x = this.x + 90;
                     }
                     point.y = this.y;
                     this.doHit1Arrow(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit2":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 15;
                        }
                        else
                        {
                           point.x = this.x + 15;
                        }
                        point.y = this.y;
                        this.doHit2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 90;
                     }
                     else
                     {
                        point.x = this.x + 90;
                     }
                     point.y = this.y;
                     this.doHit1Arrow(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit3":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 0)
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
                        this.doHit3(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.getBBDC().getDirect() == 0)
                  {
                     this.speed.x = -8;
                  }
                  else
                  {
                     this.speed.x = 8;
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 115;
                     }
                     else
                     {
                        point.x = this.x + 115;
                     }
                     point.y = this.y - 20;
                     this.doHit2Arrow(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit4":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 19)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 245;
                        }
                        else
                        {
                           point.x = this.x + 245;
                        }
                        point.y = this.y - 110;
                        this.doHit4(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 1)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y;
                     this.doHit4Arrow(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit5":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 19)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 115;
                        }
                        else
                        {
                           point.x = this.x + 115;
                        }
                        point.y = this.y - 110;
                        this.doHit5_1(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 4)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 115;
                     }
                     else
                     {
                        point.x = this.x + 115;
                     }
                     point.y = this.y - 110;
                     this.doHit5_1(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getCurFrameCount() == 14)
               {
                  if(p.x == 1 || p.x == 4)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y - 20;
                     minDis = Number(9999);
                     for each(var bo in gc.getPlayerArray())
                     {
                        if(this.getBBDC().getDirect() == 0)
                        {
                           if(this.x > bo.x)
                           {
                              dis = AUtils.GetDisBetweenTwoObj(this,bo);
                              if(minDis > dis)
                              {
                                 minDis = dis;
                                 target = bo;
                              }
                           }
                        }
                        else if(this.x < bo.x)
                        {
                           dis = AUtils.GetDisBetweenTwoObj(this,bo);
                           if(minDis > dis)
                           {
                              minDis = dis;
                              target = bo;
                           }
                        }
                     }
                     if(target)
                     {
                        this.doHit5_2(this.getBBDC().getDirect(),point,target);
                     }
                  }
               }
               break;
            case "hit6":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(p.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 25;
                        }
                        else
                        {
                           point.x = this.x + 25;
                        }
                        point.y = this.y - 30;
                        this.doHit6(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 10)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 25;
                     }
                     else
                     {
                        point.x = this.x + 25;
                     }
                     point.y = this.y - 30;
                     this.doHit6(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 2)
                  {
                     for each(var bb in this.magicBulletArray)
                     {
                        if(bb.getImcName() == "Role4Bullet7_1")
                        {
                           bb.destroy();
                        }
                     }
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 155;
                     }
                     else
                     {
                        point.x = this.x + 155;
                     }
                     point.y = this.y - 50;
                     this.doHit7_1(this.getBBDC().getDirect(),point);
                  }
               }
               if(this.bbdc.getCurFrameCount() == 8)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 150;
                     }
                     else
                     {
                        point.x = this.x + 150;
                     }
                     point.y = this.y - 70;
                     this.doHit7_2(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit8":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 125;
                        }
                        else
                        {
                           point.x = this.x + 125;
                        }
                        point.y = this.y - 30;
                        this.doHit8(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 75;
                        }
                        else
                        {
                           point.x = this.x + 75;
                        }
                        point.y = this.y - 60;
                        this.doHit8Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 65;
                        }
                        else
                        {
                           point.x = this.x + 65;
                        }
                        point.y = this.y - 10;
                        this.doHit8Arrow_2(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(p.x == 0)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.speed.x = 25;
                        this.speed.y = -25;
                     }
                     else
                     {
                        this.isLeft = true;
                        this.isRight = false;
                        this.speed.x = -25;
                        this.speed.y = -25;
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
               }
               break;
            case "hit9":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
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
                        this.doHit9_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 13)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y - 80;
                        this.doHit9_2(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(p.x == 2)
                  {
                     this.speed.y = -10;
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 80;
                        }
                        else
                        {
                           point.x = this.x + 80;
                        }
                        point.y = this.y - 80;
                        this.doHit9Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 60;
                        }
                        else
                        {
                           point.x = this.x + 60;
                        }
                        point.y = this.y + 30;
                        this.doHit9Arrow_2(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(p.x <= 1)
                  {
                     this.speed.y = -35;
                  }
                  else
                  {
                     this.speed.y = 0;
                  }
                  this.setStatic();
               }
               break;
            case "hit10":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 150;
                        }
                        else
                        {
                           point.x = this.x + 150;
                        }
                        point.y = this.y - 50;
                        this.doHit10(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(p.x < 2)
                  {
                     if(this.getBBDC().getDirect() == 0)
                     {
                        this.speed.x = -20;
                     }
                     else
                     {
                        this.speed.x = 20;
                     }
                  }
                  else
                  {
                     this.setStatic();
                  }
               }
               else
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
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
                        this.doHit10Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     if(p.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 225;
                        }
                        else
                        {
                           point.x = this.x + 225;
                        }
                        point.y = this.y - 80;
                        this.doHit10Arrow_2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               break;
            case "hit11":
               if(this.bbdc.getCurFrameCount() == 4)
               {
                  if(p.x == 5)
                  {
                     point.x = this.x;
                     point.y = this.y;
                  }
               }
               break;
            case "hit12":
               if(this.isNotArrow)
               {
                  if(this.bbdc.getCurFrameCount() == 14)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 150;
                        }
                        else
                        {
                           point.x = this.x + 150;
                        }
                        point.y = this.y;
                        this.doHit12(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               else
               {
                  if(p.x == 0 || p.x == 1 && this.bbdc.getCurFrameCount() >= 16)
                  {
                     this.setStatic();
                     this.speed.y = -35;
                  }
                  else if(p.x >= 2 && p.x <= 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.speed.x = -25;
                     }
                     else
                     {
                        this.speed.x = 25;
                     }
                     this.speed.y = 0;
                  }
                  else if(p.x == 4 && this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        this.isRight = true;
                        this.isLeft = false;
                        this.bbdc.turnRight();
                     }
                     else
                     {
                        this.isRight = false;
                        this.isLeft = true;
                        this.bbdc.turnLeft();
                     }
                  }
                  else
                  {
                     this.setStatic();
                     this.speed.y = 0;
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0 || p.x == 4)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 80;
                        }
                        else
                        {
                           point.x = this.x + 80;
                        }
                        point.y = this.y - 100;
                        this.doHit12Arrow_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0 || p.x == 4)
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
                        this.doHit12Arrow_2(this.getBBDC().getDirect(),point);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 17 || this.bbdc.getCurFrameCount() == 12 || this.bbdc.getCurFrameCount() == 6)
                  {
                     if(p.x == 1 || p.x == 5)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - (88 + this.bbdc.getCurFrameCount());
                        }
                        else
                        {
                           point.x = this.x + (88 + this.bbdc.getCurFrameCount());
                        }
                        point.y = this.y - (-7 + this.bbdc.getCurFrameCount() * 2);
                        this.doHit12Arrow_3(this.getBBDC().getDirect(),point);
                     }
                  }
               }
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1Arrow(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2Arrow(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet3");
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
         mm.play("Role4_hit4");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4Arrow(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit4Arrow");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit5");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5_2(direct:uint, p:Point, target:*) : void
      {
         var idx:int = gc.pWorld.likeMonsterArray.indexOf(this.role4Hit5);
         if(this.role4Hit5 && idx != -1)
         {
            this.role4Hit5.destroy();
            gc.pWorld.likeMonsterArray.splice(idx,1);
            this.role4Hit5 = null;
         }
         this.role4Hit5 = new MonsterRole4Hit5(target,this);
         this.role4Hit5.x = p.x;
         this.role4Hit5.y = p.y;
         gc.gameSence.addChild(this.role4Hit5);
         gc.pWorld.likeMonsterArray.push(this.role4Hit5);
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role4_hit6");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var newObbsiteArray:Array = gc.getPlayerArray();
         if(this.role4Hit5)
         {
            newObbsiteArray = newObbsiteArray.concat(this.role4Hit5);
         }
         for each(bo in newObbsiteArray)
         {
            if(this.bbdc.getDirect() == 0)
            {
               if(bo.x < this.x)
               {
                  if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
                  {
                     var target:BaseObject = bo;
                     break;
                  }
               }
            }
            else if(bo.x > this.x)
            {
               if(AUtils.GetDisBetweenTwoObj(bo,this) <= 500)
               {
                  target = bo;
                  break;
               }
            }
         }
         if(target)
         {
            var dis:Number = AUtils.GetDisBetweenTwoObj(target,this);
            var moveTime:Number = dis / 500 * 1.2;
            this.reHit6(b,target,8,moveTime);
         }
         else
         {
            TweenMax.to(b,1,{
               "alpha":0,
               "onComplete":function(_b:SpecialEffectBullet):*
               {
                  _b.destroy();
               },
               "onCompleteParams":[b]
            });
         }
      }
      
      private function reHit6(_b:SpecialEffectBullet, _target:BaseObject, _times:uint, _moveTime:Number) : void
      {
         _b = _b;
         _target = _target;
         _times = _times;
         _moveTime = _moveTime;
         if(_times > 0)
         {
            mm.play("Role4_hit6");
            _times--;
            TweenMax.to(_b,_moveTime,{
               "x":_target.x,
               "y":_target.y,
               "onComplete":function(_self:Monster32, __b:SpecialEffectBullet, __target:BaseObject, __times:uint):*
               {
                  var img:* = null;
                  var flag:Boolean = false;
                  var newObbsiteArray:* = null;
                  var dis:Number = NaN;
                  if(!__target.isYourFather() && AUtils.GetDisBetweenTwoObj(__b,__target) <= 50)
                  {
                     if(__target.curAddEffect)
                     {
                        __target.curAddEffect.add([{
                           "name":BaseAddEffect.POISON_TIMES,
                           "time":gc.frameClips * 7
                        }]);
                        __target.curAddEffect.add([{
                           "name":BaseAddEffect.STUN,
                           "time":gc.frameClips * 0.5
                        }]);
                     }
                     img = AUtils.getNewObj("HeroBeHurt");
                     img.x = colipse.x;
                     img.y = colipse.y;
                     __target.addChild(img);
                     flag = false;
                     newObbsiteArray = gc.getPlayerArray();
                     if(this.role4Hit5)
                     {
                        newObbsiteArray = newObbsiteArray.concat(this.role4Hit5);
                     }
                     for each(var bo in newObbsiteArray)
                     {
                        if(bo != __target)
                        {
                           dis = AUtils.GetDisBetweenTwoObj(bo,__b);
                           if(dis <= 500)
                           {
                              flag = true;
                              _self.reHit6(__b,bo,__times,dis / 500 * 1.2);
                              break;
                           }
                        }
                     }
                     if(!flag)
                     {
                        __b.destroy();
                     }
                  }
                  else
                  {
                     __b.destroy();
                  }
               },
               "onCompleteParams":[this,_b,_target,_times]
            });
         }
         else
         {
            _b.destroy();
         }
      }
      
      private function otherAttackHit6_2(direct:uint, p:Point, targetPointArray:Array) : void
      {
         direct = direct;
         p = p;
         targetPointArray = targetPointArray;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var targetX:int = parseInt(targetPointArray[0]);
         var targetY:int = parseInt(targetPointArray[1]);
         var moveTime:Number = targetPointArray[2];
         TweenMax.to(b,moveTime,{
            "x":targetX,
            "y":targetY,
            "onComplete":function():*
            {
               b.destroy();
            },
            "onCompleteParams":[b]
         });
      }
      
      private function doHit7_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit7");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet7_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7_1");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7_2(direct:uint, p:Point) : void
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role4Bullet7_2")
            {
               bb.destroy();
            }
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet7_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Role4Bullet7_2");
         if(direct == 0)
         {
            b.x = p.x - 40;
         }
         else
         {
            b.x = p.x + 40;
         }
         b.y = p.y - 20;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Role4Bullet7_2");
         if(direct == 0)
         {
            b.x = p.x + 40;
         }
         else
         {
            b.x = p.x - 40;
         }
         b.y = p.y - 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit8Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow8_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8Arrow_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow8_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit9");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4Bullet9_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit9Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9Arrow_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow9_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit10");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet10");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit10Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow10_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10Arrow_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow10_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit12");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4Bullet12");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit12");
         b.setDestroyInCount(gc.frameClips * 10);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_1(direct:uint, p:Point) : void
      {
         mm.play("Role4_hit12Arrow");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit12");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_2(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role4BulletArrow12_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit12Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12Arrow_3(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role4BulletArrow12_3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit12Arrow");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         var skillArray:Array = ["hit3","hit4","hit5","hit7","hit8","hit9","hit10","hit12"];
         var randSkil:String = skillArray[int(RandomControllor.getIns().getRandom() * skillArray.length)];
         trace("释放技能：" + randSkil);
         this.faceToTarget();
         this.setYourFather(10);
         this.setAction(randSkil);
         this.lastHit = randSkil;
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
               TweenMax.delayedCall(10,function(_self:Monster32):*
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
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(p);
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.isGXP)
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
         }
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         if(this.isNotArrow)
         {
            return this.curAction == "hit10" || this.curAction == "hit8";
         }
         return this.curAction == "hit8";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.role4Hit5)
         {
            this.role4Hit5.destroy();
            this.role4Hit5 = null;
         }
         if(gc.curStageAndCurLevel.curStage == 4)
         {
            if(this.getHp() <= 0)
            {
               gc.bossChallenge[0] = 1;
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
         super.destroy();
      }
   }
}
