<%@ include file="/pages/template/taglibs.jsp" %>
<s:url action="producto_loadFilterProducto" namespace="/" var="loadFilterProducto" />
<s:url action="egresoProducto_save" namespace="/" var="save" />
<s:url action="getJSONAlertas_verificarAlertas" namespace="/" var="verificarAlertas" />
<s:url action="jsonCliente_getNombreCliente" namespace="/" var="getNombreCliente" />

  <script type="text/javascript">
  	$(document).ready(function(){

  		$("#importe").focus();

  		$("#importe").keyup(function(){
  	  		var valorActual = $(this).val().length;
  	  		var importe =  parseFloat($(this).val());
  	  	  	var total = parseFloat($("#total").val());
  	  	  	if(valorActual>0){
  	  	  		var vuelto =(importe-total).toFixed(2);
  		  		$("#vueltoDisabled").val(vuelto);
  		  		$("#cambio").val(vuelto);
  	  	  	}
  	  	  	else{
  	  	  		$("#vueltoDisabled").val('0.00');
  	  	  		$("#cambio").val('0.00');	
  	  	  	}
  		});
  		
  		  		
  		$("#importeCtaCte").keyup(function(){
  	  		var valorActual = $(this).val().length;
  	  		var importeCtaCte =  parseFloat($(this).val());
  	  	  	var total = parseFloat($("#total").val());
  	  	  	if(valorActual>0){
  	  	  		var saldo =(total-importeCtaCte).toFixed(2);
  		  		$("#saldoCtaCteDisabled").val(saldo);
  		  		$("#saldoCtaCte").val(vuelto);
  	  	  	}
  	  	  	else{
  	  	  		$("#saldoCtaCteDisabled").val('0.00');
  	  	  		$("#saldoCtaCte").val('0.00');	
  	  	  	}
  		});
  		  		
  		
  	
  		
  		$('select').on('change', function() {
  		  
  			if(this.value==1){
  				 				
  				$('#divContadoImporte').show();
  				$('#divContadoCambio').show();
  				
  				$('#divDebitoImporte').hide();
  				
  				$('#divNumeroTarjetaCredito').hide(); 
  				$('#divTarjetaCreditoImporte').hide(); 
  				
  				$('#divNombreCliente').hide(); 
  				$('#divCtaCteImporte').hide(); 
  				$('#divCtaCteSaldo').hide();
  				
  				$("#importe").focus();
  				$("#importe").val('');
  				$("#cambio").val('');
  				
  				$("#importe").prop('required',true);
  				$("#importeDebito").prop('required',false);
	    		$("#numeroTarjetaCredito").prop('required',false);
	    		$("#importeTarjetaCreditoValue").prop('required',false);
	    		$("#nombreClienteValue").prop('required',false);
	    		$("#importeCtaCte").prop('required',false);
  				
  			  
  		  	}
  		  	else if(this.value==2){
  		  		
  		  		$('#divContadoImporte').hide();
				$('#divContadoCambio').hide();
				
				$('#divDebitoImporte').show();
				
				$('#divNumeroTarjetaCredito').hide(); 
				$('#divTarjetaCreditoImporte').hide(); 
				
				$('#divNombreCliente').hide(); 
				$('#divCtaCteImporte').hide(); 
				$('#divCtaCteSaldo').hide();
				
				$("#importeDebito").focus();
				$("#importeDebito").val($("#total").val());
				
				$("#importe").prop('required',false);
				$("#importeDebito").prop('required',true);
	    		$("#numeroTarjetaCredito").prop('required',false);
	    		$("#importeTarjetaCreditoValue").prop('required',false);
	    		$("#nombreClienteValue").prop('required',false);
	    		$("#importeCtaCte").prop('required',false);
				  			  
  		  	}
  		  	else if(this.value==3){
  		  		
  		  		$('#divContadoImporte').hide();
				$('#divContadoCambio').hide();
				
				$('#divDebitoImporte').hide();
				
				$('#divNumeroTarjetaCredito').show(); 
				$('#divTarjetaCreditoImporte').show(); 
				
				$('#divNombreCliente').hide(); 
				$('#divCtaCteImporte').hide(); 
				$('#divCtaCteSaldo').hide();
				
				$('#numeroTarjetaCredito').focus();
				$("#importeTarjetaCreditoValue").val($("#total").val());
				
				$("#importe").prop('required',false);
	    		$("#importeDebito").prop('required',false);
	    		$("#numeroTarjetaCredito").prop('required',true);
	    		$("#importeTarjetaCreditoValue").prop('required',true);
	    		$("#nombreClienteValue").prop('required',false);
	    		$("#importeCtaCte").prop('required',false);
		  
		  	}
  		  	else{
  		  		$('#divContadoImporte').hide();
				$('#divContadoCambio').hide();
				
				$('#divDebitoImporte').hide();
				
				$('#divNumeroTarjetaCredito').hide(); 
				$('#divTarjetaCreditoImporte').hide(); 
				
				$('#divNombreCliente').show(); 
				$('#divCtaCteImporte').show(); 
				$('#divCtaCteSaldo').show();
				
				$('#nombreClienteValue').focus();
				$("#importeCtaCte").val('');
				$("#saldoCtaCteDisabled").val($("#total").val());
  	  	  		$("#saldoCtaCte").val($("#total").val());
  	  	  		
  	  	  		$("#importe").prop('required',false);
    			$("#importeDebito").prop('required',false);
    			$("#numeroTarjetaCredito").prop('required',false);
    			$("#importeTarjetaCreditoValue").prop('required',false);
    			$("#nombreClienteValue").prop('required',true);
	    		$("#importeCtaCte").prop('required',true);
  		  	}	
  			
  		});
  		
  		
  		$("#nombreClienteValue").autocomplete({
			dataType : 'json',
			source: '${getNombreCliente}',
			minLength: 3,
			focus: function( event, ui ) {
				$("#nombreClienteValue").val(ui.item.apellido);
	        	return false;
	      	},
	      	select: function( event, ui ) {
	        	$("#nombreClienteValue").val(ui.item.apellido);
	        	$("#idCliente").val(ui.item.id);
	        	
	        	return false;
	      	} 
		}).data("ui-autocomplete")._renderItem = function( ul, item ) {
            return $( "<li>" )
            .append( "<a>"+ item.apellido + "-" + item.nombres + "</a>" )
            .appendTo( ul );
        };


  		// submmit del filtro de busqueda de productos
  		var optionsFilter = { 
			    target:     '#resultado', 
			    url:        '${save}', 
			    beforeSubmit:  function(){
			    	$("#divImporteProducto").block({ message: '<h5><img src="${appCtx}/images/loading.gif"/> Procesando...</h5>' });
				},
			    success: function(){ 
					
  					changeLinksPagination('resultado','filterForm');
  					$("a:contains('Ultima')").click();

  					//esto quita el checked del radio button de la pantalla egresos
  					$("input:checked").each(function(){
  						$(this).removeAttr('checked');
  					});
  								
  					$.ajax({
  						url: '${verificarAlertas}',
  						cache: false,
  						type:  'GET',
  						dataType: 'json',
  						success:  function(data){
  							if(data==="si") {
  								$("#alerta").show(2000);
  							}
  							divImporteProducto.dialog('destroy').remove();
  		  		  			divEgresoProducto.dialog('destroy').remove();	
  						}
  				    });
			    } 
		};
  	
  		$('#formImporteProducto').submit(function() {
  	        $(this).ajaxSubmit(optionsFilter);
  	        return false;
  	    });

  	    

  		/*$("#aceptar").click(function(){
  			$.ajax({
  				url: '${save}',
  				cache: false,
  				type:  'get',
  				beforeSend: function () {
  					$("#divImporteProducto").block({ message: '<h5><img src="${appCtx}/images/loading.gif"/> Actualizando stock...</h5>' });
  				},
  				success:  function (response) {

  					$("#resultado").html(response);
  					changeLinksPagination('resultado','filterForm');
  					$("a:contains('Ultima')").click();

  					//esto quita el checked del radio button de la pantalla egresos
  					$("input:checked").each(function(){
  						$(this).removeAttr('checked');
  					});
  								
  					$.ajax({
  						url: '${verificarAlertas}',
  						cache: false,
  						type:  'GET',
  						dataType: 'json',
  						success:  function(data){
  							if(data==="si") {
  								$("#alerta").show(2000);
  							}
  							divImporteProducto.dialog('destroy').remove();
  		  		  			divEgresoProducto.dialog('destroy').remove();	
  						}
  				    });
  				}
  		    });
  		});*/
  		
 	});
  	
   </script>
	<s:form id="formImporteProducto" theme="simple"  cssClass="form-horizontal" role="form">
		<s:hidden id="cambio" name="cambio" value=""/>
		<s:hidden id="saldoCtaCte" name="saldoCtaCte" value=""/>
		<s:hidden id="idCliente" name="idCliente" value=""/>
				 			
  		<div class="form-group">
    		<label for="total" class="col-md-4 col-lg-4 control-label">Total a cobrar $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="total"  name="totalVenta" value="${totalVenta}" disabled="disabled">
    		</div>
  		</div>
  		<br><br>
  		<div class="form-group">
    		<label for="formaDePago" class="col-md-4 col-lg-4 control-label">Forma de pago</label>
    		<div class="col-md-5 col-lg-5">
 				<s:select 
					list="listaFormaDePago" 
					listKey="id"   
        			listValue="nombre"
        			id="formaDePago"
					name="formaDePago" 
					value="defaultFormaDePago" theme="simple" cssClass="form-control"/>	
      		</div>
  		</div>
  		
  		<div id="divContadoImporte" class="form-group">
    		<label for="importe" class="col-md-4 col-lg-4 control-label">Pago con $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="importe"  name="importe" value="" onkeypress="validaSoloNumerosConPunto();" required>
    		</div>
  		</div>
  		<div id="divContadoCambio" class="form-group">
    		<label for="vueltoDisabled" class="col-md-4 col-lg-4 control-label">Cambio $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="vueltoDisabled"  name="vueltoDisabled" value="" disabled="disabled">
    		</div>
  		</div>
  		
  		
  		<div id="divDebitoImporte" class="form-group" style="display:none;">
    		<label for="importeDebito" class="col-md-4 col-lg-4 control-label">Importe $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="importeDebito"  name="importeDebito" value="" onkeypress="validaSoloNumerosConPunto();">
    		</div>
  		</div>
  		
  		
  		<div id="divNumeroTarjetaCredito" class="form-group" style="display:none;">
    		<label for="numeroTarjetaCredito" class="col-md-4 col-lg-4 control-label">Num de Tarjeta</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="numeroTarjetaCredito"  name="numeroTarjetaCredito" value="" onkeypress="validaSoloNumeros();" maxlength="16">
    		</div>
  		</div>
  		<div id="divTarjetaCreditoImporte" class="form-group" style="display:none;">
    		<label for="importeTarjetaCreditoValue" class="col-md-4 col-lg-4 control-label">Importe $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="importeTarjetaCreditoValue"  name="importeTarjetaCreditoValue" value="" onkeypress="validaSoloNumerosConPunto();">
    		</div>
  		</div>
  		<br>
  		
  		<div id="divNombreCliente" class="form-group" style="display:none;">
    		<label for="nombreClienteValue" class="col-md-4 col-lg-4 control-label">Cliente</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="nombreClienteValue"  name="nombreClienteValue" value="">
    		</div>
  		</div>
  		  		
  		<div id="divCtaCteImporte" class="form-group" style="display:none;">
    		<label for="importeCtaCte" class="col-md-4 col-lg-4 control-label">Pago con $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="importeCtaCte"  name="importeCtaCte" value="" onkeypress="validaSoloNumerosConPunto();">
    		</div>
  		</div>
  		<div id="divCtaCteSaldo" class="form-group" style="display:none;">
    		<label for="saldoCtaCteDisabled" class="col-md-4 col-lg-4 control-label">Saldo $</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="saldoCtaCteDisabled"  name="saldoCtaCteDisabled" value="" disabled="disabled">
    		</div>
  		</div>
  		
  		
  		<div class="form-group">
  			<label for="button" class="col-md-4 col-lg-4 control-label"></label>
    		<div class="col-md-4 col-lg-4">
      			<button id="aceptar" type="submit" class="btn btn-info">Aceptar</button>
    		</div>
   		</div>	
 		
    </s:form>
   
    	
