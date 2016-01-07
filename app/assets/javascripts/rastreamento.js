(function(){ 
var LogAcesso = function(documento){ 
	if(!(this instanceof LogAcesso)){ 
		return new LogAcesso(documento); 
	 }
	 
	 this.documento = documento;
	 this.cookieName = "visitante";
}
LogAcesso.fn = LogAcesso.prototype = {
	salvar: function(){
		var documento = this.documento;
		var guid = "";
		var local = documento.location.href;
		
		if($.cookie(this.cookieName)){
			guid = $.cookie(this.cookieName)
		}else{
			guid = this.gerarGuid();
			$.cookie(this.cookieName, guid);
		}
		
		$(documento).ready(function(){
			$.ajax({
				 data: {guid: guid, local: local},
				 url: "/logacesso/salvar",
				 type: "POST",
				 dataType: 'json'
			});
		});
	},
	
	gerarGuid: function(){
		var d = new Date().getTime();
		var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
			var r = (d + Math.random()*16)%16 | 0;
			d = Math.floor(d/16);
			return (c=='x' ? r : (r&0x3|0x8)).toString(16);
		});
		return uuid;
	}
}
//inicia
LogAcesso(document).salvar();
})();