<%@ include file="/pages/template/taglibs.jsp" %>
  <script type="text/javascript">
  	$(document).ready(function(){	
  	  	
  		var options = { 
  		  		target : '#resultado',
			    success:    function(){ 
  					changeLinksPagination('resultado','filterForm');
			    	divNewCategoria.dialog('destroy').remove();
			    } 
		};
  		$('#formAltaCategoria').submit(function() {
  	        $(this).ajaxSubmit(options);
  	        return false;
  	    });
  		
  		 $("#fraccionable").click(function() {  
  	        if($("#fraccionable").is(':checked')) {  
  	        	$("#fraccionable").attr('checked', true);
  	        	$("#fraccionable").val('true'); 
  	        } else {  
  	        	$("#fraccionable").attr('checked', false);
  	        	$("#fraccionable").val('false'); 
  	        }  
  	    });
  		
 	});
   </script>
	<s:form id="formAltaCategoria"  action="abmCategoria_save" theme="simple"  cssClass="form-horizontal" role="form">
		<s:hidden id="idCategoria" name="categoria.id" value=""/>
  		  			
  		<div class="form-group">
    		<label for="nombre" class="col-md-4 col-lg-4 control-label">Nombre</label>
    		<div class="col-md-5 col-lg-5">
      			<input type="text" class="form-control input-sm" id="nombre" name="categoria.nombre" value="" autofocus required>
    		</div>
  		</div>
  		<div class="form-group">
    		<label for="precio" class="col-md-4 col-lg-4 control-label">Ganancia % </label>
    		<div class="col-md-4 col-lg-4">
      			<input type="text" class="form-control input-sm" id="porcentajeGanancia" name="porcentajeGanancia"  value="" placeholder="0.00" onkeypress="validaSoloNumerosConPunto();" required>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="fraccionable" class="col-md-4 col-lg-4 control-label">Fraccionable</label>
    		<div class="col-md-5 col-lg-5">
      			<s:checkbox id="fraccionable" name="fraccionable"  fieldValue="false"/>
    		</div>
  		</div>
  		
  				
  		<div class="form-group">
  			<label for="button" class="col-md-4 col-lg-4 control-label"></label>
    		<div class="col-md-4 col-lg-4">
      			<button type="submit" class="btn btn-info">Aceptar</button>
    		</div>
    	</div>	
    </s:form>
    	
