package export.huodong.newyear
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import petInfo.PetInfo;
   
   public class PCNewYearPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function PCNewYearPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong2.4399.com/2014/sjkfd/"),"_blank");
      }
      
      override protected function lqClick(e:MouseEvent) : void
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(gc.player1.plist.length >= 15)
            {
               str += "宠物装备栏已满  ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(gc.player2.plist.length >= 15)
               {
                  str += "宠物装备栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
            return;
         }
         super.lqClick(e);
      }
      
      override protected function getPresent(_result:uint) : void
      {
         if(_result == 307)
         {
            this.getPCNewYear();
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getPCNewYear() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNeatPet());
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNeatPet());
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         gc.ts.setTxt("成功领取 丑牛精灵X1、丑牛元帅X1、双倍经验丹X1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getNeatPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(200);
         pif.setatkQuality(1600);
         pif.setdefQuality(400);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
   }
}
