package export.pet
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.PetEquipObj;
   import user.User;
   
   public class PetPackThings extends Sprite
   {
       
      
      private var gc:Config;
      
      private var threebtn:Sprite;
      
      private var sobj:PetShowObj;
      
      private var _player:User;
      
      public function PetPackThings()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.addEventListener("rollOut",outHandle);
         this.addEventListener("click",onClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("rollOut",outHandle);
         this.removeEventListener("click",onClick);
      }
      
      public function setObj(obj:*, player:User) : void
      {
         if(obj != null)
         {
            sobj = new PetShowObj(obj);
            this.addChild(sobj);
            this._player = player;
            sobj.addEventListener("click",clickHandler);
         }
      }
      
      private function outHandle(e:*) : void
      {
         this.removeThreebtn();
      }
      
      private function onClick(e:*) : void
      {
         if(this.sobj != null)
         {
            this.sobj.pulbiremoved();
         }
      }
      
      public function removeThreebtn() : void
      {
         if(threebtn && contains(threebtn))
         {
            if(threebtn["bzb"])
            {
               threebtn["bzb"].removeEventListener("click",zbClick);
            }
            if(threebtn["bgy"])
            {
               threebtn["bgy"].removeEventListener("click",gyClick);
            }
            if(threebtn["bmd"])
            {
               threebtn["bmd"].removeEventListener("click",mdClick);
            }
            this.removeChild(threebtn);
            threebtn = null;
         }
      }
      
      public function removeSobj() : void
      {
         sobj.removeEventListener("click",clickHandler);
         this.removeChild(sobj);
         var equip:PetEquipObj = sobj.getPetEquipObj();
         var sit:int = this._player.plist.indexOf(equip);
         this._player.plist.splice(sit,1);
         sobj = null;
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         if(this.sobj && contains(this.sobj))
         {
            if(this.parent.parent.parent is PetBackPackShow)
            {
               this.removeThreebtn();
               threebtn = AUtils.getNewObj("threebtn");
               threebtn.x = 25;
               threebtn.y = 25;
               this.addChild(threebtn);
               threebtn["bzb"].addEventListener("click",zbClick);
               threebtn["bgy"].addEventListener("click",gyClick);
               threebtn["bmd"].addEventListener("click",mdClick);
               if(gc.playNum == 1)
               {
                  threebtn["bgy"].gotoAndStop(2);
                  threebtn["bgy"].removeEventListener("click",gyClick);
               }
            }
         }
      }
      
      private function gyClick(e:MouseEvent) : void
      {
         var players:Array = gc.getUsersArray();
         for each(var player in players)
         {
            if(player != this._player)
            {
               if(player.roleid > 0)
               {
                  player.plist.push(this.sobj.getPetEquipObj());
                  break;
               }
            }
         }
         this.removeThreebtn();
         this.removeSobj();
      }
      
      private function mdClick(e:MouseEvent) : void
      {
         if(this.parent.parent.parent is PetBackPackShow)
         {
            this._player.setLhValue(this._player.getLhValue() + this.sobj.getPetEquipObj().getValue());
            this._player.setMyScore(this._player.getMyScore() + this.sobj.getPetEquipObj().getValue());
         }
         this.removeThreebtn();
         this.removeSobj();
      }
      
      private function zbClick(e:MouseEvent) : *
      {
         if(e.currentTarget.currentFrame != 3)
         {
            this.usezb();
         }
         this.removeThreebtn();
      }
      
      private function usezb() : void
      {
         var cEquip:* = null;
         var temp:* = null;
         if(this.parent.parent.parent is PetBackPackShow)
         {
            if(PetBackPackShow(this.parent.parent.parent).pifIsNull())
            {
               gc.ts.setTxt("请选择要装备的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            cEquip = sobj.getPetEquipObj();
            temp = gc.allEquip.findByName(cEquip.getFillName());
            if(temp.type != cEquip.type)
            {
               gc.ts.setTxt("装备类型不符合");
               gc.stage.addChild(gc.ts);
               return;
            }
            this.removeSobj();
            PetBackPackShow(this.parent.parent.parent).equip(cEquip.type,cEquip);
         }
         else
         {
            trace("not in PetBackPackShow");
         }
      }
   }
}
