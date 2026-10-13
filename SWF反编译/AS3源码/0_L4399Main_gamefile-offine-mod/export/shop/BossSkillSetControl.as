package export.shop
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import user.User;
   
   public class BossSkillSetControl extends Sprite
   {
       
      
      private var gc:Config;
      
      private var tag:Boolean = true;
      
      private var player:User;
      
      private var sdyskill:String = "";
      
      private var needLh:uint;
      
      public var x_btn:SimpleButton;
      
      public var sourcemc:Sprite;
      
      public var SSJmc:MovieClip;
      
      public var WWJmc:MovieClip;
      
      public var SWJmc:MovieClip;
      
      private var ox:Number;
      
      private var oy:Number;
      
      private var imgSprite:Sprite;
      
      private var newObj:Object;
      
      private var oldObj:Object;
      
      public function BossSkillSetControl(_player:User, _sdyskill:String, _needLh:uint = 0)
      {
         newObj = {};
         oldObj = {};
         super();
         this.name = "BossSkillSetControl";
         gc = Config.getInstance();
         this.player = _player;
         this.sdyskill = _sdyskill;
         this.needLh = _needLh;
         imgSprite = new Sprite();
         this.addChild(imgSprite);
         newObj.skillName = sdyskill;
         newObj.needLh = needLh;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var img:* = null;
         if(tag)
         {
            tag = false;
            this.initHadStudySkill();
            if(this.sdyskill != "")
            {
               img = AUtils.getNewObj(this.sdyskill);
               img.gotoAndStop(2);
               imgSprite.name = "imgSprite";
               imgSprite.addChild(img);
               imgSprite.x = this.sourcemc.x + 5;
               imgSprite.y = this.sourcemc.y + 5;
               imgSprite.addChild(AUtils.getNewObj("highlight"));
            }
            x_btn.addEventListener("click",back);
            imgSprite.addEventListener("mouseDown",down);
            imgSprite.addEventListener("mouseUp",up);
         }
      }
      
      private function initHadStudySkill() : void
      {
         var img:* = null;
         var sprite:* = null;
         var smallShow:* = null;
         if(this.player == null)
         {
            return;
         }
         if(this.player.getControlPlayer() == 0)
         {
            this.SSJmc.gotoAndStop(1);
            this.WWJmc.gotoAndStop(1);
            this.SWJmc.gotoAndStop(1);
         }
         else
         {
            this.SSJmc.gotoAndStop(2);
            this.WWJmc.gotoAndStop(2);
            this.SWJmc.gotoAndStop(2);
         }
         var slen:uint = this.player.bossskillbykey.length;
         for(var keys:String = ""; slen-- > 0; )
         {
            img = AUtils.getNewObj(this.player.bossskillbykey[slen].skillName);
            img.gotoAndStop(2);
            sprite = new Sprite();
            sprite.name = "initsprite" + this.player.bossskillbykey[slen].keys;
            sprite.addChild(img);
            if(this.player.controlPlayer == 0)
            {
               keys = this.player.bossskillbykey[slen].keys;
            }
            else
            {
               keys = this.player.bossskillbykey[slen].keys;
               if(keys == "↓↓1")
               {
                  keys = "SSJ";
               }
               else if(keys == "↑↑1")
               {
                  keys = "WWJ";
               }
               else if(keys == "↓↑1")
               {
                  keys = "SWJ";
               }
            }
            sprite.x = this[keys + "mc"].x + 5;
            sprite.y = this[keys + "mc"].y + 5;
            this.addChild(sprite);
            if(this.getChildIndex(imgSprite) < this.getChildIndex(sprite))
            {
               this.swapChildren(imgSprite,sprite);
            }
            smallShow = new Sprite();
            smallShow.addChild(AUtils.getImageObj("BossSkill_" + this.player.bossskillbykey[slen].keys));
            smallShow.x = sprite.width / 3;
            smallShow.y = sprite.height / 2;
            sprite.addChild(smallShow);
         }
      }
      
      private function down(e:MouseEvent) : void
      {
         imgSprite.startDrag();
         this.ox = imgSprite.x;
         this.oy = imgSprite.y;
      }
      
      private function up(e:MouseEvent) : void
      {
         var smallShow:* = null;
         imgSprite.stopDrag();
         if(imgSprite)
         {
            if(imgSprite.hitTestObject(this.SSJmc))
            {
               imgSprite.x = this.SSJmc.x + 5;
               imgSprite.y = this.SSJmc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "SSJ";
                  oldObj = this.player.returnSkillObjBySkillKey("SSJ");
               }
               else
               {
                  newObj.keys = "↓↓1";
                  oldObj = this.player.returnSkillObjBySkillKey("↓↓1");
               }
            }
            else
            {
               imgSprite.x = this.ox;
               imgSprite.y = this.oy;
            }
         }
         if(newObj.keys != undefined)
         {
            smallShow = imgSprite.getChildByName("ShowSkillKey") as Sprite;
            if(smallShow)
            {
               imgSprite.removeChild(smallShow);
            }
            smallShow = null;
            smallShow = new Sprite();
            smallShow.addChild(AUtils.getImageObj("BossSkill_" + newObj.keys));
            smallShow.x = imgSprite.width / 3;
            smallShow.y = imgSprite.height / 2;
            smallShow.name = "ShowSkillKey";
            imgSprite.addChild(smallShow);
         }
      }
      
      private function removed(e:Event) : void
      {
         x_btn.removeEventListener("click",back);
         imgSprite.removeEventListener("mouseDown",down);
         imgSprite.removeEventListener("mouseUp",up);
      }
      
      private function replaceSkillButton(inskill:Object, outskill:Object = null) : void
      {
         var sit:* = 0;
         if(this.player)
         {
            if(outskill != null)
            {
               sit = uint(this.player.bossskillbykey.indexOf(outskill));
               if(sit != -1)
               {
                  this.player.bossskillbykey.splice(sit,1);
               }
            }
            this.player.bossskillbykey.push(inskill);
         }
      }
      
      private function back(e:MouseEvent) : void
      {
         if(newObj.keys != undefined)
         {
            if(this.getChildByName("initsprite" + newObj.keys))
            {
               this.removeChild(this.getChildByName("initsprite" + newObj.keys));
            }
            this.replaceSkillButton(newObj,oldObj);
         }
         if(this.parent)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("CLOSESKILLSETCONTROL"));
            this.parent.removeChild(this);
         }
      }
   }
}
