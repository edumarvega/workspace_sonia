	<%@ include file="/pages/template/taglibs.jsp" %>
	<br>
	<span style="color:#2aabd2; font-size: 14px; font-weight:bold;">Resultado</span>
	<br>
	<div class="displayTable">
		<display:table id="data" name="listaAjustes" requestURI="/ajusteProducto_search.do" pagesize="10" class="table table-striped table-condensed" excludedParams="*">
			<display:column  media="html">
				<input type="checkbox" name="idAjuste" value="${data.id}"/>
			</display:column>
			<display:column property="fechaAjuste" title="Fecha de ajuste" format="{0,date,dd/MM/yyyy}" sortable="true"/>
			<display:column property="codigo" title="C&oacute;digo" sortable="true"/>
			<display:column property="nombre" title="Nombre" sortable="true" />
			<display:column property="descripcion" title="Descripci&oacute;n"/>
			<display:column title="Stock anterior">
				<cw:choose>
    				<cw:when test="${data.fraccionable==true}">
    					${data.pesoSinAjuste}&nbsp;Kg.
        		    </cw:when>    
    				<cw:otherwise>
    					${data.cantidadSinAjuste}
        			</cw:otherwise>
				</cw:choose>
			</display:column>
			
			<display:column title="Stock actual">
				<cw:choose>
    				<cw:when test="${data.fraccionable==true}">
    					${data.pesoConAjuste}&nbsp;Kg.
        		    </cw:when>    
    				<cw:otherwise>
    					${data.cantidadConAjuste}
        			</cw:otherwise>
				</cw:choose>
			</display:column>
			<display:setProperty name="export.excel.filename" value="Ajustes.xls"/>
        	<display:setProperty name="export.pdf.filename" value="Ajustes.pdf"/>
        	<display:setProperty name="export.pdf" value="true" />
        	<display:setProperty name="export.excel" value="true" />
        	<display:setProperty name="export.csv" value="false" />
        	<display:setProperty name="export.xml" value="false" />
		</display:table>
	</div>
