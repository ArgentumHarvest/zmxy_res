package export.strength
{
   import config.Config;
   import event.CommonEvent;
   import export.pack.ShowObj;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import user.User;
   
   public class Resolution extends Sprite
   {
       
      
      public var material:Sprite;
      
      public var resu1:Sprite;
      
      public var resu2:Sprite;
      
      public var resu3:Sprite;
      
      public var resu4:Sprite;
      
      public var resu5:Sprite;
      
      public var resu6:Sprite;
      
      public var txt_needlh:TextField;
      
      public var fjbtn:SimpleButton;
      
      public var btn_help:SimpleButton;
      
      private var gc:Config;
      
      private var player:User;
      
      private var curEquip:MyEquipObj;
      
      private var tag:Boolean = true;
      
      public function Resolution(_player:User)
      {
         super();
         player = _player;
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(this.tag)
         {
            this.tag = false;
            this.player.outlist = [];
            gc.eventManger.addEventListener("SimpleClick",receiveObj);
            fjbtn.addEventListener("click",fjClick);
            resu1.addEventListener("click",onClick);
            resu2.addEventListener("click",onClick);
            resu3.addEventListener("click",onClick);
            resu4.addEventListener("click",onClick);
            resu5.addEventListener("click",onClick);
            resu6.addEventListener("click",onClick);
         }
      }
      
      private function removed(e:Event) : void
      {
         this.player.outlist = [];
         gc.eventManger.removeEventListener("SimpleClick",receiveObj);
         fjbtn.removeEventListener("click",fjClick);
         resu1.removeEventListener("click",onClick);
         resu2.removeEventListener("click",onClick);
         resu3.removeEventListener("click",onClick);
         resu4.removeEventListener("click",onClick);
         resu5.removeEventListener("click",onClick);
         resu6.removeEventListener("click",onClick);
         this.removedMaterialObj(false);
      }
      
      private function receiveObj(e:CommonEvent) : void
      {
         var temp:* = null;
         var sobj:ShowObj = e.data[0] as ShowObj;
         if(sobj.getMyEquipObj().type == "zbtx")
         {
            gc.ts.setTxt("该装备不能用来分解");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(sobj.getMyEquipObj().type == "zbwq" || sobj.getMyEquipObj().type == "zbfj" || sobj.getMyEquipObj().type == "zbsp")
         {
            temp = material.getChildByName("curzb") as ShowObj;
            if(temp == null)
            {
               material.addChild(sobj);
            }
            else if(gc.allEquip.isTheSameEquipmentByFillName(temp.getMyEquipObj()))
            {
               material.removeChild(temp);
               this.player.zblist.push(temp.getMyEquipObj());
               temp = null;
               material.addChild(sobj);
            }
            else
            {
               gc.ts.setTxt("不是同一个物品，请勿修改");
               gc.stage.addChild(gc.ts);
            }
            this.removeEquipFormBack(sobj.getMyEquipObj(),1);
            this.getMaterial();
            this.removeAllFromResu();
            this.setNeedLhTxt();
         }
      }
      
      private function setNeedLhTxt() : void
      {
         this.txt_needlh.text = "100";
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var temp:* = null;
         if(e.currentTarget.getChildByName("curzb") != null)
         {
            temp = e.currentTarget.getChildByName("curzb") as ShowObj;
            e.currentTarget.removeChild(temp);
            temp = null;
         }
      }
      
      private function removeEquipFormBack(equip:MyEquipObj, pack:int) : void
      {
         var sit:int = 0;
         if(pack == 1)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.zblist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.zblist.splice(sit,1);
               }
            }
         }
         else if(pack == 2)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.djlist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.djlist.splice(sit,1);
               }
            }
         }
      }
      
      private function getMaterial() : void
      {
         var sobj:* = null;
         this.player.outlist = [];
         if(this.material.getChildByName("curzb"))
         {
            sobj = this.material.getChildByName("curzb") as ShowObj;
            curEquip = sobj.getMyEquipObj();
            this.player.outlist.push({
               "dequip":curEquip,
               "count":1
            });
            sobj = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function removedMaterialObj(suc:Boolean = true) : void
      {
         var sobj:ShowObj = this.material.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            if(!suc)
            {
               if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
               {
                  this.player.zblist.push(sobj.getMyEquipObj());
               }
               else
               {
                  gc.ts.setTxt("不是同一个物品，请勿修改");
                  gc.stage.addChild(gc.ts);
               }
            }
            this.material.removeChild(sobj);
            sobj = null;
         }
      }
      
      private function fjClick(e:MouseEvent) : void
      {
         var rslist:* = null;
         var rlen:* = 0;
         var i:* = 0;
         if(this.curEquip != null)
         {
            if(this.player.getLhValue() >= 100)
            {
               this.player.setLhValue(this.player.getLhValue() - 100);
               StrengthEquipment(this.parent).setTxtlh();
               rslist = gc.allEquip.findResolution(this.curEquip);
               this.removedMaterialObj();
               this.addToResu(rslist);
               rlen = uint(rslist.length);
               for(i = uint(0); i < rlen; )
               {
                  gc.putQhsInBackPack(this.player,rslist[i].getFillName());
                  i++;
               }
               this.curEquip = null;
            }
            else
            {
               gc.ts.setTxt("灵魂不足");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            trace("curEquip is null");
         }
      }
      
      private function addToResu(arr:Array) : void
      {
         var i:* = 0;
         var sobj:* = null;
         var alen:uint = arr.length;
         trace("addToResu --alen= " + alen);
         for(i = uint(0); i < alen; )
         {
            sobj = new ShowObj(arr[i]);
            sobj.y = -2;
            this["resu" + (i + 1)].addChild(sobj);
            i++;
         }
      }
      
      private function removeAllFromResu() : void
      {
         var i:* = 0;
         var sobj:* = null;
         for(i = uint(0); i < 6; )
         {
            sobj = this["resu" + (i + 1)].getChildByName("curzb") as ShowObj;
            if(sobj != null)
            {
               this["resu" + (i + 1)].removeChild(sobj);
               sobj = null;
            }
            i++;
         }
      }
   }
}
