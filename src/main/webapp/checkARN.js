
function IsARN(arn){
	arn=arn.trim();
	var reg = new RegExp(/^[a-zA-Z]{4}\d{9}[A-Z0-9]{1}$/);     
    if(!reg.test(arn)){      
        return false;
     }  
    else{
	var realArn=arn.substring(0,arn.length-1);
	var goalcheckDigit=arn.substring(arn.length-1,arn.length)
     var arncheck=new ARNChecking();
	 arncheck.checkARN(realArn);
     //alert(goalcheckDigit+"=="+arncheck.checkDigit);
if(goalcheckDigit==arncheck.checkDigit)	{
	return true;
}else 
	{
	return false;
	}
    }
}

function ARNChecking(){
	this.prefixLen = 4;
	this.arnoLen = 7;
	this.suffixLen = 2;
	this.modulus = 17;
	this.factor = 14;
	this.DTYPE_DIGIT_ONLY = 0;
	this.DTYPE_LETTER_ONLY = 1;
	this.DTYPE_LETTER_DIGIT = 2;
	this.prefix_t="";
	this.arno_t="";
	this.suffix_t="";
	this.checkDigit='';
	this.checkARN=function(arn)
	{
		var pf="", an="", sf="";

		var pfStart = 0;
		var anStart = pfStart+this.prefixLen;
		var sfStart = anStart+this.arnoLen;

		pf = arn.substring(pfStart,anStart);
		an = arn.substring(anStart,sfStart);
		sf = arn.substring(sfStart);

		this.init(pf, an, sf);
	}
	this.init=function(prefix, arno, suffix)
	{
		var sum1 = this.caculate(prefix, this.factor, this.DTYPE_LETTER_ONLY);
		var  sum2 = this.caculate(arno, this.factor-this.prefixLen, this.DTYPE_DIGIT_ONLY);
		var sum3 = this.caculate(suffix, this.factor-this.prefixLen-this.arnoLen, this.DTYPE_DIGIT_ONLY);

		if (sum1==-1 || sum2==-1){  alert("the arn has  error");return false ;}
		else {
			this.prefix_t = prefix.toUpperCase();

			this.arno_t = arno;
			this.suffix_t = suffix;
			if (sum3==-1) {
				this.checkDigit = ' ';
			}
			else {
				var cd = (this.modulus - (sum1+sum2+sum3)%this.modulus);
				this.checkDigit = this.getLetter(cd, this.modulus);
			}
		}


	}
	this.caculate=function( number, factor,  dataType)
	{
		var sum = 0;

		for (var i=0; i<number.length ; i++, factor--) {

			var  c = number.charAt(i);
			switch (dataType) {
			case this.DTYPE_LETTER_DIGIT: if (!this.isLetterOrDigit(c)) return -1; else break;
			case this.DTYPE_LETTER_ONLY: if (!this.isLetter(c)) return -1; else break;
			case this.DTYPE_DIGIT_ONLY: if (!this.isDigit(c)) return -1; else break;
			default: return -1;
			}

			sum += (this.getDigit(c)*factor);

		} 

		return sum;

	}
	this.getLetter=function(i,  mod) {
		if (i > 9 && i < mod) return String.fromCharCode((('A').charCodeAt() + i - 10));
		else if (i == mod) return '0';
		else return String.fromCharCode(('0').charCodeAt() + i);
	}
	this.getDigit=function(c) {
		if (this.isDigit(c)) {

			return c.charCodeAt() - ('0').charCodeAt();
		}
		else {

			return c.toUpperCase().charCodeAt() - ('A').charCodeAt() + 10;
		}
	}
	this.isDigit=function(c)
	{

		var Regx=/^\d{1}$/;
		if(Regx.test(c))
		{ 

			return true;
		}
		else
		{
			return false;
		}
	}

	this.isLetterOrDigit=function(c)
	{
		var Regx = /^[A-Za-z0-9]{1}$/;
		if (Regx.test(c)) {
			return true;
		}
		else {
			return false;
		}
	}

	this.isLetter=function(c)
	{
		var Regx = /^[A-Za-z]{1}$/;
		if (Regx.test(c)) {
			return true;
		}
		else {
			return false;
		}
	}


}