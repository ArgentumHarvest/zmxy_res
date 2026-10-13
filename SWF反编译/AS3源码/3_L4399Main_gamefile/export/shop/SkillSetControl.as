package export.shop
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import user.User;
   
   public class SkillSetControl extends Sprite
   {
       
      
      private var gc:Config;
      
      private var tag:Boolean = true;
      
      private var player:User;
      
      private var sdyskill:String = "";
      
      private var needLh:uint;
      
      private var skilllev:uint;
      
      public var x_btn:SimpleButton;
      
      public var sourcemc:Sprite;
      
      public var Ymc:MovieClip;
      
      public var Umc:MovieClip;
      
      public var Imc:MovieClip;
      
      public var Omc:MovieClip;
      
      public var Lmc:MovieClip;
      
      private var ox:Number;
      
      private var oy:Number;
      
      private var imgSprite:Sprite;
      
      private var newObj:Object;
      
      private var oldObj:Object;
      
      public function SkillSetControl(_player:User, _sdyskill:Array, _needLh:uint = 0)
      {
         newObj = {};
         oldObj = {};
         super();
         gc = Config.getInstance();
         this.player = _player;
         this.sdyskill = _sdyskill[0];
         this.needLh = _needLh;
         if(_sdyskill[1] != undefined)
         {
            this.skilllev = _sdyskill[1];
         }
         else
         {
            this.skilllev = 1;
         }
         imgSprite = new Sprite();
         this.addChild(imgSprite);
         newObj.skillName = sdyskill;
         newObj.needLh = needLh;
         newObj.slev = skilllev;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var img:* = undefined;
         if(tag)
         {
            tag = false;
            this.initHadStudySkill();
            if(this.sdyskill != "")
            {
               img = AUtils.getImageObj("skillicon_" + this.sdyskill);
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
         var img:* = undefined;
         var sprite:* = null;
         var smallShow:* = null;
         if(this.player.getControlPlayer() == 0)
         {
            this.Ymc.gotoAndStop(1);
            this.Umc.gotoAndStop(1);
            this.Imc.gotoAndStop(1);
            this.Omc.gotoAndStop(1);
            this.Lmc.gotoAndStop(1);
         }
         else
         {
            this.Ymc.gotoAndStop(2);
            this.Umc.gotoAndStop(2);
            this.Imc.gotoAndStop(2);
            this.Omc.gotoAndStop(2);
            this.Lmc.gotoAndStop(2);
         }
         var slen:uint = this.player.skillbykey.length;
         for(var keys:String = ""; slen-- > 0; )
         {
            img = AUtils.getImageObj("skillicon_" + this.player.skillbykey[slen].skillName);
            sprite = new Sprite();
            sprite.name = "initsprite" + this.player.skillbykey[slen].keys;
            sprite.addChild(img);
            if(this.player.controlPlayer == 0)
            {
               keys = this.player.skillbykey[slen].keys;
            }
            else
            {
               keys = this.player.skillbykey[slen].keys;
               if(keys == "8")
               {
                  keys = "Y";
               }
               else if(keys == "4")
               {
                  keys = "U";
               }
               else if(keys == "5")
               {
                  keys = "I";
               }
               else if(keys == "6")
               {
                  keys = "O";
               }
               else if(keys == "3")
               {
                  keys = "L";
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
            smallShow.addChild(AUtils.getImageObj("Skill_" + this.player.skillbykey[slen].keys));
            smallShow.x = sprite.width / 2 + 12;
            smallShow.y = sprite.height / 2 + 12;
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
            if(imgSprite.hitTestObject(this.Ymc))
            {
               imgSprite.x = this.Ymc.x + 5;
               imgSprite.y = this.Ymc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "Y";
                  oldObj = this.player.returnSkillObjBySkillKey("Y");
               }
               else
               {
                  newObj.keys = "8";
                  oldObj = this.player.returnSkillObjBySkillKey("8");
               }
            }
            else if(imgSprite.hitTestObject(this.Umc))
            {
               imgSprite.x = this.Umc.x + 5;
               imgSprite.y = this.Umc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "U";
                  oldObj = this.player.returnSkillObjBySkillKey("U");
               }
               else
               {
                  newObj.keys = "4";
                  oldObj = this.player.returnSkillObjBySkillKey("4");
               }
            }
            else if(imgSprite.hitTestObject(this.Imc))
            {
               imgSprite.x = this.Imc.x + 5;
               imgSprite.y = this.Imc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "I";
                  oldObj = this.player.returnSkillObjBySkillKey("I");
               }
               else
               {
                  newObj.keys = "5";
                  oldObj = this.player.returnSkillObjBySkillKey("5");
               }
            }
            else if(imgSprite.hitTestObject(this.Omc))
            {
               imgSprite.x = this.Omc.x + 5;
               imgSprite.y = this.Omc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "O";
                  oldObj = this.player.returnSkillObjBySkillKey("O");
               }
               else
               {
                  newObj.keys = "6";
                  oldObj = this.player.returnSkillObjBySkillKey("6");
               }
            }
            else if(imgSprite.hitTestObject(this.Lmc))
            {
               imgSprite.x = this.Lmc.x + 5;
               imgSprite.y = this.Lmc.y + 5;
               if(this.player.controlPlayer == 0)
               {
                  newObj.keys = "L";
                  oldObj = this.player.returnSkillObjBySkillKey("L");
               }
               else
               {
                  newObj.keys = "3";
                  oldObj = this.player.returnSkillObjBySkillKey("3");
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
            smallShow.addChild(AUtils.getImageObj("Skill_" + newObj.keys));
            smallShow.x = imgSprite.width / 2 + 8;
            smallShow.y = imgSprite.height / 2 + 8;
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
         if(outskill != null)
         {
            sit = uint(this.player.skillbykey.indexOf(outskill));
            this.player.setSkillLevelInTheAllSkillAry(outskill.skillName,outskill.slev);
            if(sit != -1)
            {
               this.player.skillbykey.splice(sit,1);
            }
         }
         this.player.skillbykey.push(inskill);
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
            this.parent.removeChild(this);
         }
      }
   }
}
