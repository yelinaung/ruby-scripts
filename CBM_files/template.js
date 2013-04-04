/**
* -------------------------------------------
*   Helper Functions
* -------------------------------------------
*/

/******* To Usable JSON and POST together *******/
$.extend({
   postJSON: function( url, data, callback){
      return jQuery.post(url, data, callback, "json");
   }
});
/********* end **********/

/****** equlize column heights plugin  ******/
$(document).ready(function() {
  var $els = $(".well").equalizeCols();  
  var $els = $(".equal").equalizeCols();  
  
  //var $els = $(".sidebar,.content").equalizeCols();  
  
       // testing the menu active
     /*var href = location.href;
  
     $('a').each(function(index) {
         
     if(href == $(this).attr('href'))
     {
         console.log(href);
         console.log($(this).attr('href'));
         $(this).parent().addClass("active");
     }
  });*/

});
/********** end **********/


function checkAll(n) {
    
    for(i=0; i<n; i ++){
        
        if($("#chkall").attr("checked"))
        {
            $("#chk_"+i).attr("checked",'checked');
            
        }
        else{
            $("#chk_"+i).removeAttr("checked",'');
        }
    }
    
}     
    

   
    
    


