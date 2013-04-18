var time_is_widget=new time_is_widget()
function time_is_widget(){var ca=0,tD=0,tout=0,updint=1000,tl="",u="undefined"
this.init=function(cl){if(tout!=0)clearInterval(time_is_widget.tout)
var i,j,q=[],c={"12hours":"%h",hours:"%H",minutes:"%i",seconds:"%s",AMPM:"%A"},ct="TIME",tF="hours:minutes:seconds"
for(i in cl){cl[i]["p"]=""
if(typeof cl[i]["id"]==u)cl[i]["id"]=i
if(typeof cl[i]["time_format"]!=u)tF=cl[i]["time_format"]
for(j in c)tF=tF.replace(j,c[j])
tl="http://time.is/"+i.substr(0,cl[i]["id"].indexOf("_z")).replace("__",",_");tF="<span onclick=\"window.location='"+tl.replace("'","\\\'")+"'\" title=\""+tl+'">'+tF+"</span>"
if(typeof cl[i]["contents"]!=u)ct=cl[i]["contents"]
cl[i]["contents"]=ct.replace("TIME",tF)
if(typeof cl[i]["v"]==u)q.push(cl[i]["id"])}
this.ca=cl
if(0<q.length)this.xSync(q)
else this.tick()}
this.xSync=function(q){document.scriptObj=document.createElement("script");document.scriptObj.setAttribute("src","http://widget.time.is/?"+encodeURIComponent(q.join(".."))+"&t="+new Date().getTime())
document.headLoc=document.getElementsByTagName("head").item(0);document.headLoc.appendChild(document.scriptObj);}
this.cb=function(t,r,a){var rpT=new Date(),n=0
time_is_widget.tD=rpT.getTime()-t-Math.round((rpT-r)/2)
for(i in this.ca){this.ca[i]["v"]=a[n]
n++}
this.tick()}
this.tick=function(){var tU=new Date(),t=new Date(),i,c
tU.setTime(tU.getTime()-this.tD)
if(document.getElementById)i=document.getElementById("time_is_link")
else i=eval("time_is_link")
if(null!=i&&i.href.indexOf("time.is/")!=-1)
for(i in this.ca){c=this.ca[i]
if(typeof c["v"][0]!="undefined"){if((0<c["v"][1])&&(c["v"][1]<tU.getTime())){c["v"][0]=c["v"][2]
c["v"][1]=0}
t.setTime(c["v"][0]*60000+tU.getTime())
var d,o,H,M="AM",h=t.getUTCHours()
h=l0(h)
H=h
if(11<h){M="PM"
h=l0(h-12)
if(h=="00")h=12}
d=c["contents"].replace("%h",h).replace("%H",H).replace("%i",l0(t.getUTCMinutes())).replace("%s",l0(t.getUTCSeconds())).replace("%A",M)
if(d!=c["p"]){if(document.getElementById)o=document.getElementById(i);else o=eval()
if(null!=o){o.innerHTML=d;c["p"]=d}}}if (typeof c["callback"]!=u) eval(c["callback"]+"("+d+")")}
tout=setTimeout('time_is_widget.tick("")',updint-tU%updint)}}
function l0(n){return n>9?n:"0"+n}