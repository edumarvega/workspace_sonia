package ar.com.templateit.cds.web.bo;

import java.util.List;

import ar.com.templateit.cds.web.entity.TarjetaDeCredito;

public interface TarjetaDeCreditoBO {
	
	TarjetaDeCredito getTarjetaDeCredito(Long id);

	List<TarjetaDeCredito> loadAllTarjetaDeCredito();

}
