package export.pet
{
   import base.BaseHero;
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import user.User;
   
   public class PetEatImmortality extends Sprite
   {
       
      
      public var mc1:MovieClip;
      
      public var mc2:MovieClip;
      
      public var mc3:MovieClip;
      
      public var mc4:MovieClip;
      
      public var mc5:MovieClip;
      
      public var mc6:MovieClip;
      
      public var mc7:MovieClip;
      
      public var mc8:MovieClip;
      
      public var btn_close:SimpleButton;
      
      private var player:User;
      
      private var gc:Config;
      
      private var immortalityAry:Array;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 1;
      
      public function PetEatImmortality(_user:User)
      {
         immortalityAry = ["wphhd","wpcsd","cwzzxld","cwjnxld","wphtd","nianqld","nianjhd","nianjhdd"];
         super();
         mc1.buttonMode = true;
         mc2.buttonMode = true;
         mc3.buttonMode = true;
         mc4.buttonMode = true;
         mc5.buttonMode = true;
         mc6.buttonMode = true;
         mc7.buttonMode = true;
         mc8.buttonMode = true;
         gc = Config.getInstance();
         this.player = _user;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.setImmortalityMc();
         btn_close.addEventListener("click",xClick);
      }
      
      private function removed(e:Event) : void
      {
         mc1.removeEventListener("click",eatClick);
         mc2.removeEventListener("click",eatClick);
         mc3.removeEventListener("click",eatClick);
         mc4.removeEventListener("click",eatClick);
         mc5.removeEventListener("click",eatClick);
         mc6.removeEventListener("click",eatClick);
         mc7.removeEventListener("click",eatClick);
         mc8.removeEventListener("click",eatClick);
         btn_close.removeEventListener("click",xClick);
         if(this.parent)
         {
            PetInterface(this.parent).refreshInterface();
         }
      }
      
      private function setImmortalityMc() : void
      {
         var i:* = 0;
         for(i = uint(1); i <= 8; )
         {
            if(this.player.getSomeOneEquipNumberByName(this.immortalityAry[i - 1]) > 0)
            {
               this["mc" + i].gotoAndStop(1);
               this["mc" + i].addEventListener("click",eatClick);
            }
            else
            {
               this["mc" + i].gotoAndStop(2);
               this["mc" + i].removeEventListener("click",eatClick);
            }
            i++;
         }
      }
      
      private function eatClick(e:MouseEvent) : void
      {
         var hlen:* = 0;
         var index:uint = int(String(e.currentTarget.name).substr(2,1));
         trace("index -->>" + index);
         if(index == 1)
         {
            if(this.player.findCurrentPet(true))
            {
               this.player.findCurrentPet(true).reSetPetState();
               for(hlen = uint(gc.getPlayerArray().length); hlen-- > 0; )
               {
                  if(BaseHero(gc.getPlayerArray()[hlen]).getPlayer() == this.player)
                  {
                     BaseHero(gc.getPlayerArray()[hlen]).changePet();
                  }
               }
               this.player.removeSomeOneDJByFillName("wphhd");
               gc.ts.setTxt("服用成功!");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 2)
         {
            if(this.player.findCurrentPet(true))
            {
               this.player.findCurrentPet(true).setlifetime(this.player.findCurrentPet(true).getlifetime() + 20);
               if(this.player.findCurrentPet(true).getlifetime() > 100)
               {
                  this.player.findCurrentPet(true).setlifetime(100);
               }
               this.player.removeSomeOneDJByFillName("wpcsd");
               gc.ts.setTxt("服用成功!");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 3)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               this.player.findCurrentPet(true).refreshTherrAttributeByImmortality();
               this.player.removeSomeOneDJByFillName("cwzzxld");
               gc.ts.setTxt("服用成功!");
               gc.stage.addChild(gc.ts);
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 4)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               this.player.findCurrentPet(true).refreshPetAllSkillByLevel();
               this.player.removeSomeOneDJByFillName("cwjnxld");
               gc.ts.setTxt("服用成功!");
               gc.stage.addChild(gc.ts);
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 5)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               this.player.findCurrentPet(true).makePetBecomeChild();
               if(gc.hero1)
               {
                  if(gc.hero1.getPlayer() == this.player)
                  {
                     gc.hero1.changePet();
                  }
               }
               if(gc.hero2)
               {
                  if(gc.hero2.getPlayer() == this.player)
                  {
                     gc.hero2.changePet();
                  }
               }
               this.player.removeSomeOneDJByFillName("wphtd");
               gc.eventManger.dispatchEvent(new CommonEvent("CHANGECURRENTPET"));
               gc.ts.setTxt("服用成功!");
               gc.stage.addChild(gc.ts);
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 6)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               if(this.player.findCurrentPet(true).getPetPreName() == "nian")
               {
                  this.player.findCurrentPet(true).setpotential(this.player.findCurrentPet(true).getpotential() + 100);
                  this.player.removeSomeOneDJByFillName("nianqld");
                  gc.ts.setTxt("服用成功!");
                  gc.stage.addChild(gc.ts);
                  if(gc.isHideDebug)
                  {
                     gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                  }
               }
               else
               {
                  gc.ts.setTxt("该丹药只有年兽可以服用");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 7)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               if(this.player.findCurrentPet(true).getPetPreName() == "nian")
               {
                  if(this.player.findCurrentPet(true).getCurPetState() != 4)
                  {
                     if(this.player.findCurrentPet(true).getCurPetState() >= 5)
                     {
                        gc.ts.setTxt("该宠物的第三形态不能服用");
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                     if(this.player.findCurrentPet(true).getLevel() >= 32)
                     {
                        this.player.findCurrentPet(true).theFourShape(true);
                        this.player.removeSomeOneDJByFillName("nianjhd");
                        gc.ts.setTxt("服用成功!");
                        gc.stage.addChild(gc.ts);
                        if(gc.isHideDebug)
                        {
                           gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                        }
                     }
                     else
                     {
                        gc.ts.setTxt("该丹药服用需要宠物达到32级以上");
                        gc.stage.addChild(gc.ts);
                     }
                  }
                  else
                  {
                     gc.ts.setTxt("该宠物已经是第二形态");
                     gc.stage.addChild(gc.ts);
                  }
               }
               else
               {
                  gc.ts.setTxt("该丹药只有年兽可以服用");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(index == 8)
         {
            if(this.player.findCurrentPet(true) != null)
            {
               if(this.player.findCurrentPet(true).getPetPreName() == "nian")
               {
                  if(this.player.findCurrentPet(true).getCurPetState() < 5)
                  {
                     if(this.player.findCurrentPet(true).getCurPetState() == 4)
                     {
                        if(this.player.findCurrentPet(true).getLevel() >= 50)
                        {
                           this.player.findCurrentPet(true).theFiveShape();
                           this.player.removeSomeOneDJByFillName("nianjhdd");
                           gc.ts.setTxt("服用成功!");
                           gc.stage.addChild(gc.ts);
                           if(gc.isHideDebug)
                           {
                              gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                           }
                        }
                        else
                        {
                           gc.ts.setTxt("该丹药服用需要宠物达到50级以上");
                           gc.stage.addChild(gc.ts);
                        }
                     }
                     else
                     {
                        gc.ts.setTxt("该丹药服用需要宠物达到第二形态");
                        gc.stage.addChild(gc.ts);
                     }
                  }
                  else
                  {
                     gc.ts.setTxt("该宠物已经是第三形态");
                     gc.stage.addChild(gc.ts);
                  }
               }
               else
               {
                  gc.ts.setTxt("该丹药只有年兽可以服用");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
            }
         }
         this.setImmortalityMc();
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
