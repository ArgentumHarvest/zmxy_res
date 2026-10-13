package my
{
   public class AllEquipment
   {
       
      
      private var rudeEquipment:Array;
      
      private var normalEquipment:Array;
      
      private var excellentEquipment:Array;
      
      private var wellEquipment:Array;
      
      private var otherEquipment:Array;
      
      private var hdEquipment:Array;
      
      private var hd2Equipment:Array;
      
      private var rudeClothes:MyEquipObj;
      
      private var rudeStick:MyEquipObj;
      
      private var rudeCassock:MyEquipObj;
      
      private var rudeStaff:MyEquipObj;
      
      private var normalClothes:MyEquipObj;
      
      private var normalStick:MyEquipObj;
      
      private var normalCassock:MyEquipObj;
      
      private var normalStaff:MyEquipObj;
      
      private var excellentClothes:MyEquipObj;
      
      private var excellentStick:MyEquipObj;
      
      private var excellentCassock:MyEquipObj;
      
      private var excellentStaff:MyEquipObj;
      
      private var wellClothes:MyEquipObj;
      
      private var wellStick:MyEquipObj;
      
      private var wellCassock:MyEquipObj;
      
      private var wellStaff:MyEquipObj;
      
      private var otherEquip1:MyEquipObj;
      
      private var otherEquip2:MyEquipObj;
      
      private var otherEquip3:MyEquipObj;
      
      private var otherEquip4:MyEquipObj;
      
      private var otherEquip5:MyEquipObj;
      
      private var otherEquip6:MyEquipObj;
      
      private var otherEquip7:MyEquipObj;
      
      private var otherEquip8:MyEquipObj;
      
      private var otherEquip9:MyEquipObj;
      
      private var otherEquip10:MyEquipObj;
      
      private var otherEquip11:MyEquipObj;
      
      private var otherEquip12:MyEquipObj;
      
      private var otherEquip13:MyEquipObj;
      
      private var otherEquip14:MyEquipObj;
      
      private var otherEquip15:MyEquipObj;
      
      private var otherEquip16:MyEquipObj;
      
      private var otherEquip17:MyEquipObj;
      
      private var otherEquip18:MyEquipObj;
      
      private var otherEquip19:MyEquipObj;
      
      private var otherEquip20:MyEquipObj;
      
      private var otherEquip21:MyEquipObj;
      
      private var otherEquip22:MyEquipObj;
      
      private var huodong1:MyEquipObj;
      
      private var huodong2:MyEquipObj;
      
      private var huodong3:MyEquipObj;
      
      private var etj1:MyEquipObj;
      
      private var etj2:MyEquipObj;
      
      private var etj3:MyEquipObj;
      
      public function AllEquipment()
      {
         this.rudeEquipment = new Array();
         this.normalEquipment = new Array();
         this.excellentEquipment = new Array();
         this.wellEquipment = new Array();
         this.otherEquipment = new Array();
         this.hdEquipment = new Array();
         this.hd2Equipment = new Array();
         super();
      }
      
      public function newMyEquipObj() : void
      {
         this.rudeEquipment = null;
         this.normalEquipment = null;
         this.excellentEquipment = null;
         this.wellEquipment = null;
         this.otherEquipment = null;
         this.hdEquipment = null;
         this.rudeEquipment = new Array();
         this.normalEquipment = new Array();
         this.excellentEquipment = new Array();
         this.wellEquipment = new Array();
         this.otherEquipment = new Array();
         this.hdEquipment = new Array();
         this.rudeClothes = new MyEquipObj(2,"粗糙的行者服","ccxzf","zbfj","战士","粗 糙","0xCCCCCC",0,0,0,1,0,0,0,0,{},"");
         this.rudeStick = new MyEquipObj(2,"粗糙的行者棍","ccxzg","zbwq","战士","粗 糙","0xCCCCCC",0,0,2 + Math.round(Math.random() * 3),0,0,0,0,0,{},"");
         this.rudeCassock = new MyEquipObj(2,"粗糙的袈裟","ccjs","zbfj","法师","粗 糙","0xCCCCCC",0,0,0,1,0,0,0,0,{},"");
         this.rudeStaff = new MyEquipObj(2,"粗糙的松木杖","ccsmz","zbwq","法师","粗 糙","0xCCCCCC",0,0,2 + Math.round(Math.random() * 3),0,0,0,0,0,{},"");
         this.normalClothes = new MyEquipObj(2,"普通的行者服","ptxzf","zbfj","战士","普 通","0xFFFFFF",20 + Math.round(Math.random() * 20),20 + Math.round(Math.random() * 20),0,3,0,0,0,0,{},"");
         this.normalStick = new MyEquipObj(2,"普通的行者棍","ptxzg","zbwq","战士","普 通","0xFFFFFF",0,0,5 + Math.round(Math.random() * 10),0,0,0,0,0,{},"");
         this.normalCassock = new MyEquipObj(2,"普通的袈裟","ptjs","zbfj","法师","普 通","0xFFFFFF",20 + Math.round(Math.random() * 20),20 + Math.round(Math.random() * 20),0,2,0,0,0,0,{},"");
         this.normalStaff = new MyEquipObj(2,"普通的松木杖","ptsmz","zbwq","法师","普 通","0xFFFFFF",0,0,8 + Math.round(Math.random() * 8),0,0,0,0,0,{},"");
         this.excellentClothes = new MyEquipObj(3,"优秀的行者服","yxxzf","zbfj","战士","优 秀","0x00FF00",40 + Math.round(Math.random() * 30),40 + Math.round(Math.random() * 30),0,6,0,0,0,0,{},"");
         this.excellentStick = new MyEquipObj(3,"优秀的行者棍","yxxzg","zbwq","战士","优 秀","0x00FF00",0,0,10 + Math.round(Math.random() * 10),0,0,0,0,0,{},"");
         this.excellentCassock = new MyEquipObj(3,"优秀的袈裟","yxjs","zbfj","法师","优 秀","0x00FF00",40 + Math.round(Math.random() * 30),40 + Math.round(Math.random() * 30),0,3,0,0,0,0,{},"");
         this.excellentStaff = new MyEquipObj(3,"优秀的松木杖","yxsmz","zbwq","法师","优 秀","0x00FF00",0,0,16 + Math.round(Math.random() * 16),0,0,0,0,0,{},"");
         this.wellClothes = new MyEquipObj(3,"精良的行者服","jlxzf","zbfj","战士","精 良","0x0000FF",70 + Math.round(Math.random() * 40),70 + Math.round(Math.random() * 40),0,9,0,0,0,0,{},"");
         this.wellStick = new MyEquipObj(3,"精良的行者棍","jlxzg","zbwq","战士","精 良","0x0000FF",0,0,20 + Math.round(Math.random() * 10),0,0,0,0,0,{},"");
         this.wellCassock = new MyEquipObj(3,"精良的袈裟","jljs","zbfj","法师","精 良","0x0000FF",70 + Math.round(Math.random() * 40),70 + Math.round(Math.random() * 40),0,5,0,0,0,0,{},"");
         this.wellStaff = new MyEquipObj(3,"精良的松木杖","jlsmz","zbwq","法师","精 良","0x0000FF",0,0,32 + Math.round(Math.random() * 16),0,0,0,0,0,{},"");
         this.otherEquip1 = new MyEquipObj(1,"地煞灵戒","dslj","zbsp","","优 秀","0x00FF00",0,0,15,4,0.03,0.03,0,0,{},"聚万物之灵气，佩戴后来去通风，聆其音，知其前后，万物皆明");
         this.otherEquip6 = new MyEquipObj(4,"地煞猿甲","dsyj","zbfj","战士","优 秀","0x00FF00",80 + Math.round(Math.random() * 30),50 + Math.round(Math.random() * 20),0,4,0,0,0,0,{},"据说是通臂猿猴的战甲，染上了无法褪去的血迹和被遗忘的记忆");
         this.otherEquip7 = new MyEquipObj(4,"地煞权杖","dsqz","zbwq","法师","优 秀","0x00FF00",0,100,20,0,0,0,0,0,{},"权杖捆绑着上古遗骸，蕴藏驱神之力，挥舞间，兴云起雾，电闪雷鸣");
         this.otherEquip2 = new MyEquipObj(1,"天煞骨链","tsgl","zbsp","","精 良","0x0000FF",0,0,30 + Math.round(Math.random() * 10),10 + Math.round(Math.random() * 2),0.03,0.03,0,0,{},"用无数妖怪的骸骨熔炼的项链，月圆时会发出百兽的悲鸣");
         this.otherEquip8 = new MyEquipObj(6,"天煞羽袍","tsyp","zbfj","法师","精 良","0x0000FF",130 + Math.round(Math.random() * 20),260 + Math.round(Math.random() * 40),0,4,0,0,0,0,{},"传说由鲲鹏羽毛编织成的法袍，藏有无限的法力，穿上后腾云驾雾，翱翔云端");
         this.otherEquip9 = new MyEquipObj(4,"天煞月戟","tsyj","zbwq","战士","精 良","0x0000FF",0,0,50,0,0.03,0,0,0,{},"由月石经三味真火精炼而成，闪耀着黄金般的光芒，此光堪比皓月之明");
         this.otherEquip10 = new MyEquipObj(1,"血海妖壳","xhyk","zbsp","","精 良","0x0000FF",200 + Math.round(Math.random() * 30),0,0,20,0,0,2,0,{},"在血池里浸泡数载而出，坚如磐石，固若金汤");
         this.otherEquip11 = new MyEquipObj(6,"血海邪皇","xhxh","zbwq","法师","史 诗","0x660099",0,660,120,0,0,0,0,2,{},"吸取了血海里无数鲜血和冤魂妖化而成，诡异的妖杖散发着死亡的气息");
         this.otherEquip12 = new MyEquipObj(6,"血海魔甲","xhmj","zbfj","战士","史 诗","0x660099",0,0,80,-10,0.05,0.05,-2,0,{},"聚集了无数怨魂的怨气，闪烁着胆寒的光芒，给人撕心裂肺的绝望");
         this.otherEquip3 = new MyEquipObj(1,"七星守护","qxsh","zbsp","","史 诗","0x660099",0,0,60,12,0.05,0.05,2,2,{},"天枢、天璇、天玑、天权、玉衡、开阳、摇光，七星北斗，七星守护");
         this.otherEquip13 = new MyEquipObj(1,"锦襕袈裟","zljs","zbfj","法师","史 诗","0x660099",300,660,0,14,0,0,0,5,{},"");
         this.otherEquip14 = new MyEquipObj(7,"九环禅杖","jhcz","zbwq","法师","传 说","0xFF6600",450,900,170,0,0,0,0,5,{},"渡劫之日，三界俱灭，九环圣光，万物复苏");
         this.otherEquip15 = new MyEquipObj(1,"大圣战铠","dszk","zbfj","战士","史 诗","0x660099",500,330,0,30,0,0.1,0,0,{},"");
         this.otherEquip16 = new MyEquipObj(5,"如意金箍棒","ryjgb","zbwq","战士","传 说","0xFF6600",0,0,120,0,0.15,0,0,0,{},"东海龙宫之定海神针，一万三千五百斤，浩劫之际，元归齐天");
         this.otherEquip17 = new MyEquipObj(5,"白虎杖","bhz","zbwq","法师","精 良","0x0000FF",0,130,44,0,0,0,0,2,{},"传说由白虎的肋骨打制的法杖，施法时其疾如风，只见白虎之影");
         this.otherEquip18 = new MyEquipObj(6,"青龙刀","qld","zbwq","战士","精 良","0x0000FF",0,0,30,0,0.03,0,2,0,{},"传说由青龙的尖牙锻铸的大刀，挥舞间雷声贯耳，宛如青龙咆哮");
         this.otherEquip19 = new MyEquipObj(5,"玄武甲","xwj","zbfj","战士","精 良","0x0000FF",200,0,0,10,0,0,2,0,{},"传说由玄武的鳞片打造的战甲，装备后坚不可摧，呈现玄武防御之势");
         this.otherEquip20 = new MyEquipObj(5,"麒麟袍","qlp","zbfj","法师","精 良","0x0000FF",130,260,0,4,0,0,0,2,{},"传说由麒麟的绒毛编织的法袍，法力源源不绝，犹如麒麟附体");
         this.otherEquip5 = new MyEquipObj(1,"朱雀戒","zqj","zbsp","","精 良","0x0000FF",0,0,20,10,0.02,0.02,1,1,{},"传说由朱雀的内丹熔炼的戒指，佩戴完攻击大增，朱雀般华丽");
         this.otherEquip4 = new MyEquipObj(1,"家传手镯","jcsz","zbsp","","优 秀","0x00FF00",0,0,15,4,0,0,0,0,{},"看似普通的手镯，蕴藏有神秘的力量，只有凑齐家传装备才能释放出这股力量");
         this.otherEquip21 = new MyEquipObj(7,"家传宝剑","jcbj","zbwq","战士","优 秀","0x00FF00",0,0,15,0,0.03,0,0,0,{},"看似普通的宝剑，蕴藏有神秘的力量，只有凑齐家传装备才能释放出这股力量");
         this.otherEquip22 = new MyEquipObj(4,"家传衣裳","jcys","zbfj","法师","优 秀","0x00FF00",80,80,0,4,0,0,0,0,{},"看似普通的衣裳，蕴藏有神秘的力量，只有凑齐家传装备才能释放出这股力量");
         this.huodong1 = new MyEquipObj(1,"东海旗幡","dhqf","zbfb","","优 秀","0x00FF00",20 + Math.round(Math.random() * 80),20 + Math.round(Math.random() * 80),10 + Math.round(Math.random() * 30),0,0,0,0,0,{},"");
         this.huodong2 = new MyEquipObj(1,"金钢琢","jgz","zbfb","","史 诗","0x660099",0,0,50 + Math.round(Math.random() * 30),0,0.02 + Number((Math.random() * 0.03).toFixed(2)),0,2 + Math.round(Math.random() * 3),0,{},"");
         this.huodong3 = new MyEquipObj(1,"黄金赦令","hjsl","zbfb","","传说","0xFF6600",100,100,88,0,0.05,0.05,2,2,{},"");
         this.rudeEquipment.push(this.rudeClothes,this.rudeStick,this.rudeCassock,this.rudeStaff);
         this.normalEquipment.push(this.normalClothes,this.normalStick,this.normalCassock,this.normalStaff);
         this.excellentEquipment.push(this.excellentClothes,this.excellentStick,this.excellentCassock,this.excellentStaff);
         this.wellEquipment.push(this.wellClothes,this.wellStick,this.wellCassock,this.wellStaff);
         var _loc1_:uint = 0;
         while(_loc1_ < 22)
         {
            this.otherEquipment.push(this["otherEquip" + (_loc1_ + 1)]);
            _loc1_++;
         }
         this.hdEquipment.push(this.huodong1,this.huodong2,this.huodong3);
      }
      
      public function findByName(param1:String) : MyEquipObj
      {
         var _loc2_:uint = this.rudeEquipment.length;
         while(_loc2_-- > 0)
         {
            if(param1 == this.rudeEquipment[_loc2_].fillName)
            {
               return this.rudeEquipment[_loc2_];
            }
         }
         var _loc3_:uint = this.normalEquipment.length;
         while(_loc3_-- > 0)
         {
            if(param1 == this.normalEquipment[_loc3_].fillName)
            {
               return this.normalEquipment[_loc3_];
            }
         }
         var _loc4_:uint = this.excellentEquipment.length;
         while(_loc4_-- > 0)
         {
            if(param1 == this.excellentEquipment[_loc4_].fillName)
            {
               return this.excellentEquipment[_loc4_];
            }
         }
         var _loc5_:uint = this.wellEquipment.length;
         while(_loc5_-- > 0)
         {
            if(param1 == this.wellEquipment[_loc5_].fillName)
            {
               return this.wellEquipment[_loc5_];
            }
         }
         var _loc6_:uint = this.otherEquipment.length;
         while(_loc6_-- > 0)
         {
            if(param1 == this.otherEquipment[_loc6_].fillName)
            {
               return this.otherEquipment[_loc6_];
            }
         }
         var _loc7_:uint = this.hdEquipment.length;
         while(_loc7_-- > 0)
         {
            if(param1 == this.hdEquipment[_loc7_].fillName)
            {
               return this.hdEquipment[_loc7_];
            }
         }
         var _loc8_:uint = this.hd2Equipment.length;
         while(_loc8_-- > 0)
         {
            if(param1 == this.hd2Equipment[_loc8_].fillName)
            {
               return this.hd2Equipment[_loc8_];
            }
         }
         return null;
      }
      
      public function initHouDong(param1:uint) : void
      {
         this.hd2Equipment = null;
         this.hd2Equipment = new Array();
         if(param1 < 7)
         {
            this.etj1 = new MyEquipObj(8,"童年的拨浪鼓","tndblg","zbwq","法师","传 说","0xFF6600",0,0,2 * param1 * (param1 - 1) + Math.round(Math.random() * 4 * param1),0,0,0,0,0,{},"");
            this.etj2 = new MyEquipObj(8,"童年的冰糖葫芦","tndbthl","zbwq","战士","传 说","0xFF6600",0,0,2 * param1 * param1 - 5 * param1 + 3 + Math.round(Math.random() * (4 * param1 - 3)),0,0,0,0,0,{},"");
            this.etj3 = new MyEquipObj(1,"招财铃铛","zcld","zbfb","","传 说","0xFF6600",(30 + Math.round(Math.random() * 20)) * param1,(30 + Math.round(Math.random() * 20)) * param1,0,0,0,0,0,0,{},"");
         }
         else
         {
            this.etj1 = new MyEquipObj(8,"童年的拨浪鼓","tndblg","zbwq","法师","传 说","0xFF6600",0,0,2 * param1 * (param1 - 1) + Math.round(Math.random() * 4 * param1),0,0,0,0,2 + Math.round(Math.random() * 4),{},"");
            this.etj2 = new MyEquipObj(8,"童年的冰糖葫芦","tndbthl","zbwq","战士","传 说","0xFF6600",0,0,2 * param1 * param1 - 5 * param1 + 3 + Math.round(Math.random() * (4 * param1 - 3)),0,Number((0.03 + Math.random() * 0.07).toFixed(2)),0,0,0,{},"");
            this.etj3 = new MyEquipObj(1,"招财铃铛","zcld","zbfb","","传 说","0xFF6600",(30 + Math.round(Math.random() * 20)) * param1,(30 + Math.round(Math.random() * 20)) * param1,0,0,0,0,2 + Math.round(Math.random() * 4),0,{},"");
         }
         this.hd2Equipment.push(this.etj1,this.etj2,this.etj3);
      }
   }
}
