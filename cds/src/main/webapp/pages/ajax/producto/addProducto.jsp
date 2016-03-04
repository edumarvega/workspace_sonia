<%@ include file="/pages/template/taglibs.jsp" %>
<s:url action="producto_loadFilterProducto" namespace="/" var="loadFilterProducto" />
  <script type="text/javascript">
  	$(document).ready(function(){
  	  	
  		var options = { 
  		  		target : '#itemsCompra',
  		  		success:    function(){ 
  					divAddProducto.dialog('destroy').remove();
			    } 
		};
  		$('#formAddProducto').submit(function() {
  	        $(this).ajaxSubmit(options);
  	        return false;
  	    });

  		$("#buscarProducto").click(function(){
  			showModalFilterProducto();		  			
  	  	});

  		$("#cantidadProducto").blur(function(){
   	  		$('#itemNombre').val($('#nombreProducto').val());
  	  		$('#itemCodigo').val($('#codigoProducto').val());
  	  		$('#itemDescripcion').val($('#descripcionProducto').val());		  			
  	  	});
  		
  		$("#peso").blur(function(){
   	  		$('#itemNombre').val($('#nombreProducto').val());
  	  		$('#itemCodigo').val($('#codigoProducto').val());
  	  		$('#itemDescripcion').val($('#descripcionProducto').val());		  			
  	  	});
  		
  		  		
  		$("#precioDeCompra").keyup(function(){
  	  		var valorActual = $(this).val().length;
  	  		var precioCompra = parseFloat($(this).val());
  	  		var ganancia = parseFloat($("#ganancia").val());
  	  	  	
  	  	  	if(valorActual>0){
  	  	  	  	var importeConInteres = (ganancia*precioCompra)/100;
  	  	  	  	var totalConInteres = (precioCompra+importeConInteres).toFixed(2); 
  	  	  		$("#precioDeVenta").val(totalConInteres);
  	  	  		$("#precioDeVentaTmp").val(totalConInteres);	
  	  	  	}
  	  	  	else{
  	  	  		$("#precioDeVenta").val('0.00');
  	  	  		$("#precioDeVentaTmp").val('0.00');
  	  	  	}
  		});
  		
  		
  		
 	});

  	var divBusquedaProducto;
  	function showModalFilterProducto(){
  		divBusquedaProducto = $('<div id="divBusquedaProducto"></div>');
  		divBusquedaProducto.dialog({
			   title: 'Busqueda de producto',
			   modal: true,
			   width: 1024,
			   height: 560,
			   position: 'center',
			   hide: "scale",
			   close: function() {
		       		$(this).dialog('destroy').remove();
		       },
			}).load('${loadFilterProducto}',function(){
					$(this).unblock();
					$("#codigo").focus();
					$("#precioDeCompra").val('');
					$("#precioDeVenta").val('');
					$("#precioDeVentaTmp").val('');
	  			}).block({ message: '<h5><img src="${appCtx}/images/loading.gif"/> Procesando...</h5>' });
		
	}

  	/*function validaSoloNumeros(){
		if ((event.keyCode < 48) || (event.keyCode > 57)) 
			event.returnValue = false;
	}*/
  	
   </script>
	<s:form id="formAddProducto"  action="ingresoProducto_addProducto" theme="simple"  cssClass="form-horizontal" role="form">
		<s:hidden id="itemNombre" name="item.nombre" value=""/>
		<s:hidden id="itemCodigo" name="item.codigo" value=""/>
		<s:hidden id="itemDescripcion" name="item.descripcion" value=""/>
		<s:hidden id="precioDeVenta" name="precioDeVenta" value=""/>
		<s:hidden id="fraccionable" name="fraccionable" value=""/>
		 	 		 			
  		<div class="form-group">
    		<label for="cantidad" class="col-md-3 col-lg-3 control-label">Nombre</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="nombreProducto"  name="nombreProducto" value="" disabled="disabled">
    		</div>
    		<div class="col-md-0 col-lg-0">
      			<img id="buscarProducto" src="${appCtx}/images/iconos/lupaOver.gif"  alt="Buscar producto">
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="codigo" class="col-md-3 col-lg-3 control-label">C&oacute;digo</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="codigoProducto"  name="codigoProducto" value="" disabled="disabled">
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="descripcion" class="col-md-3 col-lg-3 control-label">Descripci&oacute;n</label>
    		<div class="col-md-9 col-lg-9">
      			<input type="text" class="form-control input-sm" id="descripcionProducto"  name="descripcionProducto" value="" disabled="disabled">
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="ganancia" class="col-md-3 col-lg-3 control-label">% de ganancia</label>
    		<div class="col-md-3 col-lg-3">
      			<input type="text" class="form-control input-sm" id="ganancia"  name="ganancia" value="" onkeypress="validaSoloNumerosConPunto();" required>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="precio" class="col-md-3 col-lg-3 control-label">Precio de compra</label>
    		<div class="col-md-3 col-lg-3">
      			<input type="text" class="form-control input-sm" id="precioDeCompra"  name="precioDeCompra" value="" onkeypress="validaSoloNumerosConPunto();" autofocus required>
    		</div>
  		</div>
  		  		
  		  		
  		<div class="form-group">
    		<label for="precio" class="col-md-3 col-lg-3 control-label">Precio de venta</label>
    		<div class="col-md-3 col-lg-3">
      			<input type="text" class="form-control input-sm" id="precioDeVentaTmp"  name="precioDeVentaTmp" value="" disabled>
    		</div>
  		</div>
  		
		<div id="divCantidad" class="form-group">
    		<label for="cantidad" class="col-md-3 col-lg-3 control-label">Cantidad</label>
    		<div class="col-md-2 col-lg-2">
      			<input type="text" class="form-control input-sm" id="cantidadProducto"  name="item.cantidad" value="" onkeypress="validaSoloNumeros();">
    		</div>
  		</div>  	
  		
  		<div id="divPeso" class="form-group" style="display:none;">
    		<label for="peso" class="col-md-3 col-lg-3 control-label">Peso Kg</label>
    		<div class="col-md-2 col-lg-2">
      			<input type="text" class="form-control input-sm" id="peso"  name="peso" value="" onkeypress="validaSoloNumerosConPunto();">
    		</div>
  		</div> 	
  		   		
  		<div class="form-group">
  			<label for="button" class="col-md-3 col-lg-3 control-label"></label>
    		<div class="col-md-4 col-lg-4">
      			<button type="submit" class="btn btn-info">Aceptar</button>
    		</div>
    	</div>	
    </s:form>
    <!--<div id="divBusquedaProducto" style="display:none;"></div> -->
    	
