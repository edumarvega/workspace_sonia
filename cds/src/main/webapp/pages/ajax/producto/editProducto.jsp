<%@ include file="/pages/template/taglibs.jsp" %>
<s:url action="jsonCategoria_obtenerCategoria" namespace="/" var="obtenerCategoria" />

<script type="text/javascript">

	$(document).ready(function(){
  		
  		var options = { 
  		  		target : '#resultado',
			    success:    function(){ 
			    	//renderAjax('${render}');
			    	changeLinksPagination('resultado','filterForm');
			    	//if($('#idProducto').val().length == 0){
			    		//divNewProducto.dialog('destroy').remove();
					//}
			    	//else{
			    		divEditarProducto.dialog('destroy').remove();
			    		
					//}
			    	
			    } 
		};
  		$('#formEdicionProducto').submit(function() {
  	        $(this).ajaxSubmit(options);
  	        return false;
  	    });
  		
  		
  		/*$('#categoria').change(function(){
  			
  			var id = $("#categoria option:selected").val();
            if(id.length != 0){
            	$.ajax({
					url: '${obtenerCategoria}',
					data: {'id': id}, 
					cache: false,
					type:  'GET',
					dataType: 'json',
					success:  function(data){
						$("#ganancia").val(data.porcentajeGanancia);
						$("#porcentajeGanancia").val(data.porcentajeGanancia);
					}
				});	
            }
            else{
            	$("#ganancia").val('0');
            	$("#porcentajeGanancia").val('0');
            }
  		});*/
  		
  		
  		$( "select" ).change(function() {
			var id = $('select[name=categoria] > option:selected').val();
  			//var id = $(this).val();
            if(id.length!=0){
            	$.ajax({
					url: '${obtenerCategoria}',
					data: {'id': id}, 
					cache: false,
					type:  'GET',
					dataType: 'json',
					success:  function(data){
						
						//$("body > form > #divGanancia > #ganancia").val(data.porcentajeGanancia);
						//$("body > form > #porcentajeGanancia").val(data.porcentajeGanancia);
						$("#ganancia").val(data.porcentajeGanancia);
						$("#porcentajeGanancia").val(data.porcentajeGanancia);
						$("#fraccionable").val(data.fraccionable);
						
						var fraccionable = data.fraccionable;
						if(fraccionable){
							$('#divStockCritico').hide();
						}
						else{
							$('#divStockCritico').show();
						}
					}
				});	
            }
            else{
            	//$("body > form > #divGanancia > #ganancia").val('0');
            	//$("body > form > #porcentajeGanancia").val('0');
            	$("#ganancia").val('0');
            	$("#porcentajeGanancia").val('0');
            	$("#fraccionable").val('false');
            	$('#divStockCritico').show();
            }
		  });
  		/*$('body').on('change', '#categoria', function(){
  			var id = $(this).val();
            if(id.length != 0){
            	$.ajax({
					url: '${obtenerCategoria}',
					data: {'id': id}, 
					cache: false,
					type:  'GET',
					dataType: 'json',
					success:  function(data){
						//$("body > form > #divGanancia > #ganancia").val(data.porcentajeGanancia);
						//$("body > form > #porcentajeGanancia").val(data.porcentajeGanancia);
						$("#ganancia").val(data.porcentajeGanancia);
						$("#porcentajeGanancia").val(data.porcentajeGanancia);
					}
				});	
            }
            else{
            	//$("body > form > #divGanancia > #ganancia").val('0');
            	//$("body > form > #porcentajeGanancia").val('0');
            	$("#ganancia").val('0');
            	$("#porcentajeGanancia").val('0');
            }
  	    });*/
  		
 	});

</script>
   
	<s:form id="formEdicionProducto"  action="abmProducto_update" theme="simple"  cssClass="form-horizontal" role="form">
		<s:hidden id="idProducto" name="producto.id" value="%{producto.id}"/>
		<s:hidden id="cantidadProducto" name="producto.cantidad" value="%{producto.cantidad}"/>
		<s:hidden id="porcentajeGanancia" name="porcentajeGanancia" value="%{porcentajeGanancia}"/>
		<s:hidden id="peso" name="producto.peso" value="%{producto.peso}"/>
		<s:hidden id="fraccionable" name="fraccionable" value="%{fraccionable}"/>
		
  		<div class="form-group">
    		<label for="codigo" class="col-md-3 col-lg-3 control-label">Código</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="codigo" name="producto.codigo"  value="${producto.codigo}" maxlength="13" onkeypress="validaSoloNumeros();" autofocus required>
      			<!--<s:textfield  cssClass="form-control input-sm"  id="codigo" name="producto.codigo"  value="%{producto.codigo}" maxlength="13" onkeypress="validaSoloNumeros();" theme="simple"/>
    		--></div>
  		</div>	
  		<div class="form-group">
    		<label for="nombre" class="col-md-3 col-lg-3 control-label">Nombre</label>
    		<div class="col-md-7 col-lg-7">
      			<input type="text" class="form-control input-sm" id="nombre" name="producto.nombre" value="${producto.nombre}" required>
      			<!--<s:textfield cssClass="form-control input-sm" id="nombre" name="producto.nombre" value="%{producto.nombre}" theme="simple"/>
    		--></div>
  		</div>
  		<div class="form-group">
    		<label for="descripcion" class="col-md-3 col-lg-3 control-label">Descripción</label>
    		<div class="col-md-9 col-lg-9">
      			<input type="text" class="form-control input-sm" id="descripcion"  name="producto.descripcion" value="${producto.descripcion}" required>
      			<!--<s:textfield  cssClass="form-control input-sm" id="descripcion"  name="producto.descripcion" value="%{producto.descripcion}" theme="simple"/>
    		--></div>
  		</div>
  		<div class="form-group">
    		<label for="marca" class="col-md-3 col-lg-3 control-label">Marca</label>
    		<div class="col-md-7 col-lg-7">
      			<input type="text" class="form-control input-sm" id="marca"  name="producto.marca" value="${producto.marca}" required>
      			<!--<s:textfield  cssClass="form-control input-sm" id="marca"  name="producto.marca" value="%{producto.marca}" theme="simple"/>
    		--></div>
  		</div>
  		<div class="form-group">
    		<label for="categoria" class="col-md-3 col-lg-3 control-label">Categoria</label>
    		<div id="divCategoria" class="col-md-4 col-lg-4">
      			<!--<input type="text" class="form-control input-sm" id="categoria" name="categoria" required>-->
      			<s:select 
					list="categorias" 
					listKey="id"   
        			listValue="nombre"
        			id="categoria"
					name="categoria" 
					value="defaultCategoria" theme="simple" cssClass="form-control"/>
      		</div>
  		</div>
  		<div class="form-group">
    		<label for="precio" class="col-md-3 col-lg-3 control-label">% de Ganancia</label>
    		<div id="divGanancia" class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="ganancia" name="ganancia"  value="${porcentajeGanancia}" disabled>
    		</div>
  		</div>
  		<div class="form-group">
    		<label for="precio" class="col-md-3 col-lg-3 control-label">Precio</label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="precio" name="precio"  value="${precio}" onkeypress="validaSoloNumerosConPunto();">
    		</div>
  		</div>
  		<div id="divStockCritico" class="form-group">
    		<label for="stockCritico" class="col-md-3 col-lg-3 control-label">Stock critico</label>
    		<div class="col-md-2 col-lg-2">
      			<input type="text" class="form-control input-sm" id="stockCritico"  name="stockCritico" value="${stockCritico}" onkeypress="validaSoloNumeros();">
    		</div>
  		</div>
  		<div class="form-group">
  			<label for="button" class="col-md-3 col-lg-3 control-label"></label>
    		<div class="col-md-4 col-lg-4">
      			<button type="submit" class="btn btn-info">Aceptar</button>
    		</div>
 		</div>
  		
    </s:form>
    
    

