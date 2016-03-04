package ar.com.templateit.cds.web.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class Categoria implements Serializable{

	private static final long serialVersionUID = 3618306304722163805L;
	private Long id;
	private String nombre;
	private BigDecimal porcentajeGanancia;
	private Boolean fraccionable;
	
	public Categoria(){
	}
	
	public Categoria(Long id, String nombre,BigDecimal porcentajeGanancia,Boolean fraccionable){
		this.id = id;
		this.nombre = nombre;
		this.porcentajeGanancia = porcentajeGanancia;
		this.fraccionable = fraccionable;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public BigDecimal getPorcentajeGanancia() {
		return porcentajeGanancia;
	}

	public void setPorcentajeGanancia(BigDecimal porcentajeGanancia) {
		this.porcentajeGanancia = porcentajeGanancia;
	}

	public Boolean getFraccionable() {
		return fraccionable;
	}

	public void setFraccionable(Boolean fraccionable) {
		this.fraccionable = fraccionable;
	}
	
	
	
}
