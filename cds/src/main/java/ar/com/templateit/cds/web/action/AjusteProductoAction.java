package ar.com.templateit.cds.web.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import ar.com.templateit.cds.web.bo.AjusteBO;
import ar.com.templateit.cds.web.bo.AlertaBO;
import ar.com.templateit.cds.web.bo.MotivoAjusteBO;
import ar.com.templateit.cds.web.bo.ProductoBO;
import ar.com.templateit.cds.web.entity.Ajuste;
import ar.com.templateit.cds.web.entity.Alerta;
import ar.com.templateit.cds.web.entity.MotivoAjuste;
import ar.com.templateit.cds.web.entity.Producto;
import ar.com.templateit.cds.web.entity.Usuario;
import ar.com.templateit.cds.web.util.TemplateUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class AjusteProductoAction extends ActionSupport{

	private static final long serialVersionUID = -5606983824796374521L;
	private String motivo;
	private List<MotivoAjuste> motivos;
	private String defaultMotivo;
	private List<Ajuste> listaAjustes;
	private Date fechaDesde;
	private Date fechaHasta;
	private Long codigoFilter; 
	private String nombreFilter;
	private String descripcion;
	private Ajuste ajuste;
	private Long idProducto;
	private boolean fraccionable;
	private String pesoConAjuste;
	
	
	private AjusteBO ajusteBO;
	private ProductoBO productoBO;
	private MotivoAjusteBO motivoAjusteBO;
	private AlertaBO alertaBO;
	
	public String ajusteProducto() {
		this.listaAjustes = this.ajusteBO.loadAllAjuste();
		return "ajusteProducto";
	}

	public String loadAjusteProducto() {
		this.ajuste = new Ajuste();
		this.motivos = this.motivoAjusteBO.loadAllMotivoAjuste();
		setDefaultMotivo("-1");
		
		return "loadAjusteProducto";
	}
	
	public String search() {
		this.listaAjustes = this.ajusteBO.findByCriteria(fechaDesde, fechaHasta, codigoFilter, nombreFilter,"");
		return "searchAjusteProducto";
	}
	
	public String save() {
		Producto producto = this.productoBO.getProducto(this.getIdProducto());
		
		this.getAjuste().setFechaAjuste(new Date());
		this.getAjuste().setCodigo(producto.getCodigo());
		this.getAjuste().setNombre(producto.getNombre());
		this.getAjuste().setDescripcion(producto.getDescripcion());
		this.getAjuste().setMarca("");
		this.getAjuste().setFraccionable(this.isFraccionable());
		
		MotivoAjuste motivoAjuste = this.motivoAjusteBO.getMotivoAjuste(Long.valueOf(this.getMotivo()));
		this.getAjuste().setMotivoAjuste(motivoAjuste);
		
		Usuario usuario = (Usuario)ActionContext.getContext().getSession().get("usuario");
		this.getAjuste().setUsuario(usuario);
		
		//Se actualiza la cantidad de productos existentes
		String pesoDefinitivo="";
				
		if (this.isFraccionable()) {
			this.getAjuste().setPesoSinAjuste(producto.getPeso());
			boolean valor = this.getPesoConAjuste().endsWith(".0");
			if (valor) {
				pesoDefinitivo = this.getPesoConAjuste() + "0";
				producto.setPeso(new BigDecimal(pesoDefinitivo).setScale(2));
			} else {
				producto.setPeso(new BigDecimal(this.getPesoConAjuste()).setScale(2));
			}
			
			this.getAjuste().setPesoConAjuste(producto.getPeso());
			this.getAjuste().setCantidadConAjuste(0);
			this.getAjuste().setCantidadSinAjuste(0);
			
		} else {
			this.getAjuste().setCantidadSinAjuste(producto.getCantidad());
			producto.setCantidad(this.getAjuste().getCantidadConAjuste());
			this.getAjuste().setPesoConAjuste(BigDecimal.ZERO.setScale(2));
			this.getAjuste().setPesoSinAjuste(BigDecimal.ZERO.setScale(2));
		}
		
		this.ajusteBO.save(this.getAjuste());
					
		this.productoBO.update(producto);
		
		if(!producto.getFraccionable().booleanValue()){
			this.cargarAlertas(producto,usuario);
		}
				
		return this.render();
	}
	
	public String render() {
		this.listaAjustes = this.ajusteBO.loadAllAjuste();
		return "render";
	}
	
	public String loadViewAjusteProducto() {
		String id = ServletActionContext.getRequest().getParameter("id");
		this.ajuste = this.ajusteBO.getAjuste(Long.valueOf(id));
		return "loadViewAjusteProducto";
	}
	
	private void cargarAlertas(Producto producto,Usuario usuario){
		TemplateUtil tu = new TemplateUtil();
		Boolean stockCritico = tu.verificarStockCritico(producto.getCantidad(),producto.getStockCritico());
		Alerta alerta = this.alertaBO.findByCode(producto.getCodigo());
		if(stockCritico){
			if(alerta==null){
				Alerta alertaNueva = new Alerta();
					
				alertaNueva.setFechaIngreso(new Date());
				alertaNueva.setCodigo(producto.getCodigo());
				alertaNueva.setNombre(producto.getNombre());
				alertaNueva.setDescripcion(producto.getDescripcion());
				alertaNueva.setMarca(producto.getMarca());
				alertaNueva.setCategoria(producto.getCategoria().getNombre());
				alertaNueva.setCantidadActual(producto.getCantidad());			
				alertaNueva.setUsuario(usuario);
					
				this.alertaBO.save(alertaNueva);
			}
			else{
				alerta.setNombre(producto.getNombre());
				alerta.setDescripcion(producto.getDescripcion());
				alerta.setMarca(producto.getMarca());
				alerta.setCategoria(producto.getCategoria().getNombre());
				alerta.setCantidadActual(producto.getCantidad());
					
				this.alertaBO.update(alerta);
			}
		}
		else{
			if(alerta!=null){
				this.alertaBO.delete(alerta);
			}	
		}
		
	}

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public List<MotivoAjuste> getMotivos() {
		return motivos;
	}

	public void setMotivos(List<MotivoAjuste> motivos) {
		this.motivos = motivos;
	}

	public String getDefaultMotivo() {
		return defaultMotivo;
	}

	public void setDefaultMotivo(String defaultMotivo) {
		this.defaultMotivo = defaultMotivo;
	}
	
	public List<Ajuste> getListaAjustes() {
		return listaAjustes;
	}

	public void setListaAjuste(List<Ajuste> listaAjustes) {
		this.listaAjustes = listaAjustes;
	}
	
	public Date getFechaDesde() {
		return fechaDesde;
	}

	public void setFechaDesde(Date fechaDesde) {
		this.fechaDesde = fechaDesde;
	}

	public Date getFechaHasta() {
		return fechaHasta;
	}

	public void setFechaHasta(Date fechaHasta) {
		this.fechaHasta = fechaHasta;
	}

	public Long getCodigoFilter() {
		return codigoFilter;
	}

	public void setCodigoFilter(Long codigoFilter) {
		this.codigoFilter = codigoFilter;
	}

	public String getNombreFilter() {
		return nombreFilter;
	}

	public void setNombreFilter(String nombreFilter) {
		this.nombreFilter = nombreFilter;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public Ajuste getAjuste() {
		return ajuste;
	}

	public void setAjuste(Ajuste ajuste) {
		this.ajuste = ajuste;
	}
	
	public Long getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(Long idProducto) {
		this.idProducto = idProducto;
	}

	public void setAjusteBO(AjusteBO ajusteBO) {
		this.ajusteBO = ajusteBO;
	}

	public void setProductoBO(ProductoBO productoBO) {
		this.productoBO = productoBO;
	}

	public void setMotivoAjusteBO(MotivoAjusteBO motivoAjusteBO) {
		this.motivoAjusteBO = motivoAjusteBO;
	}

	public void setAlertaBO(AlertaBO alertaBO) {
		this.alertaBO = alertaBO;
	}

	public boolean isFraccionable() {
		return fraccionable;
	}

	public void setFraccionable(boolean fraccionable) {
		this.fraccionable = fraccionable;
	}

	public String getPesoConAjuste() {
		return pesoConAjuste;
	}

	public void setPesoConAjuste(String pesoConAjuste) {
		this.pesoConAjuste = pesoConAjuste;
	}
		
	

}
