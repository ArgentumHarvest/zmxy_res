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
   
   public class Recasting extends Sprite
   {
       
      
      public var txt_needlh:TextField;
      
      public var zbmc1:Sprite;
      
      public var zbmc2:Sprite;
      
      public var shmc:Sprite;
      
      public var stmc:Sprite;
      
      public var czbtn:SimpleButton;
      
      public var produce:Sprite;
      
      private var gc:Config;
      
      private var player:User;
      
      public function Recasting(_player:User)
      {
         super();
         gc = Config.getInstance();
         this.player = _player;
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         gc.eventManger.addEventListener("SimpleClick",receiveObj);
         zbmc1.addEventListener("click",onClick);
         zbmc2.addEventListener("click",onClick);
         shmc.addEventListener("click",onClick);
         stmc.addEventListener("click",onClick);
         czbtn.addEventListener("click",czClick);
         txt_needlh.text = "10000";
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         gc.eventManger.removeEventListener("SimpleClick",receiveObj);
         zbmc1.removeEventListener("click",onClick);
         zbmc2.removeEventListener("click",onClick);
         shmc.removeEventListener("click",onClick);
         stmc.removeEventListener("click",onClick);
         czbtn.removeEventListener("click",czClick);
         this.removedSelf();
      }
      
      private function receiveObj(e:CommonEvent) : void
      {
         var temp:* = null;
         var sobj:ShowObj = e.data[0] as ShowObj;
         if(sobj.getMyEquipObj().type != "zbwp" && sobj.getMyEquipObj().quality != "传 说")
         {
            gc.ts.setTxt("只有传说装备才能重铸");
            gc.stage.addChild(gc.ts);
            return;
         }
         switch(sobj.getMyEquipObj().type)
         {
            case "zbwq":
            case "zbfj":
               if(zbmc1.numChildren < 1)
               {
                  temp = zbmc2.getChildByName("curzb") as ShowObj;
                  if(temp)
                  {
                     if(temp.getMyEquipObj().getFillName() == sobj.getMyEquipObj().getFillName() && temp.getMyEquipObj().getMutiLevel() == sobj.getMyEquipObj().getMutiLevel())
                     {
                        zbmc1.addChild(sobj);
                        this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                     }
                     else
                     {
                        gc.ts.setTxt("重铸时主副装备必须同名");
                        gc.stage.addChild(gc.ts);
                     }
                  }
                  else
                  {
                     zbmc1.addChild(sobj);
                     this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                  }
               }
               else if(zbmc2.numChildren < 1)
               {
                  temp = zbmc1.getChildByName("curzb") as ShowObj;
                  if(temp)
                  {
                     if(temp.getMyEquipObj().getFillName() == sobj.getMyEquipObj().getFillName() && temp.getMyEquipObj().getMutiLevel() == sobj.getMyEquipObj().getMutiLevel())
                     {
                        zbmc2.addChild(sobj);
                        this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                     }
                     else
                     {
                        gc.ts.setTxt("重铸时主副装备必须同名");
                        gc.stage.addChild(gc.ts);
                     }
                  }
                  else
                  {
                     zbmc2.addChild(sobj);
                     this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                  }
               }
               break;
            case "zbsp":
               if(sobj.getMyEquipObj().getFillName().indexOf("wpsh") != -1)
               {
                  temp = shmc.getChildByName("curzb") as ShowObj;
                  if(temp)
                  {
                     shmc.removeChild(temp);
                     gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                  }
                  shmc.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               else if(sobj.getMyEquipObj().getFillName().indexOf("wpst") != -1)
               {
                  temp = stmc.getChildByName("curzb") as ShowObj;
                  if(temp)
                  {
                     stmc.removeChild(temp);
                     gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                  }
                  stmc.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               break;
            case "zbwp":
         }
         this.removedProduceEquipment();
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var temp:* = null;
         if(e.currentTarget.getChildByName("curzb") != null)
         {
            temp = e.currentTarget.getChildByName("curzb") as ShowObj;
            e.currentTarget.removeChild(temp);
            switch(temp.getMyEquipObj().type)
            {
               case "zbwq":
               case "zbfj":
               case "zbsp":
                  if(gc.allEquip.isTheSameEquipmentByFillName(temp.getMyEquipObj()))
                  {
                     this.player.zblist.push(temp.getMyEquipObj());
                  }
                  else
                  {
                     gc.ts.setTxt("不是同一个物品，请勿修改");
                     gc.stage.addChild(gc.ts);
                  }
                  break;
               case "zbfb":
                  gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                  break;
               case "zbwp":
            }
            temp = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function czClick(e:MouseEvent) : void
      {
         var eq2:* = null;
         var temp:* = null;
         var ary:* = null;
         var levMetEquip:* = null;
         if(this.player.getLhValue() < 10000)
         {
            gc.ts.setTxt("当前灵魂：" + this.player.getLhValue() + "，灵魂不足");
            gc.stage.addChild(gc.ts);
            return;
         }
         var eq1:ShowObj = this.zbmc1.getChildByName("curzb") as ShowObj;
         if(eq1)
         {
            eq2 = this.zbmc2.getChildByName("curzb") as ShowObj;
            if(eq2)
            {
               if(eq1.getMyEquipObj().getFillName() != eq2.getMyEquipObj().getFillName() || eq1.getMyEquipObj().getMutiLevel() != eq2.getMyEquipObj().getMutiLevel())
               {
                  gc.ts.setTxt("重铸时主副装备必须同名");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               temp = this.shmc.getChildByName("curzb") as ShowObj;
               if(temp)
               {
                  levMetEquip = gc.allEquip.findByName("wpsh_" + (eq1.getMyEquipObj().getMutiLevel() + 1));
                  ary = temp.getMyEquipObj().getFillName().split("_");
                  if(int(ary[1]) != eq1.getMyEquipObj().getMutiLevel() + 1)
                  {
                     gc.ts.setTxt("需要使用" + levMetEquip.ename);
                     gc.stage.addChild(gc.ts);
                     return;
                  }
                  temp = this.stmc.getChildByName("curzb") as ShowObj;
                  if(temp)
                  {
                     levMetEquip = gc.allEquip.findByName("wpst_" + (eq1.getMyEquipObj().getMutiLevel() + 1));
                     ary = temp.getMyEquipObj().getFillName().split("_");
                     if(int(ary[1]) != eq1.getMyEquipObj().getMutiLevel() + 1)
                     {
                        gc.ts.setTxt("需要使用" + levMetEquip.ename);
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                     this.afterDoProduce();
                     ary = null;
                     temp = null;
                     return;
                  }
                  gc.ts.setTxt("缺少神铁材料");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               gc.ts.setTxt("缺少神火材料");
               gc.stage.addChild(gc.ts);
               return;
            }
            return;
         }
      }
      
      private function afterDoProduce() : void
      {
         this.player.setLhValue(this.player.getLhValue() - 10000);
         StrengthEquipment(this.parent).setTxtlh();
         var eq1:ShowObj = this.zbmc1.getChildByName("curzb") as ShowObj;
         var produceEquip1:MyEquipObj = eq1.getMyEquipObj();
         if(produceEquip1.getMutiLevel() < 10)
         {
            produceEquip1.setMutiLevel(produceEquip1.getMutiLevel() + 1);
         }
         var prosobj1:ShowObj = new ShowObj(produceEquip1);
         this.produce.addChild(prosobj1);
         gc.ts.setTxt("重铸成功");
         gc.stage.addChild(gc.ts);
         this.getAndRemovedEquip();
      }
      
      private function getAndRemovedEquip() : void
      {
         this.removeThreeObj();
         this.getProduce();
      }
      
      private function removeThreeObj() : void
      {
         var sobj:ShowObj = this.zbmc1.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.zbmc1.removeChild(sobj);
         }
         sobj = this.zbmc2.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.zbmc2.removeChild(sobj);
         }
         sobj = this.shmc.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.shmc.removeChild(sobj);
         }
         sobj = this.stmc.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.stmc.removeChild(sobj);
         }
         sobj = null;
      }
      
      private function getProduce() : void
      {
         var sobj:ShowObj = this.produce.getChildByName("curzb") as ShowObj;
         if(sobj != null)
         {
            if(sobj.getMyEquipObj().type == "zbfb" || sobj.getMyEquipObj().type == "zbwq" || sobj.getMyEquipObj().type == "zbfj" || sobj.getMyEquipObj().type == "zbsp" || sobj.getMyEquipObj().type == "zbtx")
            {
               this.player.zblist.push(sobj.getMyEquipObj());
            }
            else if(sobj.getMyEquipObj().type == "zbsz")
            {
               this.player.szlist.push(sobj.getMyEquipObj());
            }
            sobj = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function removedSelf() : void
      {
         this.removedProduceEquipment();
         var sobj:ShowObj = this.zbmc1.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
            {
               this.zbmc1.removeChild(sobj);
               this.player.zblist.push(sobj.getMyEquipObj());
               sobj = null;
            }
            else
            {
               gc.ts.setTxt("不是同一个物品，请勿修改");
               gc.stage.addChild(gc.ts);
            }
         }
         sobj = this.zbmc2.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
            {
               this.zbmc2.removeChild(sobj);
               this.player.zblist.push(sobj.getMyEquipObj());
               sobj = null;
            }
            else
            {
               gc.ts.setTxt("不是同一个物品，请勿修改");
               gc.stage.addChild(gc.ts);
            }
         }
         sobj = this.shmc.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.shmc.removeChild(sobj);
            gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
         }
         sobj = this.stmc.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            this.stmc.removeChild(sobj);
            gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
         }
         sobj = null;
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function removedProduceEquipment() : void
      {
         var temp:* = null;
         if(this.produce.getChildByName("curzb") != null)
         {
            temp = produce.getChildByName("curzb") as ShowObj;
            produce.removeChild(temp);
            temp = null;
         }
      }
      
      private function removeEquipFormBack(equip:MyEquipObj, pack:int) : void
      {
         var sit:int = 0;
         if(pack == 1)
         {
            sit = this.player.zblist.indexOf(equip);
            if(sit != -1)
            {
               this.player.zblist.splice(sit,1);
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
         else if(pack == 3)
         {
            sit = this.player.szlist.indexOf(equip);
            if(sit != -1)
            {
               this.player.szlist.splice(sit,1);
            }
         }
         else if(pack == 4)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.jnslist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.jnslist.splice(sit,1);
               }
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function transformMutiLev(lev:int) : String
      {
         switch(int(lev) - 1)
         {
            case 0:
               return "一重";
            case 1:
               return "二重";
            case 2:
               return "三重";
            case 3:
               return "四重";
            case 4:
               return "五重";
            case 5:
               return "六重";
            case 6:
               return "七重";
            case 7:
               return "八重";
            case 8:
               return "九重";
            case 9:
               return "十重";
            default:
               return "";
         }
      }
   }
}
