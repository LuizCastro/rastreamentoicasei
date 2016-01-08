var Contato = {
	Enviar: function(form){
		var botaoEnviar = $("#botao-enviar");
		$.ajax({
            data: $(form).serialize(),
            url: $(form).attr("action"),
            type: "POST",
            beforeSend: function () {
                $(botaoEnviar).attr("disabled", "disabled");
            },
            success: function (result) {
				
				$(botaoEnviar).hide();
					$("#msg-erro").hide();
					$("#msg-sucesso").show();
            },
			error: function(result){
				$("#msg-sucesso").hide();
				$(botaoEnviar).removeAttr("disabled");
				$("#msg-erro").show();
				$("#msg-erro > span").html(result.responseJSON.errorMessage);
			}
        });
	}
};