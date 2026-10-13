package config
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   
   public class HeroSkillProtect
   {
      
      static var instance:HeroSkillProtect;
       
      
      public var hero1Anti:Antiwear;
      
      public var hero2Anti:Antiwear;
      
      public var hero3Anti:Antiwear;
      
      public var hero4Anti:Antiwear;
      
      public var heroConst:Antiwear;
      
      public var vipConst:Antiwear;
      
      public var payConst:Antiwear;
      
      public function HeroSkillProtect()
      {
         hero1Anti = new Antiwear(new binaryEncrypt());
         hero2Anti = new Antiwear(new binaryEncrypt());
         hero3Anti = new Antiwear(new binaryEncrypt());
         hero4Anti = new Antiwear(new binaryEncrypt());
         heroConst = new Antiwear(new binaryEncrypt());
         vipConst = new Antiwear(new binaryEncrypt());
         payConst = new Antiwear(new binaryEncrypt());
         super();
         this.hero1Anti.hit6Beishu = 2;
         this.hero1Anti.hit7Beishu = 0.5;
         this.hero1Anti.hit8Beishu = 1.2;
         this.hero1Anti.hit8BeishuLevel2 = 1.8;
         this.hero1Anti.hit10_2Beishu = 1;
         this.hero1Anti.hit10_3Beishu = 0.8;
         this.hero1Anti.hit10_4Beishu = 5;
         this.hero1Anti.hit11Beishu = 0.3;
         this.hero1Anti.hit13Beishu = 0.24;
         this.hero1Anti.hit14Beishu = 5;
         this.hero1Anti.addPower1 = 1;
         this.hero1Anti.addPower1dian5 = 1.5;
         this.hero1Anti.critNum = 2;
         this.hero1Anti.critNormal = 1;
         this.hero2Anti.hit2Beishu = 0.2;
         this.hero2Anti.hit3Beishu = 0.8;
         this.hero2Anti.hit4Beishu = 8;
         this.hero2Anti.hit5Beishu = 2;
         this.hero2Anti.addPower1 = 1;
         this.hero2Anti.addPower1dian5 = 1.5;
         this.hero2Anti.addPower1dian3 = 1.3;
         this.hero2Anti.critNum = 2;
         this.hero2Anti.critNormal = 1;
         this.hero3Anti.hit4Beishu = 2;
         this.hero3Anti.hit7Beishu = 2;
         this.hero3Anti.hit9Beishu = 1.5;
         this.hero3Anti.hit11Beishu = 3;
         this.hero3Anti.hit11BeishuLevel2 = 4.5;
         this.hero3Anti.hit12Beishu = 0.5;
         this.hero3Anti.addPower1dian3 = 1.3;
         this.hero3Anti.addPower1 = 1;
         this.hero3Anti.addPower1dian5 = 1.5;
         this.hero3Anti.critNum = 2;
         this.hero3Anti.critNormal = 1;
         this.hero4Anti.hit3Shovel = 0.5;
         this.hero4Anti.hit4Shovel = 0.3;
         this.hero4Anti.hit7Shovel = 0.5;
         this.hero4Anti.hit8Shovel = 2;
         this.hero4Anti.hit9Shovel = 4;
         this.hero4Anti.hit9ShovelLevel2 = 6;
         this.hero4Anti.hit9ArrowLevel2 = 1.5;
         this.hero4Anti.hit10Shovel = 1.2;
         this.hero4Anti.hit12Shovel = 3;
         this.hero4Anti.hit4Arrow = 1.2;
         this.hero4Anti.hit8Arrow = 2;
         this.hero4Anti.hit10Arrow = 4;
         this.hero4Anti.hit12Arrow = 2;
         this.hero4Anti.addPower1 = 1;
         this.hero4Anti.addPower1dian5 = 1.5;
         this.hero4Anti.critNum = 2;
         this.hero4Anti.critNormal = 1;
         this.heroConst.wushi = 50;
         this.heroConst.bashi = 80;
         this.heroConst.ershi = 20;
         this.heroConst.shi = 10;
         this.heroConst.yibai = 100;
         this.heroConst.qishi = 70;
         this.heroConst.sanshi = 30;
         this.vipConst.one_qian = 1000;
         this.vipConst.five_qian = 5000;
         this.vipConst.one_wan = 10000;
         this.vipConst.two_wan = 20000;
         this.vipConst.five_wan = 50000;
         this.payConst.sanbai = 300;
         this.payConst.erbai = 200;
         this.payConst.yibai = 100;
      }
      
      public static function getInstance() : HeroSkillProtect
      {
         if(!instance)
         {
            instance = new HeroSkillProtect();
         }
         return instance;
      }
   }
}
