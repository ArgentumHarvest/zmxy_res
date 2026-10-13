package vip
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.HeroSkillProtect;
   
   public class GameVip
   {
       
      
      public var dataObject:Antiwear;
      
      public var vipsavelist:Array;
      
      public var isToGetAllMoneyData:Boolean = false;
      
      public function GameVip()
      {
         super();
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.dataObject.paiedMoney = 0;
         this.dataObject.lastMoney = 0;
         this.dataObject.allMoney = 0;
         this.dataObject.vipLevel = -1;
         this.dataObject.targetNum = 0;
         vipsavelist = [false,0,false,0,false,0,0,0];
      }
      
      public function doWhenInitData() : void
      {
         this.dataObject.targetNum = 0;
         vipsavelist = [false,0,false,0,false,0,0,0];
      }
      
      public function getPaiedMoney() : void
      {
         trace("getPaiedMoney");
         if(GMain.serviceHold)
         {
            trace("getPaiedMoney send--");
            GMain.serviceHold.getTotalPaiedFun();
         }
      }
      
      public function setPaiedMoney(pm:int) : void
      {
         this.dataObject.paiedMoney = pm;
      }
      
      public function getLastMoney() : void
      {
         trace("getLastMoney");
         if(GMain.serviceHold)
         {
            trace("getLastMoney  send--");
            GMain.serviceHold.getBalance();
         }
      }
      
      public function getPlayerAllMoney() : void
      {
         trace("getPlayerAllMoney");
         if(GMain.serviceHold)
         {
            GMain.serviceHold.getTotalRechargedFun();
         }
      }
      
      public function setAllMoney(am:int) : void
      {
         this.isToGetAllMoneyData = true;
         this.dataObject.allMoney = am;
      }
      
      public function getAllMoney() : int
      {
         return this.dataObject.allMoney;
      }
      
      public function setLastMoney(lm:int) : void
      {
         this.dataObject.lastMoney = lm;
      }
      
      public function getVipLevel() : int
      {
         if(this.dataObject.allMoney < HeroSkillProtect.getInstance().vipConst.one_qian)
         {
            this.dataObject.vipLevel = 0;
         }
         else if(this.dataObject.allMoney >= HeroSkillProtect.getInstance().vipConst.one_qian && this.dataObject.allMoney < HeroSkillProtect.getInstance().vipConst.five_qian)
         {
            this.dataObject.vipLevel = 1;
         }
         else if(this.dataObject.allMoney >= HeroSkillProtect.getInstance().vipConst.five_qian && this.dataObject.allMoney < HeroSkillProtect.getInstance().vipConst.one_wan)
         {
            this.dataObject.vipLevel = 2;
         }
         else if(this.dataObject.allMoney >= HeroSkillProtect.getInstance().vipConst.one_wan && this.dataObject.allMoney < HeroSkillProtect.getInstance().vipConst.two_wan)
         {
            this.dataObject.vipLevel = 3;
         }
         else if(this.dataObject.allMoney >= HeroSkillProtect.getInstance().vipConst.two_wan && this.dataObject.allMoney < HeroSkillProtect.getInstance().vipConst.five_wan)
         {
            this.dataObject.vipLevel = 4;
         }
         else if(this.dataObject.allMoney >= HeroSkillProtect.getInstance().vipConst.five_wan)
         {
            this.dataObject.vipLevel = 5;
         }
         return this.dataObject.vipLevel;
      }
   }
}
