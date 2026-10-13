package AssetsClass
{
   import export.huodong.newyear.ChineseNewYear2016;
   
   public class NewYear2014Assets extends BaseAssets
   {
       
      
      public function NewYear2014Assets(_today:String)
      {
         super(ChineseNewYear2016,[_today]);
         this.loadAssets(["NewYear2014v2010.swf"]);
      }
   }
}
