<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/pages/template/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="es">
<body>
	<div id="divPrint">
		<s:form id="formViewCliente"  action="abmCliente_saveOrUpdate" theme="simple"  cssClass="form-horizontal" role="form">
		  			
  		 		  		
  		<div class="form-group">
    		<label for="apellido" class="col-sm-4 control-label">Apellido</label>
    		<div class="col-sm-5">
      			<p class="form-control-static"><s:property value="cliente.apellido"/></p>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="nombre" class="col-sm-4 control-label">Nombres</label>
    		<div class="col-sm-5">
      			<p class="form-control-static"><s:property value="cliente.nombres"/></p>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="direccion" class="col-sm-4 control-label">Direccion</label>
    		<div class="col-sm-5">
      			<p class="form-control-static"><s:property value="cliente.direccion"/></p>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="telefono" class="col-sm-4 control-label">Telefono</label>
    		<div class="col-sm-5">
      			<p class="form-control-static"><s:property value="cliente.telefono"/></p>
    		</div>
  		</div>
  		
  		<div class="form-group">
    		<label for="celular" class="col-sm-4 control-label">Celular</label>
    		<div class="col-sm-5">
      			<p class="form-control-static"><s:property value="cliente.celular"/></p>
    		</div>
  		</div>
  		
  		
    </s:form>
	
    </div>
</body>
</html>