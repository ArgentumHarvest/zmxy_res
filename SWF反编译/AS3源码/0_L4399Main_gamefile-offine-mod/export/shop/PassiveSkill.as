package export.shop
{
   import config.Config;
   import export.immortality.ImmortalityInterface;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import user.User;
   
   public class PassiveSkill extends MovieClip
   {
       
      
      public var btn:SimpleButton;
      
      public var wantlh:TextField;
      
      public var curslevel:TextField;
      
      public var attvalue:TextField;
      
      public var lastvalue:TextField;
      
      private var gc:Config;
      
      private var player:User;
      
      private var skilllevel:uint;
      
      public var eatbtn:SimpleButton;
      
      public function PassiveSkill()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         var i:uint = uint(String(this.name).substr(6,1));
         this.gotoAndStop(i);
         this.btn.addEventListener("click",updataSkill);
         this.eatbtn.addEventListener("click",eatClick);
      }
      
      private function removed(e:*) : void
      {
         this.btn.removeEventListener("click",updataSkill);
         this.eatbtn.removeEventListener("click",eatClick);
      }
      
      private function setTxt() : void
      {
         this.curslevel.text = this.skilllevel - 1 + "";
         this.wantlh.text = this.skilllevel * 5000 + "";
         var str1:String = this.analy(skilllevel - 1);
         this.lastvalue.text = str1;
         var str2:String = this.analy(skilllevel);
         this.attvalue.text = str2;
      }
      
      private function analy(_lev:uint) : String
      {
         var temp:* = undefined;
         if(_lev > 5 || _lev <= 0)
         {
            temp = "----";
         }
         else
         {
            switch(this.currentFrame - 1)
            {
               case 0:
                  temp = "生命上限增加 " + (_lev * 100 + 100 + this.player.findAllImmortalityAddHp());
                  break;
               case 1:
                  temp = "魔法上限增加 " + (_lev * 100 + 100);
                  break;
               case 2:
                  temp = "暴击率增加 " + (_lev + 1) + " %";
                  break;
               case 3:
                  temp = "每秒回血增加 " + (_lev + 1);
                  break;
               case 4:
                  temp = "每秒回魔增加 " + (_lev + 1);
            }
         }
         return temp + "";
      }
      
      private function updataSkill(e:*) : void
      {
         var skillArray:* = null;
         if(this.player)
         {
            skillArray = player.dataObject.ispassiveskill;
            if(skillArray[this.currentFrame - 1] <= 5)
            {
               if(player.getLhValue() >= this.skilllevel * 5000)
               {
                  skillArray[this.currentFrame - 1]++;
                  if(gc["hero" + (this.player.getControlPlayer() + 1)])
                  {
                     gc["hero" + (this.player.getControlPlayer() + 1)].roleProperies.addPassive(this.currentFrame - 1,this.skilllevel);
                  }
                  else
                  {
                     trace("hero is null, now!");
                  }
                  this.player.setLhValue(this.player.getLhValue() - this.skilllevel * 5000);
                  BuySkill(this.parent.parent).setTxtlh();
                  this.skilllevel = skillArray[this.currentFrame - 1] + 1;
                  if(skillArray[this.currentFrame - 1] == 5)
                  {
                     this.btn.visible = false;
                     this.btn.removeEventListener("click",updataSkill);
                     if(this.currentFrame == 1)
                     {
                        this.eatbtn.visible = true;
                     }
                  }
                  player.dataObject.ispassiveskill = skillArray;
               }
               else
               {
                  trace("your lhValue is not enought");
               }
            }
         }
         this.setTxt();
      }
      
      private function eatClick(e:MouseEvent) : void
      {
         trace("eatClick");
         var iif:ImmortalityInterface = new ImmortalityInterface(this.player);
         this.parent.addChild(iif);
      }
      
      public function setRole(_player:User) : void
      {
         this.eatbtn.visible = false;
         this.eatbtn.removeEventListener("click",eatClick);
         var i:uint = uint(String(this.name).substr(6,1));
         this.gotoAndStop(i);
         this.player = _player;
         this.skilllevel = this.player.dataObject.ispassiveskill[this.currentFrame - 1] + 1;
         if(this.skilllevel > 5)
         {
            this.btn.visible = false;
            this.btn.removeEventListener("click",updataSkill);
            if(this.currentFrame == 1)
            {
               this.eatbtn.visible = true;
            }
         }
         this.setTxt();
      }
   }
}
