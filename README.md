# ETH KIPU - Trabajo Práctico Módulo 2: Contrato Inteligente de Subasta en Solidity

## Descripción
Este contrato implementa una subasta con las siguientes características:
- Solo el propietario puede finalizar la subasta.
- Las ofertas deben superar al mejor oferente en al menos un 5%.
- Si una oferta válida se realiza en los últimos 10 minutos, el tiempo se extiende 10 minutos más.
- Los participantes pueden retirar sus excedentes de ofertas anteriores.
- Un usuario no puede ofertar dos veces seguidas.

## Variables principales

| Variable          | Descripción                                   |
|-------------------|-----------------------------------------------|
| `owner`           | Dirección del creador/propietario de la subasta. |
| `mejorOferente`   | Dirección del mejor oferente actual.           |
| `mejorOfertaMonto`| Monto de la mejor oferta actual.               |
| `finSubastaTiempo`| Timestamp que indica cuándo finaliza la subasta. |
| `COMISION_PORCENTAJE` | Comisión fija del 2% aplicada al ganador.     |
| `estaFinalizada`  | Booleano que indica si la subasta fue finalizada. |

## Funciones principales

- `ofertar()`: Permite realizar una oferta si supera el mínimo establecido.
- `finalizarSubasta()`: Solo el propietario puede finalizar y recibir la comisión.
- `reembolsar()`: Permite a los no ganadores retirar sus fondos luego de finalizada la subasta.
- `verGanador()`: Devuelve el mejor oferente y la mejor oferta.
- `verOfertas(address)`: Permite ver las ofertas realizadas por un usuario.
- `retirarExcedente()`: Permite retirar ofertas anteriores al mejor monto.

## Eventos

- `OfertaRealizada(address, uint256)`: Se emite cuando un usuario realiza una oferta válida.
- `SubastaFinalizada(address, uint256)`: Se emite cuando el propietario finaliza la subasta.

---

## Uso

Para usar el contrato:
1. Desplegar.
2. Invocar `ofertar` con el monto en `msg.value` adecuado.
3. Finalizar la subasta con `finalizarSubasta` después del tiempo límite. (Solo puede hacerlo el Owner)
4. Retirar excedentes y reembolsos según corresponda.
