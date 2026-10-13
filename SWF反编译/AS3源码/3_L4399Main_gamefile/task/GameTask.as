package task
{
   import base.BaseMonster;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import export.monster.Monster189;
   import export.monster.Monster205;
   import flash.utils.getQualifiedClassName;
   
   public class GameTask
   {
       
      
      private var dayTask:Array;
      
      private var actTask:Array;
      
      private var rewTask:Array;
      
      private var dtask1:Task;
      
      private var dtask2:Task;
      
      private var dtask3:Task;
      
      private var dtask4:Task;
      
      private var dtask5:Task;
      
      private var dtask6:Task;
      
      private var dtask7:Task;
      
      private var dtask8:Task;
      
      private var dtask9:Task;
      
      private var dtask10:Task;
      
      private var dtask11:Task;
      
      private var dtask12:Task;
      
      private var dtask13:Task;
      
      private var dtask14:Task;
      
      private var dtask15:Task;
      
      private var dtask16:Task;
      
      private var dtask17:Task;
      
      private var dtask18:Task;
      
      private var dtask19:Task;
      
      private var dtask20:Task;
      
      private var dtask21:Task;
      
      private var dtask22:Task;
      
      private var dtask23:Task;
      
      private var dtask24:Task;
      
      private var dtask25:Task;
      
      private var dtask26:Task;
      
      private var dtask27:Task;
      
      private var dtask28:Task;
      
      private var dtask29:Task;
      
      private var dtask30:Task;
      
      private var dtask31:Task;
      
      private var dtask32:Task;
      
      private var dtask33:Task;
      
      private var dtask34:Task;
      
      private var dtask35:Task;
      
      private var dtask36:Task;
      
      private var dtask37:Task;
      
      private var atask1:Task;
      
      private var atask2:Task;
      
      private var atask3:Task;
      
      private var atask4:Task;
      
      private var atask5:Task;
      
      private var atask6:Task;
      
      private var atask7:Task;
      
      private var atask8:Task;
      
      private var rewtask1:Task;
      
      private var rewtask2:Task;
      
      private var rewtask3:Task;
      
      private var rewtask4:Task;
      
      private var _anti:Antiwear;
      
      public function GameTask()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this._anti.one = 1;
         this._anti.five = 5;
         this._anti.dary1 = [{
            "name":"黑龟",
            "mname":"Monster8",
            "neednum":50,
            "curhas":0
         }];
         this._anti.rary1 = [{
            "type":"zzs",
            "value":"w-h-g-z-z-s",
            "cname":"尾火棍制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"lh",
            "value":"2-5-0",
            "cname":"灵魂"
         }];
         this._anti.dary2 = [{
            "name":"黑虎",
            "mname":"Monster7",
            "neednum":50,
            "curhas":0
         }];
         this._anti.rary2 = [{
            "type":"zzs",
            "value":"j-m-c-z-z-s",
            "cname":"角木铲制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"lh",
            "value":"2-5-0",
            "cname":"灵魂"
         }];
         this._anti.dary3 = [{
            "name":"黑龟",
            "mname":"Monster8",
            "neednum":25,
            "curhas":0
         },{
            "name":"巫鹰",
            "mname":"Monster3",
            "neednum":25,
            "curhas":0
         }];
         this._anti.rary3 = [{
            "type":"zzs",
            "value":"b-s-p-z-z-s",
            "cname":"壁水袍制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"lh",
            "value":"2-5-0",
            "cname":"灵魂"
         }];
         this._anti.dary4 = [{
            "name":"黑虎",
            "mname":"Monster7",
            "neednum":25,
            "curhas":0
         },{
            "name":"巫鹰",
            "mname":"Monster3",
            "neednum":25,
            "curhas":0
         }];
         this._anti.rary4 = [{
            "type":"zzs",
            "value":"d-t-k-z-z-s",
            "cname":"氐土铠制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"lh",
            "value":"2-5-0",
            "cname":"灵魂"
         }];
         this._anti.dary5 = [{
            "name":"天兵(斧)",
            "mname":"Monster18",
            "neednum":50,
            "curhas":0
         },{
            "name":"天兵(刀)",
            "mname":"Monster9",
            "neednum":50,
            "curhas":0
         }];
         this._anti.rary5 = [{
            "type":"zzs",
            "value":"w-t-p-z-z-s",
            "cname":"胃土耙制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"6-0-0",
            "cname":"经验"
         }];
         this._anti.dary6 = [{
            "name":"天兵(棒)",
            "mname":"Monster17",
            "neednum":50,
            "curhas":0
         },{
            "name":"天兵(枪)",
            "mname":"Monster10",
            "neednum":50,
            "curhas":0
         }];
         this._anti.rary6 = [{
            "type":"zzs",
            "value":"y-h-j-z-z-s",
            "cname":"翼火甲制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"6-0-0",
            "cname":"经验"
         }];
         this._anti.dary7 = [{
            "name":"天兵(斧)",
            "mname":"Monster18",
            "neednum":50,
            "curhas":0
         },{
            "name":"天兵(弓)",
            "mname":"Monster19",
            "neednum":50,
            "curhas":0
         }];
         this._anti.rary7 = [{
            "type":"zzs",
            "value":"j-m-y-z-z-s",
            "cname":"井木衣制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"6-0-0",
            "cname":"经验"
         }];
         this._anti.dary8 = [{
            "name":"牛妖",
            "mname":"Monster1",
            "neednum":100,
            "curhas":0
         },{
            "name":"蛇妖",
            "mname":"Monster13",
            "neednum":100,
            "curhas":0
         }];
         this._anti.rary8 = [{
            "type":"zzs",
            "value":"h-l-j-h-z-z-s",
            "cname":"红莲教皇制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary9 = [{
            "name":"狗妖",
            "mname":"Monster11",
            "neednum":100,
            "curhas":0
         },{
            "name":"蜈蚣精",
            "mname":"Monster14",
            "neednum":100,
            "curhas":0
         }];
         this._anti.rary9 = [{
            "type":"zzs",
            "value":"w-s-j-g-z-z-s",
            "cname":"顽石金刚制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary10 = [{
            "name":"羊妖",
            "mname":"Monster12",
            "neednum":100,
            "curhas":0
         },{
            "name":"蜈蚣精",
            "mname":"Monster14",
            "neednum":100,
            "curhas":0
         }];
         this._anti.rary10 = [{
            "type":"zzs",
            "value":"y-d-j-g-z-z-s",
            "cname":"银弹金弓制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary11 = [{
            "name":"土行孙",
            "mname":"Monster35",
            "neednum":10,
            "curhas":0
         }];
         this._anti.rary11 = [{
            "type":"zzs",
            "value":"x-l-t-c-z-z-s",
            "cname":"天残制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary12 = [{
            "name":"土行孙",
            "mname":"Monster35",
            "neednum":10,
            "curhas":0
         }];
         this._anti.rary12 = [{
            "type":"zzs",
            "value":"x-l-y-j-z-z-s",
            "cname":"犹绝制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary13 = [{
            "name":"雷震子",
            "mname":"Monster36",
            "neednum":5,
            "curhas":0
         }];
         this._anti.rary13 = [{
            "type":"zzs",
            "value":"x-l-t-h-z-z-s",
            "cname":"天荒制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary14 = [{
            "name":"雷震子",
            "mname":"Monster36",
            "neednum":5,
            "curhas":0
         }];
         this._anti.rary14 = [{
            "type":"zzs",
            "value":"x-l-r-y-z-z-s",
            "cname":"如狱制作书"
         },{
            "type":"bs",
            "value":"1",
            "cname":"宝石"
         },{
            "type":"exp",
            "value":"2-0-0-0",
            "cname":"经验"
         }];
         this._anti.dary15 = [{
            "name":"穷奇",
            "mname":"Monster42",
            "neednum":1,
            "curhas":0
         },{
            "name":"涛杌",
            "mname":"Monster47",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary15 = [{
            "type":"gmcs",
            "value":this._anti.five + "",
            "cname":"神秘商店购买次数"
         }];
         this._anti.dary17 = [{
            "name":"罗宣",
            "mname":"Monster111",
            "neednum":3,
            "curhas":0
         }];
         this._anti.rary17 = [{
            "type":"pet_equip",
            "value":"p-_-c-y-m-z",
            "cname":"赤烟头盔"
         },{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         }];
         this._anti.dary18 = [{
            "name":"花豹圣者",
            "mname":"Monster118",
            "neednum":3,
            "curhas":0
         }];
         this._anti.rary18 = [{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         },{
            "type":"pet_equip",
            "value":"p-_-c-y-x-z",
            "cname":"赤烟战靴"
         }];
         this._anti.dary19 = [{
            "name":"穷奇",
            "mname":"Monster42",
            "neednum":2,
            "curhas":0
         }];
         this._anti.rary19 = [{
            "type":"gmcs",
            "value":this._anti.five + "",
            "cname":"神秘商店购买次数"
         },{
            "type":"dj",
            "value":"wpbsz-2",
            "cname":"避水珠x2"
         }];
         this._anti.dary20 = [{
            "name":"涛杌",
            "mname":"Monster47",
            "neednum":2,
            "curhas":0
         }];
         this._anti.rary20 = [{
            "type":"gmcs",
            "value":this._anti.five + "",
            "cname":"神秘商店购买次数"
         },{
            "type":"dj",
            "value":"wplvdyl-2",
            "cname":"龙女的眼泪x2"
         }];
         this._anti.dary21 = [{
            "name":"混沌",
            "mname":"Monster60",
            "neednum":2,
            "curhas":0
         }];
         this._anti.rary21 = [{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         },{
            "type":"zb",
            "value":"x-h-h-l",
            "cname":"宣花葫芦"
         }];
         this._anti.dary22 = [{
            "name":"银角大王",
            "mname":"Monster53",
            "neednum":1,
            "curhas":0
         },{
            "name":"金角大王",
            "mname":"Monster54",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary22 = [{
            "type":"dj",
            "value":"wpsmd1-1",
            "cname":"一品生命丹"
         },{
            "type":"dj",
            "value":"wpsmd2-1",
            "cname":"二品生命丹"
         }];
         this._anti.dary23 = [{
            "name":"青牛精",
            "mname":"Monster58",
            "neednum":2,
            "curhas":0
         },{
            "name":"太白金星",
            "mname":"Monster64",
            "neednum":2,
            "curhas":0
         }];
         this._anti.rary23 = [{
            "type":"dj",
            "value":"wpsmd2-1",
            "cname":"二品生命丹"
         },{
            "type":"dj",
            "value":"wpsmd3-1",
            "cname":"三品生命丹"
         }];
         this._anti.dary24 = [{
            "name":"太上老君",
            "mname":"Monster65",
            "neednum":3,
            "curhas":0
         }];
         this._anti.rary24 = [{
            "type":"dj",
            "value":"smbjns2-1",
            "cname":"水魔爆2级技能书"
         },{
            "type":"dj",
            "value":"mmwjns2-1",
            "cname":"木魔舞2级技能书"
         },{
            "type":"dj",
            "value":"hyjjjns2-1",
            "cname":"火眼金睛2级技能书"
         },{
            "type":"dj",
            "value":"syzqjns2-1",
            "cname":"圣域之墙2级技能书"
         }];
         this._anti.dary25 = [{
            "name":"狻猊圣者",
            "mname":"Monster120",
            "neednum":3,
            "curhas":0
         }];
         this._anti.rary25 = [{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         },{
            "type":"pet_equip",
            "value":"p-_-c-y-h-h",
            "cname":"辉煌"
         }];
         this._anti.dary26 = [{
            "name":"狴犴圣者",
            "mname":"Monster125",
            "neednum":3,
            "curhas":0
         }];
         this._anti.rary26 = [{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         },{
            "type":"pet_equip",
            "value":"p-_-c-y-k-x",
            "cname":"抗性"
         }];
         this._anti.dary27 = [{
            "name":"轸宿",
            "mname":"Monster140",
            "neednum":1,
            "curhas":0
         },{
            "name":"翼宿",
            "mname":"Monster142",
            "neednum":1,
            "curhas":0
         },{
            "name":"张宿",
            "mname":"Monster144",
            "neednum":1,
            "curhas":0
         },{
            "name":"星宿",
            "mname":"Monster146",
            "neednum":1,
            "curhas":0
         },{
            "name":"柳宿",
            "mname":"Monster147",
            "neednum":1,
            "curhas":0
         },{
            "name":"鬼宿",
            "mname":"Monster149",
            "neednum":1,
            "curhas":0
         },{
            "name":"井宿",
            "mname":"Monster150",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary27 = [{
            "type":"lhjl",
            "value":this._anti.one + "",
            "cname":"烈火精灵"
         },{
            "type":"bxjl",
            "value":this._anti.one + "",
            "cname":"冰雪精灵"
         }];
         this._anti.dary28 = [{
            "name":"壁宿",
            "mname":"Monster151",
            "neednum":1,
            "curhas":0
         },{
            "name":"室宿",
            "mname":"Monster152",
            "neednum":1,
            "curhas":0
         },{
            "name":"危宿",
            "mname":"Monster156",
            "neednum":1,
            "curhas":0
         },{
            "name":"虚宿",
            "mname":"Monster157",
            "neednum":1,
            "curhas":0
         },{
            "name":"女宿",
            "mname":"Monster158",
            "neednum":1,
            "curhas":0
         },{
            "name":"牛宿",
            "mname":"Monster159",
            "neednum":1,
            "curhas":0
         },{
            "name":"斗宿",
            "mname":"Monster162",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary28 = [{
            "type":"gsjl",
            "value":this._anti.one + "",
            "cname":"钢石精灵"
         }];
         this._anti.dary29 = [{
            "name":"金吒",
            "mname":"Monster137",
            "neednum":1,
            "curhas":0
         },{
            "name":"木吒",
            "mname":"Monster134",
            "neednum":1,
            "curhas":0
         },{
            "name":"哪吒",
            "mname":"Monster128",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary29 = [{
            "type":"dj",
            "value":"wpst_2-1",
            "cname":"二重神铁·甲麟"
         }];
         this._anti.dary30 = [{
            "name":"穷奇",
            "mname":"Monster42",
            "neednum":1,
            "curhas":0
         },{
            "name":"涛杌",
            "mname":"Monster47",
            "neednum":1,
            "curhas":0
         },{
            "name":"混沌",
            "mname":"Monster60",
            "neednum":1,
            "curhas":0
         },{
            "name":"饕餮",
            "mname":"Monster115",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary30 = [{
            "type":"dj",
            "value":"wpsh_3-1",
            "cname":"三重神火·洪荒"
         }];
         this._anti.dary31 = [{
            "name":"沙僧",
            "mname":"Monster32",
            "neednum":1,
            "curhas":0
         },{
            "name":"八戒",
            "mname":"Monster33",
            "neednum":1,
            "curhas":0
         },{
            "name":"唐僧",
            "mname":"Monster31",
            "neednum":1,
            "curhas":0
         },{
            "name":"悟空",
            "mname":"Monster34",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary31 = [{
            "type":"ymjl",
            "value":this._anti.one + "",
            "cname":"炎马精灵"
         }];
         this._anti.dary32 = [{
            "name":"碧霄",
            "mname":"Monster135",
            "neednum":1,
            "curhas":0
         },{
            "name":"琼宵",
            "mname":"Monster131",
            "neednum":1,
            "curhas":0
         },{
            "name":"云霄",
            "mname":"Monster139",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary32 = [{
            "type":"dj",
            "value":"kly2-1",
            "cname":"2级昆仑玉x1"
         },{
            "type":"dj",
            "value":"xns2-1",
            "cname":"2级仙女石x1"
         }];
         this._anti.dary33 = [{
            "name":"赤月神君",
            "mname":"Monster205",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary33 = [{
            "type":"dj",
            "value":"wpsh_2-1",
            "cname":"二重神火·玄黯x1"
         },{
            "type":"dj",
            "value":"wpsh_3-1",
            "cname":"三重神火·洪荒x1"
         },{
            "type":"dj",
            "value":"wpsh_4-1",
            "cname":"四重神火·生杀x1"
         },{
            "type":"dj",
            "value":"wpsh_5-1",
            "cname":"五重神火·噬灵x1"
         }];
         this._anti.dary34 = [{
            "name":"紫眸鹫王",
            "mname":"Monster207",
            "neednum":1,
            "curhas":0
         },{
            "name":"紫睛鹏王",
            "mname":"Monster210",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary34 = [{
            "type":"dj",
            "value":"wpst_1-1",
            "cname":"一重神铁·轻羽"
         },{
            "type":"dj",
            "value":"wpst_2-1",
            "cname":"二重神铁·甲麟"
         },{
            "type":"dj",
            "value":"wpst_3-1",
            "cname":"三重神铁·点金"
         }];
         this._anti.dary35 = [{
            "name":"千年蜈蚣",
            "mname":"Monster203",
            "neednum":1,
            "curhas":0
         },{
            "name":"千年妖蝉",
            "mname":"Monster189",
            "neednum":1,
            "curhas":0
         },{
            "name":"千年蚊妖",
            "mname":"Monster186",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary35 = [{
            "type":"dj",
            "value":"ttslsp1-1",
            "cname":"通天赦令碎片一"
         },{
            "type":"dj",
            "value":"ttslsp2-1",
            "cname":"通天赦令碎片二"
         },{
            "type":"dj",
            "value":"ttslsp3-1",
            "cname":"通天赦令碎片三"
         }];
         this._anti.dary36 = [{
            "name":"白水神君",
            "mname":"Monster209",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary36 = [{
            "type":"exp",
            "value":"1-5-0-0-0-0",
            "cname":"15w经验"
         }];
         this._anti.dary37 = [{
            "name":"青阳神君",
            "mname":"Monster213",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rary37 = [{
            "type":"exp",
            "value":"1-8-0-0-0-0",
            "cname":"18w经验"
         }];
         this._anti.reary1 = [{
            "name":"二郎神",
            "mname":"Monster138",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rreary1 = [{
            "type":"level",
            "value":this._anti.one + "",
            "cname":"等级上限"
         },{
            "type":"gmcs",
            "value":this._anti.five + "",
            "cname":"神秘商店购买次数"
         },{
            "type":"dj",
            "value":"wpygs-1",
            "cname":"摇光石x1"
         },{
            "type":"dj",
            "value":"rls-1",
            "cname":"熔炼石x1"
         }];
         this._anti.reary2 = [{
            "name":"妲己",
            "mname":"Monster180",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rreary2 = [{
            "type":"level",
            "value":this._anti.one + "",
            "cname":"等级上限"
         },{
            "type":"dj",
            "value":"kly2-1",
            "cname":"2级昆仑玉x1"
         },{
            "type":"dj",
            "value":"kly3-1",
            "cname":"3级昆仑玉x1"
         },{
            "type":"dj",
            "value":"xns2-1",
            "cname":"2级仙女石x1"
         },{
            "type":"dj",
            "value":"xns3-1",
            "cname":"3级仙女石x1"
         }];
         this._anti.reary3 = [{
            "name":"黑衣人",
            "mname":"Monster215",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rreary3 = [{
            "type":"level",
            "value":this._anti.one + "",
            "cname":"等级上限"
         },{
            "type":"dj",
            "value":"lxzhs-1",
            "cname":"流邪转换石x1"
         },{
            "type":"dj",
            "value":"sxzhs-1",
            "cname":"沙邪转换石x1"
         }];
         this._anti.reary4 = [{
            "name":"琵琶精",
            "mname":"Monster216",
            "neednum":1,
            "curhas":0
         }];
         this._anti.rreary4 = [{
            "type":"level",
            "value":this._anti.one + "",
            "cname":"等级上限"
         },{
            "type":"qhd",
            "value":this._anti.five + "",
            "cname":"强化点数"
         },{
            "type":"gmcs",
            "value":this._anti.five + "",
            "cname":"神秘商店购买次数"
         },{
            "type":"dj",
            "value":"wpygs-1",
            "cname":"摇光石x1"
         },{
            "type":"dj",
            "value":"rls-1",
            "cname":"熔炼石x1"
         }];
         this._anti.aary1 = [{
            "type":"dj",
            "value":"mpyj-1",
            "cname":"孟婆药剂"
         }];
         this._anti.aary2 = [{
            "type":"roomhorse",
            "value":this._anti.one + "",
            "cname":"炎马"
         }];
         this._anti.aary3 = [{
            "type":"dj",
            "value":"wpst_1-1",
            "cname":"一重神铁·轻羽"
         }];
         this._anti.aary4 = [{
            "type":"dj",
            "value":"wpsh_1-1",
            "cname":"一重神火·骨凝"
         }];
         this._anti.aary5 = [{
            "type":"dj",
            "value":"wpcsd-1",
            "cname":"长生丹"
         },{
            "type":"dj",
            "value":"wphhd-1",
            "cname":"还魂丹"
         }];
         this._anti.arry6Monster = [{
            "name":"黑衣人",
            "mname":"Monster215",
            "neednum":1,
            "curhas":0
         }];
         this._anti.aary6 = [{
            "type":"zb",
            "value":"_-j-s-y-x-p-t",
            "cname":"救世英雄"
         }];
         this._anti.aary7 = [{
            "type":"zb",
            "value":"_-j-s-y-x-p-t",
            "cname":"救世英雄"
         }];
         this._anti.aary8 = [{
            "type":"zb",
            "value":"_-z-m-s-z-n-t-x",
            "cname":"三周年头衔"
         }];
         this._anti.aary8Monster = [{
            "name":"牛魔王",
            "mname":"Monster105",
            "neednum":1,
            "curhas":0
         },{
            "name":"转轮王",
            "mname":"Monster109",
            "neednum":1,
            "curhas":0
         },{
            "name":"二郎神",
            "mname":"Monster22",
            "neednum":1,
            "curhas":0
         }];
         this.newAllTask();
      }
      
      public function newAllTask() : void
      {
         var i:* = 0;
         dayTask = null;
         actTask = null;
         rewTask = null;
         dayTask = [];
         actTask = [];
         rewTask = [];
         dtask1 = new Task(1,"袭天的妖怪1","击败黑龟50只！",this._anti.dary1,this._anti.rary1);
         dtask2 = new Task(2,"袭天的妖怪2","击败黑虎50只！",this._anti.dary2,this._anti.rary2);
         dtask3 = new Task(3,"袭天的妖怪3","击败黑龟与巫鹰各25只！",this._anti.dary3,this._anti.rary3);
         dtask4 = new Task(4,"袭天的妖怪4","击败黑虎与巫鹰各25只！",this._anti.dary4,this._anti.rary4);
         dtask5 = new Task(5,"反叛的天兵1","击败天兵(斧)与天兵(刀)各50只！",this._anti.dary5,this._anti.rary5);
         dtask6 = new Task(6,"反叛的天兵2","击败天兵(棒)与天兵(枪)各50只！",this._anti.dary6,this._anti.rary6);
         dtask7 = new Task(7,"反叛的天兵3","击败天兵(斧)与天兵(弓)各50只！",this._anti.dary7,this._anti.rary7);
         dtask8 = new Task(8,"梅山的余党1","击败牛妖与蛇妖各100只！",this._anti.dary8,this._anti.rary8);
         dtask9 = new Task(9,"梅山的余党2","击败狗妖与蜈蚣精各100只！",this._anti.dary9,this._anti.rary9);
         dtask10 = new Task(10,"梅山的余党3","击败羊妖与蜈蚣精各100只！",this._anti.dary10,this._anti.rary10);
         dtask11 = new Task(11,"冲上宝塔1","击败10次土行孙！",this._anti.dary11,this._anti.rary11);
         dtask12 = new Task(12,"冲上宝塔2","击败10次土行孙！",this._anti.dary12,this._anti.rary12);
         dtask13 = new Task(13,"冲上宝塔3","击败5次雷震子！",this._anti.dary13,this._anti.rary13);
         dtask14 = new Task(14,"冲上宝塔4","击败5次雷震子！",this._anti.dary14,this._anti.rary14);
         dtask17 = new Task(17,"挑战焰中仙","在截教天境火龙岛击败罗宣3次",this._anti.dary17,this._anti.rary17);
         dtask18 = new Task(18,"九龙岛四圣1","在截教天境九龙岛击败花豹圣者3次",this._anti.dary18,this._anti.rary18);
         dtask19 = new Task(19,"铲除凶兽1","在神兽森林击败穷奇2次",this._anti.dary19,this._anti.rary19);
         dtask20 = new Task(20,"铲除凶兽2","在神兽森林击败涛杌2次",this._anti.dary20,this._anti.rary20);
         dtask21 = new Task(21,"铲除凶兽3","在神兽森林击败混沌2次",this._anti.dary21,this._anti.rary21);
         dtask22 = new Task(22,"智取丹药1","在兜率宫击败金角大王与银角大王各1次",this._anti.dary22,this._anti.rary22);
         dtask23 = new Task(23,"智取丹药2","在兜率宫击败青牛精与太白金星各2次",this._anti.dary23,this._anti.rary23);
         dtask24 = new Task(24,"智取丹药3","在兜率宫击败太上老君3次",this._anti.dary24,this._anti.rary24);
         dtask25 = new Task(25,"九龙岛四圣2","在截教天境龙脊山击败狻猊圣者3次",this._anti.dary25,this._anti.rary25);
         dtask26 = new Task(26,"九龙岛四圣3","在截教天境妖尾林击败狴犴圣者3次",this._anti.dary26,this._anti.rary26);
         dtask27 = new Task(27,"朱雀阵","在28星宿阵里击败南方七宿",this._anti.dary27,this._anti.rary27);
         dtask28 = new Task(28,"玄武阵","在28星宿阵里击败北方七宿",this._anti.dary28,this._anti.rary28);
         dtask29 = new Task(29,"叱咤风云","在挑战三太子中，击败金吒、木吒、哪吒",this._anti.dary29,this._anti.rary29);
         dtask30 = new Task(30,"凶兽反扑","击败四大凶兽各1次",this._anti.dary30,this._anti.rary30);
         dtask31 = new Task(31,"邪恶流沙","在流沙河击败邪英雄各一次",this._anti.dary31,this._anti.rary31);
         dtask32 = new Task(32,"三霄娘娘","击败碧霄、琼宵、云霄各一次",this._anti.dary32,this._anti.rary32);
         dtask33 = new Task(33,"绝仙烈火","击败赤月神君一次",this._anti.dary33,this._anti.rary33);
         dtask34 = new Task(34,"紫晶双鸟","击败紫眸鹫王、紫睛鹏王各一次",this._anti.dary34,this._anti.rary34);
         dtask35 = new Task(35,"千年老妖","击败千年蜈蚣、千年妖蝉、千年蚊妖各一只",this._anti.dary35,this._anti.rary35);
         dtask36 = new Task(36,"戮仙白水","击败白水神君",this._anti.dary36,this._anti.rary36);
         dtask37 = new Task(37,"陷仙青阳","击败青阳神君",this._anti.dary37,this._anti.rary37);
         for(i = uint(1); i <= 14; )
         {
            this.dayTask.push(this["dtask" + i]);
            i++;
         }
         this.dayTask.push(dtask37,dtask36,dtask35,dtask34,dtask33,dtask32,dtask31,dtask30,dtask29,dtask28,dtask27,dtask18,dtask25,dtask26,dtask17,dtask19,dtask20,dtask21,dtask22,dtask23,dtask24);
         atask1 = new Task(17,"英雄试炼一","角色达到10级",[],this._anti.aary1);
         atask2 = new Task(18,"英雄试炼二","角色达到50级，并拥有通天令牌",[],this._anti.aary2);
         atask3 = new Task(19,"英雄试炼三","角色达到80级",[],this._anti.aary3);
         atask4 = new Task(20,"英雄试炼四","并拥有通天赦令",[],this._anti.aary4);
         atask5 = new Task(21,"锄禾日当午","药园土地庙等级达到4级",[],this._anti.aary5);
         atask6 = new Task(22,"英雄救世1","在截教天境绝境宫里击败黑衣人",this._anti.arry6Monster,this._anti.aary6);
         atask7 = new Task(23,"我不入地狱","拥有流邪、沙邪、渊邪三件法宝",[],this._anti.aary7);
         atask8 = new Task(24,"击败三大魔王","击败牛魔王、 转轮王、 二郎神各一只",this._anti.aary8Monster,this._anti.aary8);
         actTask.push(atask8,atask1,atask2,atask3,atask4,atask5,atask6,atask7);
         rewtask1 = new Task(500,"悬赏二郎神","凌霄宝殿一役后，杨戬下落不明。势必问清截教天境幕后主使与玉帝真正下落。二郎神藏身天庭2-9关，击败各关BOSS逼出二郎神下落，建议60级后接此任务。",this._anti.reary1,this._anti.rreary1,false);
         rewtask2 = new Task(501,"悬赏妲己","妲己为首的轩辕坟三妖，闯入月宫，绑走嫦娥。势必通缉妲己，救出嫦娥。妲己藏身于截教天境1-7关，击败各关BOSS逼出妲己下落。建议70级后接此任务。",this._anti.reary2,this._anti.rreary2,false);
         rewtask3 = new Task(502,"悬赏黑衣人","绝境宫一役后，敌人更加扑朔迷离。势必在碧游宫中，在找出黑衣人的下落。黑衣人藏身于碧游宫，击败各关BOSS逼出黑衣人。建议80级后接此任务。",this._anti.reary3,this._anti.rreary3,false);
         rewtask4 = new Task(503,"悬赏琵琶精","轩辕坟三妖之一琵琶精，闯入月宫，绑走嫦娥。势必通缉琵琶精，救出嫦娥。琵琶精藏身于截教天境1-7关，击败各关BOSS逼出琵琶精下落。建议70级后接此任务。",this._anti.reary4,this._anti.rreary4,false);
         rewTask.push(rewtask1,rewtask2,rewtask3,rewtask4);
      }
      
      public function getTaskByTaskName() : Task
      {
         return null;
      }
      
      public function hasReciveTaskByName() : Boolean
      {
         return false;
      }
      
      public function getdayTask(lev:uint) : Array
      {
         var curAry:Array = [];
         if(lev >= 50)
         {
            curAry.push(dtask37,dtask36,dtask35,dtask34,dtask33,dtask32,dtask31,dtask30,dtask29,dtask28,dtask27,dtask18,dtask25,dtask26,dtask17);
         }
         if(lev >= 40)
         {
            curAry.push(dtask22,dtask23,dtask24);
         }
         if(lev >= 30)
         {
            curAry.push(dtask19,dtask20,dtask21);
         }
         if(lev >= 20)
         {
            curAry.push(dtask11,dtask12,dtask13,dtask14);
         }
         if(lev >= 10)
         {
            curAry.push(dtask8,dtask9,dtask10);
         }
         if(lev >= 5)
         {
            curAry.push(dtask5,dtask6,dtask7);
         }
         if(lev >= 1)
         {
            curAry.push(dtask1,dtask2,dtask3,dtask4);
         }
         return curAry;
      }
      
      public function getactTask() : Array
      {
         return this.actTask;
      }
      
      public function getrewTask() : Array
      {
         return this.rewTask;
      }
      
      public function getMonsterBirth() : Object
      {
         var ary:* = null;
         var bobj:Object = {};
         var rlen:uint = this.rewTask.length;
         for each(var rt in this.rewTask)
         {
            if(rt.getIsaccept() && !rt.getIsComplete())
            {
               ary = rt.getRandomAry();
               bobj.stage = ary[0];
               bobj.level = ary[1];
               bobj.time = ary[2];
               bobj.mname = rt.getMonsterByRwId();
               return bobj;
            }
         }
         return null;
      }
      
      public function hasAnyRewardTask() : Boolean
      {
         var _bool:Boolean = false;
         for each(var rt in this.rewTask)
         {
            if(rt.getIsaccept() && !rt.getIsComplete())
            {
               _bool = true;
               break;
            }
         }
         return _bool;
      }
      
      public function getRewardTaskMonsterName() : String
      {
         var mname:String = "";
         for each(var rt in this.rewTask)
         {
            if(rt.getIsaccept() && !rt.getIsComplete())
            {
               mname = rt.getBossChinaName();
               break;
            }
         }
         return mname;
      }
      
      public function killMonster(bm:BaseMonster) : void
      {
         var i:* = 0;
         var j:* = 0;
         var mname:String = getQualifiedClassName(bm);
         var tAry:Array = mname.split("::");
         mname = tAry[1];
         if(bm is Monster205)
         {
            if(!(bm as Monster205).isCall)
            {
               return;
            }
         }
         if(bm is Monster189)
         {
            if((bm as Monster189).isFenshen)
            {
               return;
            }
         }
         var dlen:uint = this.dayTask.length;
         for(i = uint(0); i < dlen; )
         {
            if(!this.dayTask[i].judgeNeed(mname))
            {
            }
            i++;
         }
         var alen:uint = this.actTask.length;
         for(j = uint(0); j < alen; )
         {
            if(!this.actTask[j].judgeNeed(mname))
            {
            }
            j++;
         }
      }
      
      public function killRewardMonster(mname:String) : void
      {
         for(var rlen:uint = this.rewTask.length; rlen-- > 0; )
         {
            if(this.rewTask[rlen].judgeNeed(mname))
            {
               return;
            }
         }
      }
      
      public function saveAllTask() : String
      {
         var alltask:String = "";
         for(var dlen:uint = this.dayTask.length; dlen-- > 0; )
         {
            alltask += Task(this.dayTask[dlen]).getSave();
            if(dlen != 0)
            {
               alltask += "}";
            }
         }
         return alltask;
      }
      
      public function saveActionTask() : String
      {
         var actString:String = "";
         for(var alen:uint = this.actTask.length; alen-- > 0; )
         {
            actString += Task(this.actTask[alen]).getSave();
            if(alen != 0)
            {
               actString += "}";
            }
         }
         return actString;
      }
      
      public function saveRewardTask() : String
      {
         var rewString:String = "";
         for(var rlen:uint = this.rewTask.length; rlen-- > 0; )
         {
            rewString += Task(this.rewTask[rlen]).getSave();
            if(rlen != 0)
            {
               rewString += "}";
            }
         }
         return rewString;
      }
      
      public function setAllTask(taskString:String) : void
      {
         var daylen:* = 0;
         var dayAry:Array = taskString.split("}");
         loop0:
         for(var dlen:uint = dayAry.length; dlen-- > 0; )
         {
            for(daylen = uint(this.dayTask.length); daylen-- > 0; )
            {
               if(Task(this.dayTask[daylen]).setSave(dayAry[dlen]))
               {
                  continue loop0;
               }
            }
         }
      }
      
      public function setActTask(taskString:String) : void
      {
         var actlen:* = 0;
         var actAry:Array = taskString.split("}");
         loop0:
         for(var alen:uint = actAry.length; alen-- > 0; )
         {
            for(actlen = uint(this.actTask.length); actlen-- > 0; )
            {
               if(Task(this.actTask[actlen]).setSave(actAry[alen]))
               {
                  continue loop0;
               }
            }
         }
      }
      
      public function setRewTask(taskString:String) : void
      {
         var rewlen:* = 0;
         var rewAry:Array = taskString.split("}");
         loop0:
         for(var rlen:uint = rewAry.length; rlen-- > 0; )
         {
            for(rewlen = uint(this.rewTask.length); rewlen-- > 0; )
            {
               trace("rewAry[rlen] -->>" + rewAry[rlen]);
               if(Task(this.rewTask[rewlen]).setSave(rewAry[rlen]))
               {
                  continue loop0;
               }
            }
         }
      }
   }
}
