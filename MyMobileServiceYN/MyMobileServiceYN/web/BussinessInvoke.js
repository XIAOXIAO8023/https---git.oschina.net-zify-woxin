(
    function(window, undefined) 
       {
	       function Business ()
	       {	   
	           this.O2String =  O2String; 	   
	    	   //转换string
	    	   function O2String(O) {

	   		    var S = [];
	   		    var J = "";
	   		    if (Object.prototype.toString.apply(O) === '[object Array]') {
	   		        for (var i = 0; i < O.length; i++)
	   		            S.push(O2String(O[i]));
	   		        J = '[' + S.join(',') + ']';
	   		    }
	   		    else if (Object.prototype.toString.apply(O) === '[object Date]') {
	   		        J = "new Date(" + O.getTime() + ")";
	   		    }
	   		    else if (Object.prototype.toString.apply(O) === '[object RegExp]' || Object.prototype.toString.apply(O) === '[object Function]') {
	   		        J = O.toString();
	   		    }
	   		    else if (Object.prototype.toString.apply(O) === '[object Object]') {
	   		        for (var i in O) {
	   		            var tmp = typeof (O[i]) == 'string' ? '"' + O[i] + '"' : (typeof (O[i]) === 'object' ? O2String(O[i]) : O[i]);
	   		            S.push('"' + i + '"' + ':' + tmp);
	   		        }
	   		        J = '{' + S.join(',') + '}';
	   		    } else if (Object.prototype.toString.apply(O) === '[object Number]') {
	   		    	J = O.toString();
	   		    } else if (Object.prototype.toString.apply(O) === '[object String]') {
	   		    	J = '"' + O + '"';
	   		    }

	   		    return J;
	   		};
	    	  //回调
	    	  this.callBack = function(obj) {};
	    	  this.usercallBack = function(obj) {this.error_reason = "undefined user call back.";};
	    	  this.invokeAPK = function(obj,callBack)
	    	   {
	    		  var arg = this.O2String(obj);
	    		  this.usercallBack = callBack;
	    		  javascript:sdkInterface.invokeAPK(arg,callBack);
	    	   }; 	    	   
	    	   //apk调用js
	    	   this.invokeJS = function(jsonstr)
	    	   {
	    		   var obj = eval("("+jsonstr+")");
	    		   this.usercallBack(obj);
	    		   	    		   
	    	   };
	       	   
	       }
           window.business = new Business();
           window.invokeJS = function(jsonstr) 
           {
       	       window.business.invokeJS(jsonstr);
       	   };
       }
)(window);